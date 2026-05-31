namespace TravelDecisionEngine.Domain.Entities;

public class Checkpoint : AuditableEntity
{
    public Guid CheckpointId { get; set; }
    public Guid PlaceId { get; set; }
    public string Name { get; set; } = string.Empty;
    public string Description { get; set; } = string.Empty;
    public int SortOrder { get; set; }
    public string? AudioUrl { get; set; }
    public string? ImageUrl { get; set; }
    public string? FunFact { get; set; }
    public decimal Lat { get; set; }
    public decimal Lng { get; set; }

    public Place? Place { get; set; }
}
