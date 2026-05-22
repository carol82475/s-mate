using TravelDecisionEngine.Application.DTOs.Auth;
using TravelDecisionEngine.Application.DTOs.Users;

namespace TravelDecisionEngine.Application.Interfaces;

public interface IAuthService
{
    Task<AuthTokenResponse> RegisterAsync(RegisterRequest request, CancellationToken cancellationToken);
    Task<AuthTokenResponse> LoginAsync(LoginRequest request, CancellationToken cancellationToken);
    Task<AuthTokenResponse> SocialLoginAsync(SocialLoginRequest request, CancellationToken cancellationToken);
    Task<AuthTokenResponse> RefreshTokenAsync(RefreshTokenRequest request, CancellationToken cancellationToken);
    Task ForgotPasswordAsync(ForgotPasswordRequest request, CancellationToken cancellationToken);
    Task VerifyOtpAsync(VerifyOtpRequest request, CancellationToken cancellationToken);
    Task ResetPasswordAsync(ResetPasswordRequest request, CancellationToken cancellationToken);
    Task DeleteAccountAsync(Guid userId, CancellationToken cancellationToken);
}

public interface IUsersService
{
    Task<UserProfileResponse> GetMeAsync(Guid userId, CancellationToken cancellationToken);
    Task<UserProfileResponse> UpdateMeAsync(Guid userId, UpdateUserProfileRequest request, CancellationToken cancellationToken);
    Task<UserProfileResponse> UpdateLanguageAsync(Guid userId, UpdateLanguageRequest request, CancellationToken cancellationToken);
    Task<UserProfileResponse> UpdatePreferencesAsync(Guid userId, UpdatePreferencesRequest request, CancellationToken cancellationToken);
    Task UpdatePrivacyAsync(Guid userId, UpdatePrivacyRequest request, CancellationToken cancellationToken);
}
