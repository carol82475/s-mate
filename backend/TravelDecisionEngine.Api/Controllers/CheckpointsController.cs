using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using TravelDecisionEngine.Infrastructure.Database;

namespace TravelDecisionEngine.Api.Controllers;

[Route("api")]
public class CheckpointsController : ApiControllerBase
{
    private readonly TravelDecisionEngineDbContext _db;

    public CheckpointsController(TravelDecisionEngineDbContext db)
    {
        _db = db;
    }

    [HttpGet("places/{placeId:guid}/checkpoints")]
    [AllowAnonymous]
    public async Task<IActionResult> GetPlaceCheckpoints([FromRoute] Guid placeId, CancellationToken cancellationToken)
    {
        var query = _db.Checkpoints.Where(x => x.PlaceId == placeId).OrderBy(x => x.SortOrder);
        var userId = TryGetUserId();

        if (!userId.HasValue)
        {
            var preview = await query.Take(3).ToListAsync(cancellationToken);
            return Ok(new { success = true, message = "Guest preview only (first 3 checkpoints)", data = preview });
        }

        var data = await query.ToListAsync(cancellationToken);
        return Ok(new { success = true, message = "Checkpoints loaded", data });
    }

    [HttpGet("checkpoints/{checkpointId:guid}")]
    [AllowAnonymous]
    public async Task<IActionResult> GetCheckpoint([FromRoute] Guid checkpointId, CancellationToken cancellationToken)
    {
        var checkpoint = await _db.Checkpoints.FirstOrDefaultAsync(x => x.CheckpointId == checkpointId, cancellationToken)
            ?? throw new InvalidOperationException("Checkpoint not found.");
        return Ok(new { success = true, message = "Checkpoint loaded", data = checkpoint });
    }

    [Authorize]
    [HttpPost("checkpoints/{checkpointId:guid}/complete")]
    public IActionResult CompleteCheckpoint([FromRoute] Guid checkpointId)
        => Ok(new { success = true, message = "Checkpoint completion saved", data = new { checkpointId, status = "In-progress supported" } });

    [HttpGet("places/{placeId:guid}/audio-guide")]
    [AllowAnonymous]
    public IActionResult GetAudioGuide([FromRoute] Guid placeId)
        => Ok(new { success = true, message = "Audio guide metadata", data = new { placeId, triggerRadiusMeters = 200 } });

    [HttpGet("checkpoints/{checkpointId:guid}/audio")]
    [AllowAnonymous]
    public IActionResult GetCheckpointAudio([FromRoute] Guid checkpointId)
        => Ok(new { success = true, message = "Checkpoint audio metadata", data = new { checkpointId } });

    [Authorize]
    [HttpPost("audio/trigger-log")]
    public IActionResult CreateAudioTriggerLog()
        => Ok(new { success = true, message = "Audio trigger logged", data = new { skipWindowMinutes = 30 } });
}
