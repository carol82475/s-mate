using TravelDecisionEngine.Application.Interfaces;

namespace TravelDecisionEngine.Application.Services;

public class AudioGuideService : IAudioGuideService
{
    public Task<object> ExecuteAsync(CancellationToken cancellationToken)
    {
        _ = cancellationToken;
        return Task.FromResult<object>(new { module = "AudioGuide", status = "TODO" });
    }
}

