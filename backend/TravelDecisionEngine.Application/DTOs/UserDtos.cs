namespace TravelDecisionEngine.Application.DTOs.Users;

public record UserProfileResponse(
    Guid UserId,
    string Email,
    string? Nationality,
    string Language,
    string? DietPreference,
    string? BudgetPreference,
    bool IsEmailVerified,
    string AuthProvider,
    DateTime CreatedAt,
    DateTime UpdatedAt);

public record UpdateUserProfileRequest(string? Nationality, string? DietPreference, string? BudgetPreference);
public record UpdateLanguageRequest(string Language);
public record UpdatePrivacyRequest(bool ProfileVisible);
public record UpdatePreferencesRequest(string? DietPreference, string? BudgetPreference);
