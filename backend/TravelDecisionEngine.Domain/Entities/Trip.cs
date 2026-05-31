using TravelDecisionEngine.Domain.Enums;

namespace TravelDecisionEngine.Domain.Entities;

public class Trip : AuditableEntity
{
    public Guid TripId { get; set; }
    public Guid UserId { get; set; }
    public string Name { get; set; } = string.Empty;
    public string Destination { get; set; } = string.Empty;
    public string CountryCode { get; set; } = "VN";
    public DateOnly StartDate { get; set; }
    public DateOnly? EndDate { get; set; }
    public decimal? Budget { get; set; }
    public int? PeopleCount { get; set; }
    public TripStatus Status { get; set; } = TripStatus.Draft;

    public User? User { get; set; }
    public ICollection<TripDay> TripDays { get; set; } = new List<TripDay>();
}
