namespace TravelDecisionEngine.Domain.Entities;

public class Place : AuditableEntity
{
    public Guid PlaceId { get; set; }
    public string Name { get; set; } = string.Empty;
    public string Description { get; set; } = string.Empty;
    public decimal Lat { get; set; }
    public decimal Lng { get; set; }
    public string City { get; set; } = string.Empty;
    public string CountryCode { get; set; } = "VN";
    public string Category { get; set; } = string.Empty;
    public decimal TrustScore { get; set; }
    public string Tags { get; set; } = string.Empty;
    public string OpenHours { get; set; } = string.Empty;
    public string PriceLevel { get; set; } = string.Empty;

    public ICollection<Checkpoint> Checkpoints { get; set; } = new List<Checkpoint>();
}
