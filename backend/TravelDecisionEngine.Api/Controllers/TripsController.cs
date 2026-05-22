using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using TravelDecisionEngine.Application.DTOs.Trips;
using TravelDecisionEngine.Application.Interfaces;

namespace TravelDecisionEngine.Api.Controllers;

[Authorize]
[Route("api/trips")]
public class TripsController : ApiControllerBase
{
    private readonly ITripsService _trips;

    public TripsController(ITripsService trips)
    {
        _trips = trips;
    }

    [HttpGet]
    public async Task<IActionResult> GetTrips(CancellationToken cancellationToken)
        => Ok(new { success = true, message = "Trips loaded", data = await _trips.GetTripsAsync(GetUserIdOrThrow(), cancellationToken) });

    [HttpPost]
    public async Task<IActionResult> CreateTrip([FromBody] TripRequest request, CancellationToken cancellationToken)
        => Ok(new { success = true, message = "Trip created", data = await _trips.CreateTripAsync(GetUserIdOrThrow(), request, cancellationToken) });

    [HttpGet("{tripId:guid}")]
    public async Task<IActionResult> GetTrip([FromRoute] Guid tripId, CancellationToken cancellationToken)
        => Ok(new { success = true, message = "Trip loaded", data = await _trips.GetTripAsync(GetUserIdOrThrow(), tripId, cancellationToken) });

    [HttpPut("{tripId:guid}")]
    public async Task<IActionResult> UpdateTrip([FromRoute] Guid tripId, [FromBody] TripRequest request, CancellationToken cancellationToken)
        => Ok(new { success = true, message = "Trip updated", data = await _trips.UpdateTripAsync(GetUserIdOrThrow(), tripId, request, cancellationToken) });

    [HttpDelete("{tripId:guid}")]
    public async Task<IActionResult> DeleteTrip([FromRoute] Guid tripId, CancellationToken cancellationToken)
    {
        await _trips.DeleteTripAsync(GetUserIdOrThrow(), tripId, cancellationToken);
        return Ok(new { success = true, message = "Trip deleted", data = new { } });
    }

    [HttpPost("{tripId:guid}/archive")]
    public async Task<IActionResult> ArchiveTrip([FromRoute] Guid tripId, CancellationToken cancellationToken)
    {
        await _trips.ArchiveTripAsync(GetUserIdOrThrow(), tripId, cancellationToken);
        return Ok(new { success = true, message = "Trip archived", data = new { } });
    }

    [HttpPost("{tripId:guid}/complete")]
    public async Task<IActionResult> CompleteTrip([FromRoute] Guid tripId, CancellationToken cancellationToken)
    {
        await _trips.CompleteTripAsync(GetUserIdOrThrow(), tripId, cancellationToken);
        return Ok(new { success = true, message = "Trip completed", data = new { } });
    }

    [HttpGet("{tripId:guid}/route")]
    public IActionResult GetTripRoute([FromRoute] Guid tripId)
        => Ok(new { success = true, message = "Route placeholder", data = new { tripId, transportMode = "motorbike", warning = "TODO(Sprint 3-4): Add route optimization." } });
}
