using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using TravelDecisionEngine.Infrastructure.Database;
using TravelDecisionEngine.Domain.Entities;

namespace TravelDecisionEngine.Api.Controllers;

[Route("api")]
public class ReviewsController : ApiControllerBase
{
    private readonly TravelDecisionEngineDbContext _db;

    public ReviewsController(TravelDecisionEngineDbContext db)
    {
        _db = db;
    }

    [HttpGet("places/{placeId:guid}/reviews")]
    [AllowAnonymous]
    public async Task<IActionResult> GetReviews([FromRoute] Guid placeId, CancellationToken cancellationToken)
    {
        var reviews = await _db.Reviews.Where(x => x.PlaceId == placeId && x.DeletedAt == null).OrderByDescending(x => x.CreatedAt).ToListAsync(cancellationToken);
        return Ok(new { success = true, message = "Reviews loaded", data = reviews });
    }

    [Authorize]
    [HttpPost("places/{placeId:guid}/reviews")]
    public async Task<IActionResult> CreateReview([FromRoute] Guid placeId, [FromBody] Review request, CancellationToken cancellationToken)
    {
        var userId = GetUserIdOrThrow();

        var existing = await _db.Reviews.FirstOrDefaultAsync(x => x.PlaceId == placeId && x.UserId == userId, cancellationToken);
        if (existing is not null)
        {
            throw new InvalidOperationException("One user can leave only one review per place.");
        }

        request.ReviewId = Guid.NewGuid();
        request.UserId = userId;
        request.PlaceId = placeId;
        request.CreatedAt = DateTime.UtcNow;
        request.UpdatedAt = DateTime.UtcNow;

        await _db.Reviews.AddAsync(request, cancellationToken);
        await _db.SaveChangesAsync(cancellationToken);

        return Ok(new { success = true, message = "Review created", data = request });
    }

    [Authorize]
    [HttpPut("reviews/{reviewId:guid}")]
    public async Task<IActionResult> UpdateReview([FromRoute] Guid reviewId, [FromBody] Review request, CancellationToken cancellationToken)
    {
        var userId = GetUserIdOrThrow();
        var review = await _db.Reviews.FirstOrDefaultAsync(x => x.ReviewId == reviewId && x.UserId == userId, cancellationToken)
            ?? throw new InvalidOperationException("Review not found.");

        if (review.CreatedAt.AddHours(24) < DateTime.UtcNow)
        {
            throw new InvalidOperationException("Review can be edited within 24 hours only.");
        }

        review.Rating = request.Rating;
        review.Comment = request.Comment;
        review.ImageUrl = request.ImageUrl;
        review.UpdatedAt = DateTime.UtcNow;

        await _db.SaveChangesAsync(cancellationToken);
        return Ok(new { success = true, message = "Review updated", data = review });
    }

    [Authorize]
    [HttpDelete("reviews/{reviewId:guid}")]
    public async Task<IActionResult> DeleteReview([FromRoute] Guid reviewId, CancellationToken cancellationToken)
    {
        var userId = GetUserIdOrThrow();
        var review = await _db.Reviews.FirstOrDefaultAsync(x => x.ReviewId == reviewId && x.UserId == userId, cancellationToken)
            ?? throw new InvalidOperationException("Review not found.");
        review.DeletedAt = DateTime.UtcNow;
        review.UpdatedAt = DateTime.UtcNow;
        await _db.SaveChangesAsync(cancellationToken);
        return Ok(new { success = true, message = "Review removed", data = new { reviewId } });
    }

    [Authorize]
    [HttpPost("reviews/{reviewId:guid}/report")]
    public IActionResult ReportReview([FromRoute] Guid reviewId)
        => Ok(new { success = true, message = "Review reported", data = new { reviewId } });

    [Authorize]
    [HttpPost("reviews/{reviewId:guid}/moderate")]
    public IActionResult ModerateReview([FromRoute] Guid reviewId)
        => Ok(new { success = true, message = "Review moderation queued", data = new { reviewId, moderation = "AI/admin" } });
}
