namespace TravelDecisionEngine.Application.Interfaces;

public interface IAiProviderService
{
    Task<string> GenerateTripAsync(string prompt, CancellationToken cancellationToken);
    Task<string> ChatAsync(string message, string language, CancellationToken cancellationToken);
}
