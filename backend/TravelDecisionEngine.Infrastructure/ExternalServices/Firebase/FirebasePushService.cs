namespace TravelDecisionEngine.Infrastructure.ExternalServices.Firebase;

using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.Logging;

public interface IFirebasePushService
{
    Task SendAsync(Guid userId, string title, string body, CancellationToken cancellationToken);
}

public class FirebasePushService : IFirebasePushService
{
    private readonly IConfiguration _configuration;
    private readonly ILogger<FirebasePushService> _logger;

    public FirebasePushService(IConfiguration configuration, ILogger<FirebasePushService> logger)
    {
        _configuration = configuration;
        _logger = logger;
    }

    public Task SendAsync(Guid userId, string title, string body, CancellationToken cancellationToken)
    {
        _ = userId;
        _ = title;
        _ = body;
        _ = cancellationToken;
        var serviceAccountPath = _configuration["Firebase:ServiceAccountJsonPath"];
        if (string.IsNullOrWhiteSpace(serviceAccountPath) || !File.Exists(serviceAccountPath))
        {
            _logger.LogWarning("Firebase push is disabled because Firebase.ServiceAccountJsonPath is missing or the file does not exist.");
            return Task.CompletedTask;
        }

        // TODO(Sprint 9-10): Integrate Firebase Cloud Messaging.
        return Task.CompletedTask;
    }
}
