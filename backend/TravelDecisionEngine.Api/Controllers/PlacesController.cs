using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using TravelDecisionEngine.Application.Interfaces;
using TravelDecisionEngine.Infrastructure.Database;

namespace TravelDecisionEngine.Api.Controllers;

[Route("api/places")]
public class PlacesController : ApiControllerBase
{
    private readonly IPlacesService _places;
    private readonly TravelDecisionEngineDbContext _db;

    public PlacesController(IPlacesService places, TravelDecisionEngineDbContext db)
    {
        _places = places;
        _db = db;
    }

    [HttpGet]
    [AllowAnonymous]
    public async Task<IActionResult> GetPlaces(CancellationToken cancellationToken)
        => Ok(new { success = true, message = "Places loaded", data = await _places.GetPlacesAsync(cancellationToken) });

    [HttpGet("{placeId:guid}")]
    [AllowAnonymous]
    public async Task<IActionResult> GetPlace([FromRoute] Guid placeId, CancellationToken cancellationToken)
        => Ok(new { success = true, message = "Place loaded", data = await _places.GetPlaceAsync(placeId, cancellationToken) });

    [HttpGet("nearby")]
    [AllowAnonymous]
    public async Task<IActionResult> GetNearby([FromQuery] decimal lat, [FromQuery] decimal lng, CancellationToken cancellationToken)
        => Ok(new { success = true, message = "Nearby places loaded", data = await _places.GetNearbyAsync(lat, lng, cancellationToken) });

    [HttpGet("recommended")]
    [AllowAnonymous]
    public async Task<IActionResult> GetRecommended(CancellationToken cancellationToken)
    {
        var data = await _db.Places.OrderByDescending(x => x.TrustScore).Take(10).ToListAsync(cancellationToken);
        return Ok(new { success = true, message = "Recommended places", data });
    }

    [HttpGet("hidden-spots")]
    [AllowAnonymous]
    public async Task<IActionResult> GetHiddenSpots(CancellationToken cancellationToken)
    {
        var data = await _db.Places.Where(x => x.Tags.Contains("hidden")).ToListAsync(cancellationToken);
        return Ok(new { success = true, message = "Hidden spots", data });
    }

    [HttpGet("{placeId:guid}/trust-score")]
    [AllowAnonymous]
    public async Task<IActionResult> GetTrustScore([FromRoute] Guid placeId, CancellationToken cancellationToken)
    {
        var place = await _db.Places.FirstOrDefaultAsync(x => x.PlaceId == placeId, cancellationToken) ?? throw new InvalidOperationException("Place not found.");
        return Ok(new { success = true, message = "Trust score", data = new { place.PlaceId, place.TrustScore } });
    }
}
