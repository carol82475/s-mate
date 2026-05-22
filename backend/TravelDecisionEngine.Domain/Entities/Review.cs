namespace TravelDecisionEngine.Domain.Entities;

public class Review : AuditableEntity
{
    public Guid ReviewId { get; set; }
    public Guid UserId { get; set; }
    public Guid PlaceId { get; set; }
    public int Rating { get; set; }
    public string? Comment { get; set; }
    public string? ImageUrl { get; set; }
    public bool IsVerified { get; set; }
    public string? GpsProof { get; set; }
    public bool ExifVerified { get; set; }
    public DateTime? DeletedAt { get; set; }

    public User? User { get; set; }
    public Place? Place { get; set; }
}
