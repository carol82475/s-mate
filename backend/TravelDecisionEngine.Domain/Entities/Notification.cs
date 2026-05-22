using TravelDecisionEngine.Domain.Enums;

namespace TravelDecisionEngine.Domain.Entities;

public class Notification
{
    public Guid NotificationId { get; set; }
    public Guid UserId { get; set; }
    public string Type { get; set; } = string.Empty;
    public string Title { get; set; } = string.Empty;
    public string Content { get; set; } = string.Empty;
    public bool IsRead { get; set; }
    public NotificationPriority Priority { get; set; } = NotificationPriority.Suggestion;
    public DateTime CreatedAt { get; set; } = DateTime.UtcNow;
}
