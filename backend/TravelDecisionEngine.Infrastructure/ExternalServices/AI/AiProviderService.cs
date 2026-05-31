namespace TravelDecisionEngine.Infrastructure.ExternalServices.AI;

using System.Net.Http.Json;
using System.Text.Json;
using TravelDecisionEngine.Application.Interfaces;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.Logging;

public class AiProviderService : IAiProviderService
{
    private static readonly HttpClient HttpClient = new()
    {
        Timeout = TimeSpan.FromSeconds(90)
    };

    private readonly IConfiguration _configuration;
    private readonly ILogger<AiProviderService> _logger;

    public AiProviderService(IConfiguration configuration, ILogger<AiProviderService> logger)
    {
        _configuration = configuration;
        _logger = logger;
    }

    public async Task<string> GenerateTripAsync(string prompt, CancellationToken cancellationToken)
    {
        // Change these values later by setting OLLAMA_MODEL and OLLAMA_URL in
        // the environment or app configuration. The trip generation flow uses
        // Ollama only here so model/API changes stay isolated.
        var model = FirstConfiguredValue("OLLAMA_MODEL", "Ollama:Model") ?? "gemma4:e2b";
        var ollamaUrl = (FirstConfiguredValue("OLLAMA_URL", "Ollama:Url") ?? "http://127.0.0.1:11434").TrimEnd('/');
        var endpoint = $"{ollamaUrl}/api/generate";

        try
        {
            using var response = await HttpClient.PostAsJsonAsync(
                endpoint,
                new
                {
                    model,
                    prompt,
                    stream = false,
                    format = "json"
                },
                cancellationToken);

            response.EnsureSuccessStatusCode();

            var body = await response.Content.ReadAsStringAsync(cancellationToken);
            using var document = JsonDocument.Parse(body);

            if (document.RootElement.TryGetProperty("response", out var generated)
                && generated.ValueKind == JsonValueKind.String)
            {
                return generated.GetString() ?? string.Empty;
            }

            return body;
        }
        catch (Exception ex) when (ex is HttpRequestException or TaskCanceledException or JsonException)
        {
            _logger.LogWarning(ex, "Ollama trip generation failed. The application will use a fallback itinerary.");
            return string.Empty;
        }
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

    private string? FirstConfiguredValue(string environmentVariable, string configurationKey)
    {
        var value = Environment.GetEnvironmentVariable(environmentVariable);
        if (!string.IsNullOrWhiteSpace(value)) return value;

        value = _configuration[environmentVariable];
        if (!string.IsNullOrWhiteSpace(value)) return value;

        value = _configuration[configurationKey];
        return string.IsNullOrWhiteSpace(value) ? null : value;
    }
}
