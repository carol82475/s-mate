using TravelDecisionEngine.Application.DTOs.Common;

namespace TravelDecisionEngine.Application.Interfaces;

public interface IPlaceholderModuleService
{
    Task<PlaceholderPayload> ExecuteAsync(string moduleName, CancellationToken cancellationToken);
}
