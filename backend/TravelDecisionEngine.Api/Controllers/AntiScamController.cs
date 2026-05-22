using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using TravelDecisionEngine.Infrastructure.Database;
using TravelDecisionEngine.Domain.Entities;

namespace TravelDecisionEngine.Api.Controllers;

[Route("api")]
public class AntiScamController : ApiControllerBase
{
    private readonly TravelDecisionEngineDbContext _db;

    public AntiScamController(TravelDecisionEngineDbContext db)
    {
        _db = db;
    }

    [Authorize]
    [HttpPost("anti-scam/check-price")]
    public async Task<IActionResult> CheckPrice([FromBody] PriceReport request, CancellationToken cancellationToken)
    {
        var refs = await _db.PriceReports.Where(x => x.ItemName == request.ItemName && x.Status == "Confirmed").ToListAsync(cancellationToken);
        if (refs.Count == 0)
        {
            return Ok(new { success = true, message = "No reference data", data = new { request.ItemName, status = "Unknown" } });
        }

        var min = refs.Min(x => x.MarketPriceMin);
        var max = refs.Max(x => x.MarketPriceMax);
        var status = request.PriceReported > max ? "PotentialScam" : "Normal";

        return Ok(new { success = true, message = "Price checked", data = new { itemName = request.ItemName, marketMin = min, marketMax = max, status } });
    }

    [Authorize]
    [HttpPost("price-reports")]
    public async Task<IActionResult> CreatePriceReport([FromBody] PriceReport request, CancellationToken cancellationToken)
    {
        request.ReportId = Guid.NewGuid();
        request.UserId = GetUserIdOrThrow();
        request.Status = "Pending";
        request.CreatedAt = DateTime.UtcNow;

        await _db.PriceReports.AddAsync(request, cancellationToken);
        await _db.SaveChangesAsync(cancellationToken);

        return Ok(new { success = true, message = "Price report submitted", data = request });
    }

    [HttpGet("places/{placeId:guid}/price-reports")]
    [AllowAnonymous]
    public async Task<IActionResult> GetPlacePriceReports([FromRoute] Guid placeId, CancellationToken cancellationToken)
    {
        var rows = await _db.PriceReports.Where(x => x.PlaceId == placeId).OrderByDescending(x => x.CreatedAt).Take(50).ToListAsync(cancellationToken);
        return Ok(new { success = true, message = "Price reports loaded", data = rows });
    }

    [Authorize]
    [HttpPost("admin/price-reports/{reportId:guid}/confirm")]
    public async Task<IActionResult> ConfirmPriceReport([FromRoute] Guid reportId, CancellationToken cancellationToken)
    {
        var report = await _db.PriceReports.FirstOrDefaultAsync(x => x.ReportId == reportId, cancellationToken) ?? throw new InvalidOperationException("Report not found.");
        report.Status = "Confirmed";
        report.ConfirmedAt = DateTime.UtcNow;
        await _db.SaveChangesAsync(cancellationToken);
        return Ok(new { success = true, message = "Price report confirmed", data = new { reportId } });
    }

    [Authorize]
    [HttpPost("admin/price-reports/{reportId:guid}/reject")]
    public async Task<IActionResult> RejectPriceReport([FromRoute] Guid reportId, CancellationToken cancellationToken)
    {
        var report = await _db.PriceReports.FirstOrDefaultAsync(x => x.ReportId == reportId, cancellationToken) ?? throw new InvalidOperationException("Report not found.");
        report.Status = "Rejected";
        await _db.SaveChangesAsync(cancellationToken);
        return Ok(new { success = true, message = "Price report rejected", data = new { reportId } });
    }
}
