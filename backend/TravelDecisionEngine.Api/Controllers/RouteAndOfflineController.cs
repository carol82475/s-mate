using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using TravelDecisionEngine.Application.Interfaces;

namespace TravelDecisionEngine.Api.Controllers;

[Authorize]
[Route("api/routes")]
public class RouteBuilderController : ApiControllerBase
{
    private readonly IPlaceholderModuleService _placeholder;

    public RouteBuilderController(IPlaceholderModuleService placeholder)
    {
        _placeholder = placeholder;
    }

    [HttpPost("optimize")]
    public async Task<IActionResult> OptimizeRoute(CancellationToken cancellationToken)
        => Ok(new { success = true, message = "Route optimization placeholder", data = await _placeholder.ExecuteAsync("RouteBuilder", cancellationToken), rules = new { maxPinnedPlacesPerDay = 20, transportMode = "motorbike" } });
}

[Authorize]
[Route("api/offline")]
public class OfflineController : ApiControllerBase
{
    [HttpGet("trips/{tripId:guid}/package")]
    public IActionResult GetTripPackage([FromRoute] Guid tripId)
        => Ok(new { success = true, message = "Offline package metadata", data = new { tripId, maxAudioPackageMb = 50, minStorageWarningMb = 100 } });

    [HttpPost("trips/{tripId:guid}/download-log")]
    public IActionResult LogTripDownload([FromRoute] Guid tripId)
        => Ok(new { success = true, message = "Offline download log saved", data = new { tripId } });
}
