using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using TravelDecisionEngine.Domain.Entities;
using TravelDecisionEngine.Infrastructure.Database;

namespace TravelDecisionEngine.Api.Controllers;

[Route("api/purchase")]
public class PurchaseController : ApiControllerBase
{
    private static readonly PurchasePlan[] DefaultPlans =
    [
        new("basic", Guid.Parse("30000000-0000-0000-0000-000000000001"), "Basic Plan", 7, 15m, "basic"),
        new("premium", Guid.Parse("30000000-0000-0000-0000-000000000002"), "Premium Plan", 14, 25m, "premium"),
        new("pro", Guid.Parse("30000000-0000-0000-0000-000000000003"), "Pro Plan", 30, 39m, "pro")
    ];

    private readonly TravelDecisionEngineDbContext _db;

    public PurchaseController(TravelDecisionEngineDbContext db)
    {
        _db = db;
    }

    [AllowAnonymous]
    [HttpGet("plans")]
    public async Task<IActionResult> GetPlans(CancellationToken cancellationToken)
    {
        var plans = await _db.SubscriptionPlans
            .Where(x => EF.Property<string>(x, "Status") == "active")
            .Select(x => new
            {
                id = x.Id,
                name = EF.Property<string>(x, "Name"),
                durationDays = EF.Property<int>(x, "DurationDays"),
                price = EF.Property<decimal>(x, "Price"),
                tier = EF.Property<string>(x, "Tier")
            })
            .ToListAsync(cancellationToken);

        var data = plans.Count > 0
            ? plans.Select(x => new
            {
                id = (object)x.id,
                x.name,
                duration = $"{x.durationDays} Days",
                x.price,
                features = FeaturesForTier(x.tier),
                popular = string.Equals(x.tier, "premium", StringComparison.OrdinalIgnoreCase)
            })
            : DefaultPlans.Select(x => new
            {
                id = (object)x.Code,
                name = x.Name,
                duration = $"{x.DurationDays} Days",
                price = x.Price,
                features = FeaturesForTier(x.Tier),
                popular = x.Code == "premium"
            });

        return Ok(new { success = true, message = "Purchase plans loaded", data });
    }

    [Authorize]
    [HttpGet("status")]
    public async Task<IActionResult> GetStatus(CancellationToken cancellationToken)
    {
        var userId = GetUserIdOrThrow();
        var now = DateTime.UtcNow;

        var transactions = await _db.Transactions
            .Where(x => EF.Property<Guid>(x, "UserId") == userId)
            .Where(x => EF.Property<string>(x, "Status") == "paid"
                || EF.Property<string>(x, "Status") == "completed"
                || EF.Property<string>(x, "Status") == "confirmed")
            .Select(x => new
            {
                x.Id,
                planId = EF.Property<Guid>(x, "PlanId"),
                paidAt = EF.Property<DateTime?>(x, "PaidAt")
            })
            .ToListAsync(cancellationToken);

        var latestActive = default((Guid planId, DateTime paidAt, DateTime expiresAt)?);
        foreach (var transaction in transactions.Where(x => x.paidAt.HasValue).OrderByDescending(x => x.paidAt))
        {
            var durationDays = await DurationDaysForPlanAsync(transaction.planId, cancellationToken);
            var expiresAt = transaction.paidAt!.Value.AddDays(durationDays);
            if (expiresAt >= now)
            {
                latestActive = (transaction.planId, transaction.paidAt.Value, expiresAt);
                break;
            }
        }

        var activePlan = latestActive;
        var active = activePlan.HasValue;
        return Ok(new
        {
            success = true,
            message = "Purchase status loaded",
            data = new
            {
                active,
                isActive = active,
                hasActivePlan = active,
                planId = activePlan?.planId,
                paidAt = activePlan?.paidAt,
                expiresAt = activePlan?.expiresAt,
                quotaRemaining = active ? 999 : 0,
                remainingTrips = active ? 999 : 0
            }
        });
    }

