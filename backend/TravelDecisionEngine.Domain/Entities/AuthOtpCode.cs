namespace TravelDecisionEngine.Domain.Entities;

public class AuthOtpCode
{
    public Guid Id { get; set; }
    public string Email { get; set; } = string.Empty;
    public string Purpose { get; set; } = string.Empty;
    public string OtpCodeHash { get; set; } = string.Empty;
    public DateTime ExpiresAt { get; set; }
    public DateTime? ConsumedAt { get; set; }
    public int AttemptCount { get; set; }
    public DateTime CreatedAt { get; set; } = DateTime.UtcNow;
}
