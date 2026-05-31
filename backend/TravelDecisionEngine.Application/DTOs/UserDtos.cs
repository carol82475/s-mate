using System.Text.Json.Serialization;

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
    DateTime UpdatedAt,
    string? FullName = null,
    string? Location = null);

public record UpdateUserProfileRequest(
    [property: JsonPropertyName("fullName")] string? FullName,
    [property: JsonPropertyName("location")] string? Location,
    [property: JsonPropertyName("bio")] string? Bio,
    [property: JsonPropertyName("avatarUrl")] string? AvatarUrl,
    [property: JsonPropertyName("nationality")] string? Nationality,
    [property: JsonPropertyName("dietPreference")] string? DietPreference,
    [property: JsonPropertyName("budgetPreference")] string? BudgetPreference);

public record UpdateLanguageRequest(
    [property: JsonPropertyName("languageCode")] string? LanguageCode = null,
    [property: JsonPropertyName("language")] string? Language = null);

public record UpdatePrivacyRequest(
    [property: JsonPropertyName("profileVisible")] bool ProfileVisible = true,
    [property: JsonPropertyName("travelersVisible")] bool TravelersVisible = true,
    [property: JsonPropertyName("shareLocation")] bool? ShareLocation = null,
    [property: JsonPropertyName("showProfilePublicly")] bool? ShowProfilePublicly = null);

public record UpdatePreferencesRequest(
    [property: JsonPropertyName("dietPreference")] string? DietPreference,
    [property: JsonPropertyName("budgetPreference")] string? BudgetPreference);

/// <summary>Used by PUT /users/settings from profile_screen.dart</summary>
public record UpdateSettingsRequest(
    [property: JsonPropertyName("language")] string? Language = null,
    [property: JsonPropertyName("notificationsEnabled")] bool? NotificationsEnabled = null,
    [property: JsonPropertyName("privacyLevel")] string? PrivacyLevel = null,
    [property: JsonPropertyName("shareLocation")] bool? ShareLocation = null,
    [property: JsonPropertyName("showProfilePublicly")] bool? ShowProfilePublicly = null);

public record ChangePasswordRequest(
    [property: JsonPropertyName("newPassword")] string NewPassword);