    [Authorize]
    [HttpPost("checkout")]
    public async Task<IActionResult> Checkout([FromBody] CheckoutRequest request, CancellationToken cancellationToken)
    {
        var userId = GetUserIdOrThrow();
        var plan = ResolvePlan(request.PlanId, request.PlanName);
        await EnsurePlanExistsAsync(plan, cancellationToken);

        var transaction = new Transaction { Id = Guid.NewGuid() };
        _db.Transactions.Add(transaction);
        _db.Entry(transaction).Property("UserId").CurrentValue = userId;
        _db.Entry(transaction).Property("PlanId").CurrentValue = plan.Id;
        _db.Entry(transaction).Property("Amount").CurrentValue = request.Amount ?? plan.Price;
        _db.Entry(transaction).Property("Currency").CurrentValue = string.IsNullOrWhiteSpace(request.Currency) ? "USD" : request.Currency;
        _db.Entry(transaction).Property("Status").CurrentValue = "paid";
        _db.Entry(transaction).Property("PaidAt").CurrentValue = DateTime.UtcNow;
        _db.Entry(transaction).Property("CreatedAt").CurrentValue = DateTime.UtcNow;

        await _db.SaveChangesAsync(cancellationToken);

        return Ok(new
        {
            success = true,
            message = "Purchase completed",
            data = new
            {
                id = transaction.Id,
                transactionId = transaction.Id,
                planId = plan.Id,
                active = true
            }
        });
    }

    private async Task EnsurePlanExistsAsync(PurchasePlan plan, CancellationToken cancellationToken)
    {
        var existing = await _db.SubscriptionPlans.FindAsync([plan.Id], cancellationToken);
        if (existing is not null) return;

        var entity = new SubscriptionPlan { Id = plan.Id };
        _db.SubscriptionPlans.Add(entity);
        _db.Entry(entity).Property("Name").CurrentValue = plan.Name;
        _db.Entry(entity).Property("DurationDays").CurrentValue = plan.DurationDays;
        _db.Entry(entity).Property("Price").CurrentValue = plan.Price;
        _db.Entry(entity).Property("Tier").CurrentValue = plan.Tier;
        _db.Entry(entity).Property("Status").CurrentValue = "active";
        _db.Entry(entity).Property("CreatedAt").CurrentValue = DateTime.UtcNow;

        await _db.SaveChangesAsync(cancellationToken);
    }

    private async Task<int> DurationDaysForPlanAsync(Guid planId, CancellationToken cancellationToken)
    {
        var duration = await _db.SubscriptionPlans
            .Where(x => x.Id == planId)
            .Select(x => EF.Property<int>(x, "DurationDays"))
            .FirstOrDefaultAsync(cancellationToken);

        return duration > 0 ? duration : 7;
    }

    private static PurchasePlan ResolvePlan(string? planId, string? planName)
    {
        if (Guid.TryParse(planId, out var parsed))
        {
            return DefaultPlans.FirstOrDefault(x => x.Id == parsed)
                ?? new PurchasePlan(parsed.ToString(), parsed, string.IsNullOrWhiteSpace(planName) ? "Travel Plan" : planName, 7, 15m, "custom");
        }

        return DefaultPlans.FirstOrDefault(x => string.Equals(x.Code, planId, StringComparison.OrdinalIgnoreCase))
            ?? DefaultPlans.First(x => x.Code == "premium");
    }

    private static string[] FeaturesForTier(string tier)
    {
        var features = new List<string>
        {
            "Unlimited Planning",
            "Full Map Access",
            "Smart AI Suggestions"
        };

        if (string.Equals(tier, "premium", StringComparison.OrdinalIgnoreCase)
            || string.Equals(tier, "pro", StringComparison.OrdinalIgnoreCase))
        {
            features.Add("Premium Features");
        }

        if (string.Equals(tier, "pro", StringComparison.OrdinalIgnoreCase))
        {
            features.Add("Priority Support");
        }

        return features.ToArray();
    }

    private sealed record PurchasePlan(string Code, Guid Id, string Name, int DurationDays, decimal Price, string Tier);

    public sealed record CheckoutRequest(
        string? PlanId,
        string? PlanName,
        decimal? Amount,
        string? Currency);
}
