namespace TravelDecisionEngine.Domain.Entities;

public class TripDay : AuditableEntity
{
    public Guid DayId { get; set; }
    public Guid TripId { get; set; }
    public int DayNumber { get; set; } = 1;
    public DateOnly Date { get; set; }
    public bool RouteOptimized { get; set; }

    public Trip? Trip { get; set; }
    public ICollection<TripPlace> TripPlaces { get; set; } = new List<TripPlace>();
}
