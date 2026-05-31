using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using TravelDecisionEngine.Infrastructure.Database;

namespace TravelDecisionEngine.Api.Controllers;

[Authorize]
[Route("api/travelers")]
public class TravelersController : ApiControllerBase
{
    private readonly TravelDecisionEngineDbContext _db;

    public TravelersController(TravelDecisionEngineDbContext db)
    {
        _db = db;
    }

    [HttpPost("opt-in")]
    public IActionResult OptIn()
        => Ok(new { success = true, message = "Traveler mode enabled", data = new { locationGranularity = "district" } });

    [HttpPost("opt-out")]
    public IActionResult OptOut()
        => Ok(new { success = true, message = "Traveler mode disabled", data = new { } });

    [HttpGet("nearby")]
    public IActionResult Nearby()
        => Ok(new { success = true, message = "Nearby travelers", data = Array.Empty<object>(), note = "Exact location is never shared." });

    [HttpPost("connection-requests")]
    public IActionResult CreateConnectionRequest()
        => Ok(new { success = true, message = "Connection request sent", data = new { } });

    [HttpGet("connection-requests")]
    public IActionResult GetConnectionRequests()
        => Ok(new { success = true, message = "Connection requests", data = Array.Empty<object>() });

    [HttpPost("connection-requests/{requestId:guid}/accept")]
    public IActionResult Accept([FromRoute] Guid requestId)
        => Ok(new { success = true, message = "Connection accepted", data = new { requestId, chatUnlocked = true } });

    [HttpPost("connection-requests/{requestId:guid}/reject")]
    public IActionResult Reject([FromRoute] Guid requestId)
        => Ok(new { success = true, message = "Connection rejected", data = new { requestId } });

    [HttpPost("{userId:guid}/block")]
    public IActionResult Block([FromRoute] Guid userId)
        => Ok(new { success = true, message = "User blocked", data = new { userId } });
}

[Authorize]
[Route("api/notifications")]
public class NotificationsController : ApiControllerBase
{
    private readonly TravelDecisionEngineDbContext _db;

    public NotificationsController(TravelDecisionEngineDbContext db)
    {
        _db = db;
    }

    [HttpGet]
    public async Task<IActionResult> GetNotifications(CancellationToken cancellationToken)
    {
        var rows = await _db.Notifications.Where(x => x.UserId == GetUserIdOrThrow()).OrderByDescending(x => x.CreatedAt).ToListAsync(cancellationToken);
        return Ok(new { success = true, message = "Notifications loaded", data = rows });
    }

    [HttpPut("{notificationId:guid}/read")]
    public async Task<IActionResult> MarkRead([FromRoute] Guid notificationId, CancellationToken cancellationToken)
    {
        var row = await _db.Notifications.FirstOrDefaultAsync(x => x.NotificationId == notificationId && x.UserId == GetUserIdOrThrow(), cancellationToken)
            ?? throw new InvalidOperationException("Notification not found.");

        row.IsRead = true;
        await _db.SaveChangesAsync(cancellationToken);
        return Ok(new { success = true, message = "Notification marked read", data = new { notificationId } });
    }

    [HttpPost("register-device-token")]
    public IActionResult RegisterDeviceToken()
        => Ok(new { success = true, message = "Device token registered", data = new { maxPerDay = 5, priority = "Emergency > Schedule > Suggestion" } });

    [HttpPost("test")]
    public IActionResult TestNotification()
        => Ok(new { success = true, message = "Test notification queued", data = new { } });
}
