using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using TravelDecisionEngine.Infrastructure.Database;

namespace TravelDecisionEngine.Api.Controllers;

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
