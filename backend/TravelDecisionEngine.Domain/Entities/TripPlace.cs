namespace TravelDecisionEngine.Domain.Entities;

public class TripPlace : AuditableEntity
{
    public Guid TripPlaceId { get; set; }
    public Guid DayId { get; set; }
    public Guid PlaceId { get; set; }
    public int SortOrder { get; set; }
    public DateTime? EstimatedArrivalTime { get; set; }
    public DateTime? VisitedAt { get; set; }
    public string Status { get; set; } = "Planned";

    public TripDay? TripDay { get; set; }
    public Place? Place { get; set; }
}
