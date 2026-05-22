namespace TravelDecisionEngine.Infrastructure.ExternalServices.TextToSpeech;

using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.Logging;

public interface ITextToSpeechService
{
    Task<string> GenerateAudioAsync(string text, CancellationToken cancellationToken);
}

public class GoogleTextToSpeechService : ITextToSpeechService
{
    private readonly IConfiguration _configuration;
    private readonly ILogger<GoogleTextToSpeechService> _logger;

    public GoogleTextToSpeechService(IConfiguration configuration, ILogger<GoogleTextToSpeechService> logger)
    {
        _configuration = configuration;
        _logger = logger;
    }

    public Task<string> GenerateAudioAsync(string text, CancellationToken cancellationToken)
    {
        _ = cancellationToken;
        if (string.IsNullOrWhiteSpace(_configuration["GoogleTTS:ApiKey"]))
        {
            _logger.LogWarning("Google Text-to-Speech is disabled because GoogleTTS.ApiKey is not configured.");
            return Task.FromResult(string.Empty);
        }

        return Task.FromResult($"TODO: Google TTS output for text length {text.Length}");
    }
}
