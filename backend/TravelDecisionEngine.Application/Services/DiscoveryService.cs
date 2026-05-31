using TravelDecisionEngine.Application.Interfaces;

namespace TravelDecisionEngine.Application.Services;

public class DiscoveryService : IDiscoveryService
{
    public Task<object> ExecuteAsync(CancellationToken cancellationToken)
    {
        _ = cancellationToken;
        return Task.FromResult<object>(new { module = "Discovery", status = "TODO" });
    }
}

