namespace TravelDecisionEngine.Domain.Entities;

public class UserConnection : AuditableEntity
{
    public Guid ConnectionId { get; set; }
    public Guid UserId1 { get; set; }
    public Guid UserId2 { get; set; }
    public string Status { get; set; } = "Pending";
}
