namespace TravelDecisionEngine.Infrastructure.ExternalServices.GoogleMaps;

using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.Logging;

public interface IGoogleMapsService
{
    Task<string> OptimizeRouteAsync(CancellationToken cancellationToken);
}

public class GoogleMapsService : IGoogleMapsService
{
    private readonly IConfiguration _configuration;
    private readonly ILogger<GoogleMapsService> _logger;

    public GoogleMapsService(IConfiguration configuration, ILogger<GoogleMapsService> logger)
    {
        _configuration = configuration;
        _logger = logger;
    }

    public Task<string> OptimizeRouteAsync(CancellationToken cancellationToken)
    {
        _ = cancellationToken;
        if (string.IsNullOrWhiteSpace(_configuration["GoogleMaps:ApiKey"]))
        {
            _logger.LogWarning("Google Maps route optimization is disabled because GoogleMaps.ApiKey is not configured.");
            return Task.FromResult("Google Maps route optimization is unavailable because the API key is not configured.");
        }

        return Task.FromResult("TODO: Integrate Google Maps SDK route optimization API.");
    }
}
