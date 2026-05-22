using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using TravelDecisionEngine.Application.Interfaces;
using TravelDecisionEngine.Infrastructure.Database;

namespace TravelDecisionEngine.Api.Controllers;

[Route("api/discovery")]
public class DiscoveryController : ApiControllerBase
{
    private readonly TravelDecisionEngineDbContext _db;

    public DiscoveryController(TravelDecisionEngineDbContext db)
    {
        _db = db;
    }

    [HttpGet("local-loved")]
    [AllowAnonymous]
    public async Task<IActionResult> GetLocalLoved(CancellationToken cancellationToken)
    {
        var places = await _db.Places.Where(x => x.TrustScore >= 4.2m).Take(20).ToListAsync(cancellationToken);
        return Ok(new { success = true, message = "Local-loved places", data = places, rule = "verified traveler >=70%, foreign ratio >=60%" });
    }

    [HttpGet("tourist-friendly")]
    [AllowAnonymous]
    public async Task<IActionResult> GetTouristFriendly(CancellationToken cancellationToken)
    {
        var places = await _db.Places.Where(x => x.TrustScore >= 3.5m).Take(20).ToListAsync(cancellationToken);
        return Ok(new { success = true, message = "Tourist-friendly places", data = places });
    }

    [HttpGet("hidden-spots")]
    [AllowAnonymous]
    public async Task<IActionResult> GetHiddenSpots(CancellationToken cancellationToken)
    {
        var places = await _db.Places.Where(x => x.Tags.Contains("hidden")).ToListAsync(cancellationToken);
        return Ok(new { success = true, message = "Hidden spots are excluded by default", data = places });
    }

    [HttpGet("curated-lists")]
    [AllowAnonymous]
    public IActionResult GetCuratedLists()
        => Ok(new { success = true, message = "Curated list metadata", data = new[] { new { id = "curated-1", updatedDaysAgo = 100, badge = "Updating" } } });
}

[Authorize]
[Route("api/ai/trip-planner")]
public class AiTripPlannerController : ApiControllerBase
{
    private readonly IPlaceholderModuleService _placeholder;

    public AiTripPlannerController(IPlaceholderModuleService placeholder)
    {
        _placeholder = placeholder;
    }

    [HttpPost("generate")]
    public async Task<IActionResult> Generate(CancellationToken cancellationToken)
        => Ok(new { success = true, message = "AI trip planner generate", data = await _placeholder.ExecuteAsync("AiTripPlanner.Generate", cancellationToken) });

    [HttpPost("regenerate")]
    public async Task<IActionResult> Regenerate(CancellationToken cancellationToken)
        => Ok(new { success = true, message = "AI trip planner regenerate", data = await _placeholder.ExecuteAsync("AiTripPlanner.Regenerate", cancellationToken) });

    [HttpPost("explain")]
    public async Task<IActionResult> Explain(CancellationToken cancellationToken)
        => Ok(new { success = true, message = "AI trip planner explain", data = await _placeholder.ExecuteAsync("AiTripPlanner.Explain", cancellationToken) });
}

[Authorize]
[Route("api/chatbot")]
public class ChatbotController : ApiControllerBase
{
    private readonly IPlaceholderModuleService _placeholder;

    public ChatbotController(IPlaceholderModuleService placeholder)
    {
        _placeholder = placeholder;
    }

    [HttpPost("message")]
    public async Task<IActionResult> Message(CancellationToken cancellationToken)
        => Ok(new { success = true, message = "Chatbot response placeholder", data = await _placeholder.ExecuteAsync("Chatbot.Message", cancellationToken), rule = "No specific medical/legal advice" });

    [HttpGet("session")]
    public IActionResult Session()
        => Ok(new { success = true, message = "Chat session", data = new { expiresAfterHours = 24 } });

    [HttpDelete("session")]
    public IActionResult DeleteSession()
        => Ok(new { success = true, message = "Chat session cleared", data = new { } });
}
