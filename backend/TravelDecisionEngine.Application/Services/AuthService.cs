using System.Security.Cryptography;
using System.Text;
using Microsoft.Extensions.Hosting;
using Microsoft.Extensions.Logging;
using TravelDecisionEngine.Application.DTOs.Auth;
using TravelDecisionEngine.Application.Interfaces;
using TravelDecisionEngine.Application.Validators;
using TravelDecisionEngine.Domain.Constants;
using TravelDecisionEngine.Domain.Entities;

namespace TravelDecisionEngine.Application.Services;

public class AuthService : IAuthService
{
    private const int AccessTokenMinutes = 60;
    private const int OtpExpiryMinutes = 10;
    private const int MaxOtpAttempts = 5;

    private readonly IUserRepository _users;
    private readonly IAuthSecurityRepository _authSecurity;
    private readonly ITokenService _tokens;
    private readonly ILogger<AuthService> _logger;
    private readonly IHostEnvironment _environment;

    public AuthService(
        IUserRepository users,
        IAuthSecurityRepository authSecurity,
        ITokenService tokens,
        ILogger<AuthService> logger,
        IHostEnvironment environment)
    {
        _users = users;
        _authSecurity = authSecurity;
        _tokens = tokens;
        _logger = logger;
        _environment = environment;
    }

    public async Task<AuthTokenResponse> RegisterAsync(RegisterRequest request, CancellationToken cancellationToken)
    {
        var errors = AuthValidator.ValidateRegister(request.Email, request.Password);
        if (errors.Count > 0) throw new ArgumentException(string.Join(" ", errors));

        var email = NormalizeEmail(request.Email);
        var existing = await _users.GetByEmailAsync(email, cancellationToken);
        if (existing is not null) throw new InvalidOperationException("Email already exists.");

        var user = new User
        {
            UserId = Guid.NewGuid(),
            Email = email,
            PasswordHash = HashPassword(request.Password),
            Nationality = request.Nationality ?? request.Location,
            Language = string.IsNullOrWhiteSpace(request.Language) ? "en" : request.Language,
            IsEmailVerified = true,
            AuthProvider = "email",
            Status = "active"
        };

        await _users.AddAsync(user, request.FullName, cancellationToken);

        return await BuildTokenResponseAsync(user, cancellationToken);
    }

    public async Task<AuthTokenResponse> LoginAsync(LoginRequest request, CancellationToken cancellationToken)
    {
        var user = await _users.GetByEmailAsync(NormalizeEmail(request.Email), cancellationToken)
            ?? throw new UnauthorizedAccessException("Invalid credentials.");

        if (IsUserDeletedOrInactive(user)) throw new UnauthorizedAccessException("Account is deleted.");
        if (!user.IsEmailVerified) throw new UnauthorizedAccessException("Email must be verified before full login.");
        if (user.PasswordHash != HashPassword(request.Password)) throw new UnauthorizedAccessException("Invalid credentials.");

        return await BuildTokenResponseAsync(user, cancellationToken);
    }

    public async Task<AuthTokenResponse> SocialLoginAsync(SocialLoginRequest request, CancellationToken cancellationToken)
    {
        if (string.IsNullOrWhiteSpace(request.Provider)) throw new ArgumentException("Provider is required.");
        if (string.IsNullOrWhiteSpace(request.IdToken)) throw new ArgumentException("IdToken is required.");

        // TODO: Validate Google/Apple provider tokens before trusting identity claims.
        var syntheticEmail = $"{request.Provider.ToLowerInvariant()}_user@placeholder.local";
        var user = await _users.GetByEmailAsync(syntheticEmail, cancellationToken);

        if (user is null)
        {
            user = new User
            {
                UserId = Guid.NewGuid(),
                Email = syntheticEmail,
                PasswordHash = HashPassword(Guid.NewGuid().ToString("N")),
                Language = "en",
                IsEmailVerified = true,
                AuthProvider = request.Provider,
                Status = "active"
            };
            await _users.AddAsync(user, null, cancellationToken);
        }

        if (IsUserDeletedOrInactive(user)) throw new UnauthorizedAccessException("Account is deleted.");

        return await BuildTokenResponseAsync(user, cancellationToken);
    }

