using TravelDecisionEngine.Application.Interfaces;

namespace TravelDecisionEngine.Application.Services;

public class TripDaysService : ITripDaysService
{
    public Task<object> ExecuteAsync(CancellationToken cancellationToken)
    {
        _ = cancellationToken;
        return Task.FromResult<object>(new { module = "TripDays", status = "TODO" });
    }
}

