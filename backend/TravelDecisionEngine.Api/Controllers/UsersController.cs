using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using TravelDecisionEngine.Application.DTOs.Users;
using TravelDecisionEngine.Application.Interfaces;
using TravelDecisionEngine.Infrastructure.Database;

namespace TravelDecisionEngine.Api.Controllers;

[Authorize]
[Route("api/users")]
public class UsersController : ApiControllerBase
{
    private readonly IUsersService _users;
    private readonly TravelDecisionEngineDbContext _db;

    public UsersController(IUsersService users, TravelDecisionEngineDbContext db)
    {
        _users = users;
        _db = db;
    }

    [HttpGet("me")]
    [HttpGet("profile")]
    public async Task<IActionResult> GetMe(CancellationToken cancellationToken)
        => Ok(new { success = true, message = "Profile loaded", data = await _users.GetMeAsync(GetUserIdOrThrow(), cancellationToken) });

    [HttpPut("me")]
    [HttpPut("profile")]
    public async Task<IActionResult> UpdateMe([FromBody] UpdateUserProfileRequest request, CancellationToken cancellationToken)
    {
        Console.WriteLine($"[UpdateMe] FullName: '{request.FullName}', Location: '{request.Location}', Nationality: '{request.Nationality}'");
        var result = await _users.UpdateMeAsync(GetUserIdOrThrow(), request, cancellationToken);
        return Ok(new { success = true, message = "Profile updated", data = result });
    }

    [HttpPut("me/preferences")]
    public async Task<IActionResult> UpdatePreferences([FromBody] UpdatePreferencesRequest request, CancellationToken cancellationToken)
        => Ok(new { success = true, message = "Preferences updated", data = await _users.UpdatePreferencesAsync(GetUserIdOrThrow(), request, cancellationToken) });

    [HttpPut("me/language")]
    public async Task<IActionResult> UpdateLanguage([FromBody] UpdateLanguageRequest request, CancellationToken cancellationToken)
        => Ok(new { success = true, message = "Language updated", data = await _users.UpdateLanguageAsync(GetUserIdOrThrow(), request, cancellationToken) });

    [HttpPut("me/privacy")]
    public async Task<IActionResult> UpdatePrivacy([FromBody] UpdatePrivacyRequest request, CancellationToken cancellationToken)
    {
        await _users.UpdatePrivacyAsync(GetUserIdOrThrow(), request, cancellationToken);
        return Ok(new { success = true, message = "Privacy updated", data = new { } });
    }

    /// <summary>GET /users/stats — trip/country/day counts for profile screen.</summary>
    [HttpGet("stats")]
    public async Task<IActionResult> GetStats(CancellationToken cancellationToken)
    {
        var userId = GetUserIdOrThrow();
        var tripCount = await _db.Trips.CountAsync(t => t.UserId == userId, cancellationToken);
        return Ok(new
        {
            success = true,
            message = "Stats loaded",
            data = new { trips = tripCount, countries = 0, locations = 0, days = 0 }
        });
    }

    /// <summary>GET /users/trip-history — paginated trips for profile screen.</summary>
    [HttpGet("trip-history")]
    public async Task<IActionResult> GetTripHistory(CancellationToken cancellationToken)
    {
        var userId = GetUserIdOrThrow();
        var trips = await _db.Trips
            .Where(t => t.UserId == userId)
            .OrderByDescending(t => t.CreatedAt)
            .Take(20)
            .Select(t => new
            {
                id = t.TripId,
                destination = t.Destination,
                dates = $"{t.StartDate:MMM d} - {t.EndDate:MMM d, yyyy}",
                status = t.Status,
                progress = 0.0
            })
            .ToListAsync(cancellationToken);

        return Ok(new { success = true, message = "Trip history loaded", data = trips });
    }

    /// <summary>PUT /users/settings — updates language, privacy in one call (profile_screen.dart).</summary>
    [HttpPut("settings")]
    public async Task<IActionResult> UpdateSettings([FromBody] UpdateSettingsRequest request, CancellationToken cancellationToken)
    {
        var userId = GetUserIdOrThrow();

        if (!string.IsNullOrWhiteSpace(request.Language))
        {
            await _users.UpdateLanguageAsync(userId, new UpdateLanguageRequest { LanguageCode = request.Language }, cancellationToken);
        }

        if (request.ShareLocation.HasValue || request.ShowProfilePublicly.HasValue)
        {
            await _users.UpdatePrivacyAsync(userId, new UpdatePrivacyRequest
            {
                ShareLocation = request.ShareLocation ?? false,
                ShowProfilePublicly = request.ShowProfilePublicly ?? true
            }, cancellationToken);
        }

        return Ok(new { success = true, message = "Settings updated", data = new { } });
    }

    [HttpPost("change-password")]
    public async Task<IActionResult> ChangePassword([FromBody] ChangePasswordRequest request, CancellationToken cancellationToken)
    {
        await _users.ChangePasswordAsync(GetUserIdOrThrow(), request.NewPassword, cancellationToken);
        return Ok(new { success = true, message = "Password changed", data = new { } });
    }
}
