namespace TravelDecisionEngine.Infrastructure.ExternalServices.AzureBlob;

using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.Logging;

public interface IAzureBlobStorageService
{
    Task<string> UploadAsync(Stream file, string fileName, CancellationToken cancellationToken);
}

public class AzureBlobStorageService : IAzureBlobStorageService
{
    private readonly IConfiguration _configuration;
    private readonly ILogger<AzureBlobStorageService> _logger;

    public AzureBlobStorageService(IConfiguration configuration, ILogger<AzureBlobStorageService> logger)
    {
        _configuration = configuration;
        _logger = logger;
    }

    public Task<string> UploadAsync(Stream file, string fileName, CancellationToken cancellationToken)
    {
        _ = file;
        _ = cancellationToken;
        if (string.IsNullOrWhiteSpace(_configuration["AzureBlob:ConnectionString"])
            || string.IsNullOrWhiteSpace(_configuration["AzureBlob:ContainerName"]))
        {
            _logger.LogWarning("Azure Blob upload is disabled because AzureBlob.ConnectionString or AzureBlob.ContainerName is not configured.");
            return Task.FromResult(string.Empty);
        }

        // TODO(Sprint 9-10): Integrate Azure Blob SDK and CDN URL mapping.
        return Task.FromResult($"https://cdn.placeholder.local/{fileName}");
    }
}
