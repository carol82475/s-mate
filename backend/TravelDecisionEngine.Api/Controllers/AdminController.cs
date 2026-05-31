using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;

namespace TravelDecisionEngine.Api.Controllers;

[Authorize]
[Route("api/admin")]
public class AdminController : ApiControllerBase
{
    [HttpGet("dashboard")]
    public IActionResult Dashboard() => Ok(new { success = true, message = "Admin dashboard", data = new { } });

    [HttpPost("places")]
    public IActionResult CreatePlace() => Ok(new { success = true, message = "Admin place created", data = new { } });

    [HttpPut("places/{placeId:guid}")]
    public IActionResult UpdatePlace([FromRoute] Guid placeId) => Ok(new { success = true, message = "Admin place updated", data = new { placeId } });

    [HttpDelete("places/{placeId:guid}")]
    public IActionResult DeletePlace([FromRoute] Guid placeId) => Ok(new { success = true, message = "Admin place deleted", data = new { placeId } });

    [HttpPost("checkpoints")]
    public IActionResult CreateCheckpoint() => Ok(new { success = true, message = "Admin checkpoint created", data = new { } });

    [HttpPut("checkpoints/{checkpointId:guid}")]
    public IActionResult UpdateCheckpoint([FromRoute] Guid checkpointId) => Ok(new { success = true, message = "Admin checkpoint updated", data = new { checkpointId } });

    [HttpDelete("checkpoints/{checkpointId:guid}")]
    public IActionResult DeleteCheckpoint([FromRoute] Guid checkpointId) => Ok(new { success = true, message = "Admin checkpoint deleted", data = new { checkpointId } });

    [HttpPost("audio/upload")]
    public IActionResult UploadAudio() => Ok(new { success = true, message = "Audio upload placeholder", data = new { storage = "AzureBlob" } });

    [HttpGet("reviews/reported")]
    public IActionResult ReportedReviews() => Ok(new { success = true, message = "Reported reviews", data = Array.Empty<object>() });

    [HttpPost("reviews/{reviewId:guid}/restore")]
    public IActionResult RestoreReview([FromRoute] Guid reviewId) => Ok(new { success = true, message = "Review restored", data = new { reviewId } });

    [HttpDelete("reviews/{reviewId:guid}")]
    public IActionResult DeleteReview([FromRoute] Guid reviewId) => Ok(new { success = true, message = "Review permanently deleted", data = new { reviewId } });

    [HttpGet("analytics")]
    public IActionResult Analytics() => Ok(new { success = true, message = "Analytics placeholder", data = new { } });
}
