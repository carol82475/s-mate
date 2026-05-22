namespace TravelDecisionEngine.Domain.Entities;

public class User : AuditableEntity
{
    public Guid UserId { get; set; }
    public string Email { get; set; } = string.Empty;
    public string PasswordHash { get; set; } = string.Empty;
    public string? Nationality { get; set; }
    public string Language { get; set; } = "en";
    public string? DietPreference { get; set; }
    public string? BudgetPreference { get; set; }
    public bool IsEmailVerified { get; set; }
    public string AuthProvider { get; set; } = "email";
    public string Status { get; set; } = "active";
    public DateTime? DeletedAt { get; set; }

    public ICollection<Trip> Trips { get; set; } = new List<Trip>();
}
