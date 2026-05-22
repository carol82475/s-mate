using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;

namespace TravelDecisionEngine.Api.Controllers;

[Authorize]
[Route("api/trips/{tripId:guid}/days")]
public class TripDaysController : ApiControllerBase
{
    [HttpGet]
    public IActionResult GetTripDays([FromRoute] Guid tripId)
        => Ok(new { success = true, message = "Trip days endpoint ready", data = new { tripId, items = Array.Empty<object>() } });

    [HttpPost]
    public IActionResult CreateTripDay([FromRoute] Guid tripId)
        => Ok(new { success = true, message = "Trip day created", data = new { tripId, todo = "Sprint 3-4" } });
}

[Authorize]
[Route("api/trip-days")]
public class TripDayItemsController : ApiControllerBase
{
    [HttpPut("{dayId:guid}")]
    public IActionResult UpdateTripDay([FromRoute] Guid dayId)
        => Ok(new { success = true, message = "Trip day updated", data = new { dayId, todo = "Sprint 3-4" } });

    [HttpDelete("{dayId:guid}")]
    public IActionResult DeleteTripDay([FromRoute] Guid dayId)
        => Ok(new { success = true, message = "Trip day deleted", data = new { dayId } });

    [HttpGet("{dayId:guid}/route")]
    public IActionResult GetTripDayRoute([FromRoute] Guid dayId)
        => Ok(new { success = true, message = "Trip day route", data = new { dayId, transportMode = "motorbike", todo = "Sprint 3-4" } });
}

[Authorize]
[Route("api/trip-days/{dayId:guid}/places")]
public class TripDayPlacesController : ApiControllerBase
{
    [HttpPost]
    public IActionResult AddTripPlace([FromRoute] Guid dayId)
        => Ok(new { success = true, message = "Trip place added", data = new { dayId, maxPerDay = 20 } });
}

[Authorize]
[Route("api/trip-places")]
public class TripPlacesController : ApiControllerBase
{
    [HttpPut("{tripPlaceId:guid}")]
    public IActionResult UpdateTripPlace([FromRoute] Guid tripPlaceId)
        => Ok(new { success = true, message = "Trip place updated", data = new { tripPlaceId } });

    [HttpDelete("{tripPlaceId:guid}")]
    public IActionResult DeleteTripPlace([FromRoute] Guid tripPlaceId)
        => Ok(new { success = true, message = "Trip place removed", data = new { tripPlaceId } });

    [HttpPost("{tripPlaceId:guid}/mark-visited")]
    public IActionResult MarkVisited([FromRoute] Guid tripPlaceId)
        => Ok(new { success = true, message = "Trip place marked visited", data = new { tripPlaceId } });
}
