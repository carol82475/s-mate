namespace TravelDecisionEngine.Application.DTOs.Auth;

public record RegisterRequest(string Email, string Password, string? Nationality, string? Language = "en", string? FullName = null, string? Location = null);
public record LoginRequest(string Email, string Password);
public record SocialLoginRequest(string Provider, string IdToken);
public record ForgotPasswordRequest(string Email);
public record VerifyOtpRequest(string Email, string OtpCode, string Purpose = "EmailVerification");
public record ResetPasswordRequest(string Email, string NewPassword, string OtpCode);
public record RefreshTokenRequest(string RefreshToken);
public record AuthTokenResponse(string AccessToken, string RefreshToken, int ExpiresInMinutes);
