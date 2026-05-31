using TravelDecisionEngine.Application.Interfaces;

namespace TravelDecisionEngine.Application.Services;

public class CheckpointsService : ICheckpointsService
{
    public Task<object> ExecuteAsync(CancellationToken cancellationToken)
    {
        _ = cancellationToken;
        return Task.FromResult<object>(new { module = "Checkpoints", status = "TODO" });
    }
}

