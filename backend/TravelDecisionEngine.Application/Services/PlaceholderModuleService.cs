using TravelDecisionEngine.Application.DTOs.Common;
using TravelDecisionEngine.Application.Interfaces;

namespace TravelDecisionEngine.Application.Services;

public class PlaceholderModuleService : IPlaceholderModuleService
{
    public Task<PlaceholderPayload> ExecuteAsync(string moduleName, CancellationToken cancellationToken)
    {
        return Task.FromResult(
            new PlaceholderPayload(
                moduleName,
                "TODO",
                "Planned by sprint roadmap. Endpoint contract is ready."
            )
        );
    }
}
