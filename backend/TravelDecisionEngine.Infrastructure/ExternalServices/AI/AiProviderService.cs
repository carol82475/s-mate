namespace TravelDecisionEngine.Infrastructure.ExternalServices.AI;

using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.Logging;

public interface IAiProviderService
{
    Task<string> GenerateTripAsync(string prompt, CancellationToken cancellationToken);
    Task<string> ChatAsync(string message, string language, CancellationToken cancellationToken);
}

public class AiProviderService : IAiProviderService
{
    private readonly IConfiguration _configuration;
    private readonly ILogger<AiProviderService> _logger;

    public AiProviderService(IConfiguration configuration, ILogger<AiProviderService> logger)
    {
        _configuration = configuration;
        _logger = logger;
    }

    public Task<string> GenerateTripAsync(string prompt, CancellationToken cancellationToken)
    {
        _ = cancellationToken;
        if (IsDisabled())
        {
            _logger.LogWarning("AI provider is disabled because AI.Provider and provider API keys are not configured.");
            return Task.FromResult("AI trip generation is unavailable because the AI provider is not configured.");
        }

        return Task.FromResult($"TODO: Connect GPT-4o or Claude provider. Prompt: {prompt}");
    }

    public Task<string> ChatAsync(string message, string language, CancellationToken cancellationToken)
    {
        _ = cancellationToken;
        if (IsDisabled())
        {
            _logger.LogWarning("AI chat is disabled because AI.Provider and provider API keys are not configured.");
            return Task.FromResult("AI chat is unavailable because the AI provider is not configured.");
        }

        return Task.FromResult($"TODO: Chat provider response in {language}: {message}");
    }

    private bool IsDisabled()
        => string.IsNullOrWhiteSpace(_configuration["AI:Provider"])
            || (string.IsNullOrWhiteSpace(_configuration["AI:OpenAIKey"])
                && string.IsNullOrWhiteSpace(_configuration["AI:AnthropicKey"]));
}
