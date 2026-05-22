namespace TravelDecisionEngine.Infrastructure.Notifications;

public interface INotificationScheduler
{
    Task ScheduleCheckInAsync(Guid userId, DateTime checkInTimeUtc, CancellationToken cancellationToken);
    Task ScheduleCheckOutAsync(Guid userId, DateOnly checkOutDate, CancellationToken cancellationToken);
}

public class NotificationScheduler : INotificationScheduler
{
    public Task ScheduleCheckInAsync(Guid userId, DateTime checkInTimeUtc, CancellationToken cancellationToken)
    {
        // TODO(Sprint 9-10): Schedule push exactly 2 hours before check-in.
        _ = userId;
        _ = checkInTimeUtc;
        _ = cancellationToken;
        return Task.CompletedTask;
    }

    public Task ScheduleCheckOutAsync(Guid userId, DateOnly checkOutDate, CancellationToken cancellationToken)
    {
        // TODO(Sprint 9-10): Schedule push at 10:00 AM on checkout day.
        _ = userId;
        _ = checkOutDate;
        _ = cancellationToken;
        return Task.CompletedTask;
    }
}