    public async Task<AuthTokenResponse> RefreshTokenAsync(RefreshTokenRequest request, CancellationToken cancellationToken)
    {
        if (string.IsNullOrWhiteSpace(request.RefreshToken)) throw new ArgumentException("Refresh token is required.");

        var tokenHash = HashSecret(request.RefreshToken);
        var existingToken = await _authSecurity.GetRefreshTokenByHashAsync(tokenHash, cancellationToken)
            ?? throw new UnauthorizedAccessException("Invalid refresh token.");

        var now = DateTime.UtcNow;
        if (existingToken.RevokedAt.HasValue || existingToken.ExpiresAt <= now)
        {
            throw new UnauthorizedAccessException("Invalid refresh token.");
        }

        if (IsUserDeletedOrInactive(existingToken.User))
        {
            throw new UnauthorizedAccessException("Account is deleted.");
        }

        existingToken.RevokedAt = now;
        await _authSecurity.UpdateRefreshTokenAsync(existingToken, cancellationToken);

        return await BuildTokenResponseAsync(existingToken.User, cancellationToken);
    }

    public async Task ForgotPasswordAsync(ForgotPasswordRequest request, CancellationToken cancellationToken)
    {
        if (string.IsNullOrWhiteSpace(request.Email)) throw new ArgumentException("Email is required.");

        var email = NormalizeEmail(request.Email);
        var user = await _users.GetByEmailAsync(email, cancellationToken);

        if (user is null || IsUserDeletedOrInactive(user))
        {
            return;
        }

        await CreateOtpCodeAsync(email, AuthOtpPurposes.PasswordReset, cancellationToken);
        // TODO: Inject an email provider and send the OTP outside Development.
    }

    public async Task VerifyOtpAsync(VerifyOtpRequest request, CancellationToken cancellationToken)
    {
        if (string.IsNullOrWhiteSpace(request.Email) || string.IsNullOrWhiteSpace(request.OtpCode))
        {
            throw new ArgumentException("Email and OTP are required.");
        }

        var purpose = NormalizeOtpPurpose(request.Purpose);
        var email = NormalizeEmail(request.Email);
        var otpCode = await ValidateOtpCodeAsync(email, purpose, request.OtpCode, cancellationToken);

        if (purpose == AuthOtpPurposes.EmailVerification)
        {
            var user = await _users.GetByEmailAsync(email, cancellationToken)
                ?? throw new UnauthorizedAccessException("Invalid OTP.");

            if (IsUserDeletedOrInactive(user)) throw new UnauthorizedAccessException("Account is deleted.");

            user.IsEmailVerified = true;
            user.UpdatedAt = DateTime.UtcNow;
            await _users.UpdateAsync(user, cancellationToken);

            otpCode.ConsumedAt = DateTime.UtcNow;
            await _authSecurity.UpdateOtpCodeAsync(otpCode, cancellationToken);
        }
    }

    public async Task ResetPasswordAsync(ResetPasswordRequest request, CancellationToken cancellationToken)
    {
        if (string.IsNullOrWhiteSpace(request.Email) || string.IsNullOrWhiteSpace(request.OtpCode))
        {
            throw new ArgumentException("Email and OTP are required.");
        }

        if (string.IsNullOrWhiteSpace(request.NewPassword) || request.NewPassword.Length < 8)
        {
            throw new ArgumentException("New password must contain at least 8 characters.");
        }

        var email = NormalizeEmail(request.Email);
        var otpCode = await ValidateOtpCodeAsync(email, AuthOtpPurposes.PasswordReset, request.OtpCode, cancellationToken);
        var user = await _users.GetByEmailAsync(email, cancellationToken)
            ?? throw new InvalidOperationException("User not found.");

        if (IsUserDeletedOrInactive(user)) throw new UnauthorizedAccessException("Account is deleted.");

        user.PasswordHash = HashPassword(request.NewPassword);
        user.UpdatedAt = DateTime.UtcNow;
        await _users.UpdateAsync(user, cancellationToken);

        otpCode.ConsumedAt = DateTime.UtcNow;
        await _authSecurity.UpdateOtpCodeAsync(otpCode, cancellationToken);
    }

    public async Task DeleteAccountAsync(Guid userId, CancellationToken cancellationToken)
    {
        var user = await _users.GetByIdAsync(userId, cancellationToken)
            ?? throw new InvalidOperationException("User not found.");

        user.DeletedAt = DateTime.UtcNow;
        user.Status = "deleted";
        user.UpdatedAt = DateTime.UtcNow;
        await _users.UpdateAsync(user, cancellationToken);
        await _authSecurity.RevokeActiveRefreshTokensForUserAsync(user.UserId, DateTime.UtcNow, cancellationToken);
    }

    private async Task<AuthTokenResponse> BuildTokenResponseAsync(User user, CancellationToken cancellationToken)
    {
        var accessToken = _tokens.GenerateAccessToken(user.UserId, user.Email, user.Language);
        var refreshToken = _tokens.GenerateRefreshToken();

        await _authSecurity.AddRefreshTokenAsync(new RefreshToken
        {
            Id = Guid.NewGuid(),
            UserId = user.UserId,
            TokenHash = HashSecret(refreshToken),
            ExpiresAt = _tokens.GetRefreshTokenExpiryUtc(),
            CreatedAt = DateTime.UtcNow
        }, cancellationToken);

        return new AuthTokenResponse(accessToken, refreshToken, AccessTokenMinutes);
    }

    private async Task CreateOtpCodeAsync(string email, string purpose, CancellationToken cancellationToken)
    {
        var normalizedEmail = NormalizeEmail(email);
        var now = DateTime.UtcNow;
        var otpCode = GenerateOtpCode();

        await _authSecurity.ConsumeActiveOtpCodesAsync(normalizedEmail, purpose, now, cancellationToken);
        await _authSecurity.AddOtpCodeAsync(new AuthOtpCode
        {
            Id = Guid.NewGuid(),
            Email = normalizedEmail,
            Purpose = purpose,
            OtpCodeHash = HashSecret(otpCode),
            ExpiresAt = now.AddMinutes(OtpExpiryMinutes),
            CreatedAt = now
        }, cancellationToken);

        if (_environment.IsDevelopment())
        {
            _logger.LogInformation("Development OTP for {Email} ({Purpose}): {OtpCode}", normalizedEmail, purpose, otpCode);
        }
    }

    private async Task<AuthOtpCode> ValidateOtpCodeAsync(
        string email,
        string purpose,
        string otpCode,
        CancellationToken cancellationToken)
    {
        var existing = await _authSecurity.GetLatestActiveOtpCodeAsync(email, purpose, cancellationToken)
            ?? throw new UnauthorizedAccessException("Invalid OTP.");

        var now = DateTime.UtcNow;
        if (existing.ExpiresAt <= now || existing.ConsumedAt.HasValue || existing.AttemptCount >= MaxOtpAttempts)
        {
            throw new UnauthorizedAccessException("Invalid OTP.");
        }

        if (existing.OtpCodeHash != HashSecret(otpCode.Trim()))
        {
            existing.AttemptCount++;
            await _authSecurity.UpdateOtpCodeAsync(existing, cancellationToken);
            throw new UnauthorizedAccessException("Invalid OTP.");
        }

        return existing;
    }

    private static string NormalizeEmail(string email)
    {
        if (string.IsNullOrWhiteSpace(email)) throw new ArgumentException("Email is required.");
        return email.Trim().ToLowerInvariant();
    }

    private static string NormalizeOtpPurpose(string purpose)
    {
        if (string.Equals(purpose, AuthOtpPurposes.PasswordReset, StringComparison.OrdinalIgnoreCase))
        {
            return AuthOtpPurposes.PasswordReset;
        }

        if (string.Equals(purpose, AuthOtpPurposes.EmailVerification, StringComparison.OrdinalIgnoreCase))
        {
            return AuthOtpPurposes.EmailVerification;
        }

        throw new ArgumentException("Invalid OTP purpose.");
    }

    private static bool IsUserDeletedOrInactive(User user)
        => user.DeletedAt.HasValue || string.Equals(user.Status, "deleted", StringComparison.OrdinalIgnoreCase);

    private static string GenerateOtpCode()
        => RandomNumberGenerator.GetInt32(0, 1_000_000).ToString("D6");

    private static string HashSecret(string value)
    {
        using var sha = SHA256.Create();
        var bytes = sha.ComputeHash(Encoding.UTF8.GetBytes(value));
        return Convert.ToHexString(bytes);
    }

    private static string HashPassword(string password)
    {
        // TODO: Migrate to a stronger password hasher with backward-compatible
        // verification for existing SHA256 hashes.
        return HashSecret(password);
    }
}
