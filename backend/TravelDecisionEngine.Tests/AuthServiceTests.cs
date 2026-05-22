using System.Security.Cryptography;
using System.Text;
using Microsoft.Extensions.FileProviders;
using Microsoft.Extensions.Hosting;
using Microsoft.Extensions.Logging.Abstractions;
using TravelDecisionEngine.Application.DTOs.Auth;
using TravelDecisionEngine.Application.Interfaces;
using TravelDecisionEngine.Application.Services;
using TravelDecisionEngine.Domain.Constants;
using TravelDecisionEngine.Domain.Entities;
using Xunit;

namespace TravelDecisionEngine.Tests;

public class AuthServiceTests
{
    [Fact]
    public async Task Register_CreatesUserAndPersistsRefreshToken()
    {
        var fixture = new AuthFixture();

        var response = await fixture.Service.RegisterAsync(
            new RegisterRequest("new@example.com", "Password1!", "VN", "en"),
            CancellationToken.None);

        var user = Assert.Single(fixture.Users.Users);
        Assert.Equal("new@example.com", user.Email);
        Assert.False(user.IsEmailVerified);
        Assert.False(string.IsNullOrWhiteSpace(response.RefreshToken));
        Assert.Single(fixture.Security.RefreshTokens);
    }

    [Fact]
    public async Task Register_DuplicateEmailThrowsConflict()
    {
        var fixture = new AuthFixture();
        await fixture.Service.RegisterAsync(new RegisterRequest("dupe@example.com", "Password1!", null, "en"), CancellationToken.None);

        await Assert.ThrowsAsync<InvalidOperationException>(() =>
            fixture.Service.RegisterAsync(new RegisterRequest("DUPE@example.com", "Password1!", null, "en"), CancellationToken.None));
    }

    [Fact]
    public async Task Login_UnverifiedEmailThrowsUnauthorized()
    {
        var fixture = new AuthFixture();
        await fixture.Service.RegisterAsync(new RegisterRequest("pending@example.com", "Password1!", null, "en"), CancellationToken.None);

        await Assert.ThrowsAsync<UnauthorizedAccessException>(() =>
            fixture.Service.LoginAsync(new LoginRequest("pending@example.com", "Password1!"), CancellationToken.None));
    }

    [Fact]
    public async Task Login_VerifiedEmailSucceeds()
    {
        var fixture = new AuthFixture();
        fixture.Users.Users.Add(CreateUser("verified@example.com", "Password1!", isVerified: true));

        var response = await fixture.Service.LoginAsync(new LoginRequest("verified@example.com", "Password1!"), CancellationToken.None);

        Assert.False(string.IsNullOrWhiteSpace(response.AccessToken));
        Assert.Single(fixture.Security.RefreshTokens);
    }

    [Fact]
    public async Task Login_WrongPasswordThrowsUnauthorized()
    {
        var fixture = new AuthFixture();
        fixture.Users.Users.Add(CreateUser("wrong@example.com", "Password1!", isVerified: true));

        await Assert.ThrowsAsync<UnauthorizedAccessException>(() =>
            fixture.Service.LoginAsync(new LoginRequest("wrong@example.com", "NopePassword1!"), CancellationToken.None));
    }

    [Fact]
    public async Task ForgotPassword_CreatesStoredOtpHash()
    {
        var fixture = new AuthFixture();
        fixture.Users.Users.Add(CreateUser("reset@example.com", "Password1!", isVerified: true));

        await fixture.Service.ForgotPasswordAsync(new ForgotPasswordRequest("RESET@example.com"), CancellationToken.None);

        var otp = Assert.Single(fixture.Security.OtpCodes);
        Assert.Equal("reset@example.com", otp.Email);
        Assert.Equal(AuthOtpPurposes.PasswordReset, otp.Purpose);
        Assert.Equal(64, otp.OtpCodeHash.Length);
        Assert.Null(otp.ConsumedAt);
    }

    [Fact]
    public async Task VerifyOtp_WrongCodeFailsAndIncrementsAttempts()
    {
        var fixture = new AuthFixture();
        fixture.Users.Users.Add(CreateUser("verify@example.com", "Password1!", isVerified: false));
        var otp = fixture.Security.AddOtp("verify@example.com", AuthOtpPurposes.EmailVerification, "123456");

        await Assert.ThrowsAsync<UnauthorizedAccessException>(() =>
            fixture.Service.VerifyOtpAsync(new VerifyOtpRequest("verify@example.com", "000000"), CancellationToken.None));

        Assert.Equal(1, otp.AttemptCount);
        Assert.False(fixture.Users.Users.Single().IsEmailVerified);
    }

    [Fact]
    public async Task ResetPassword_WrongOtpFails()
    {
        var fixture = new AuthFixture();
        fixture.Users.Users.Add(CreateUser("reset@example.com", "Password1!", isVerified: true));
        fixture.Security.AddOtp("reset@example.com", AuthOtpPurposes.PasswordReset, "123456");

        await Assert.ThrowsAsync<UnauthorizedAccessException>(() =>
            fixture.Service.ResetPasswordAsync(new ResetPasswordRequest("reset@example.com", "NewPassword1!", "000000"), CancellationToken.None));
    }

    [Fact]
    public async Task ResetPassword_ValidOtpUpdatesPasswordAndConsumesOtp()
    {
        var fixture = new AuthFixture();
        fixture.Users.Users.Add(CreateUser("reset@example.com", "Password1!", isVerified: true));
        var otp = fixture.Security.AddOtp("reset@example.com", AuthOtpPurposes.PasswordReset, "123456");

        await fixture.Service.ResetPasswordAsync(
            new ResetPasswordRequest("reset@example.com", "NewPassword1!", "123456"),
            CancellationToken.None);

        Assert.NotNull(otp.ConsumedAt);
    }

    [Fact]
    public async Task Login_WithNewPasswordAfterResetSucceeds()
    {
        var fixture = new AuthFixture();
        fixture.Users.Users.Add(CreateUser("reset-login@example.com", "Password1!", isVerified: true));
        fixture.Security.AddOtp("reset-login@example.com", AuthOtpPurposes.PasswordReset, "123456");

        await fixture.Service.ResetPasswordAsync(
            new ResetPasswordRequest("reset-login@example.com", "NewPassword1!", "123456"),
            CancellationToken.None);

        var response = await fixture.Service.LoginAsync(
            new LoginRequest("reset-login@example.com", "NewPassword1!"),
            CancellationToken.None);

        Assert.False(string.IsNullOrWhiteSpace(response.AccessToken));
    }

    [Fact]
    public async Task RefreshToken_RotatesAndPersistsNewToken()
    {
        var fixture = new AuthFixture();
        fixture.Users.Users.Add(CreateUser("refresh@example.com", "Password1!", isVerified: true));
        var login = await fixture.Service.LoginAsync(new LoginRequest("refresh@example.com", "Password1!"), CancellationToken.None);
        var oldToken = Assert.Single(fixture.Security.RefreshTokens);

        var refreshed = await fixture.Service.RefreshTokenAsync(new RefreshTokenRequest(login.RefreshToken), CancellationToken.None);

        Assert.NotEqual(login.RefreshToken, refreshed.RefreshToken);
        Assert.NotNull(oldToken.RevokedAt);
        Assert.Equal(2, fixture.Security.RefreshTokens.Count);
        Assert.Contains(fixture.Security.RefreshTokens, x => x.RevokedAt == null);
    }

    [Fact]
    public async Task DeletedAccount_CannotRefreshOrLogin()
    {
        var fixture = new AuthFixture();
        var user = CreateUser("deleted@example.com", "Password1!", isVerified: true);
        fixture.Users.Users.Add(user);
        var login = await fixture.Service.LoginAsync(new LoginRequest("deleted@example.com", "Password1!"), CancellationToken.None);

        await fixture.Service.DeleteAccountAsync(user.UserId, CancellationToken.None);

        await Assert.ThrowsAsync<UnauthorizedAccessException>(() =>
            fixture.Service.LoginAsync(new LoginRequest("deleted@example.com", "Password1!"), CancellationToken.None));
        await Assert.ThrowsAsync<UnauthorizedAccessException>(() =>
            fixture.Service.RefreshTokenAsync(new RefreshTokenRequest(login.RefreshToken), CancellationToken.None));
    }

    private static User CreateUser(string email, string password, bool isVerified)
        => new()
        {
            UserId = Guid.NewGuid(),
            Email = email,
            PasswordHash = Hash(password),
            Language = "en",
            IsEmailVerified = isVerified,
            AuthProvider = "email",
            Status = "active"
        };

    private static string Hash(string value)
    {
        using var sha = SHA256.Create();
        return Convert.ToHexString(sha.ComputeHash(Encoding.UTF8.GetBytes(value)));
    }

    private sealed class AuthFixture
    {
        public FakeUserRepository Users { get; } = new();
        public FakeAuthSecurityRepository Security { get; }
        public AuthService Service { get; }

        public AuthFixture()
        {
            Security = new FakeAuthSecurityRepository(Users);
            Service = new AuthService(
                Users,
                Security,
                new FakeTokenService(),
                NullLogger<AuthService>.Instance,
                new FakeHostEnvironment());
        }
    }

    private sealed class FakeUserRepository : IUserRepository
    {
        public List<User> Users { get; } = [];

        public Task<User?> GetByEmailAsync(string email, CancellationToken cancellationToken)
            => Task.FromResult(Users.FirstOrDefault(x => x.Email == email && x.DeletedAt == null));

        public Task<User?> GetByIdAsync(Guid userId, CancellationToken cancellationToken)
            => Task.FromResult(Users.FirstOrDefault(x => x.UserId == userId && x.DeletedAt == null));

        public Task AddAsync(User user, CancellationToken cancellationToken)
        {
            Users.Add(user);
            return Task.CompletedTask;
        }

        public Task UpdateAsync(User user, CancellationToken cancellationToken) => Task.CompletedTask;

        public Task<int> CountActiveTripsAsync(Guid userId, CancellationToken cancellationToken) => Task.FromResult(0);
    }

    private sealed class FakeAuthSecurityRepository : IAuthSecurityRepository
    {
        private readonly FakeUserRepository _users;

        public FakeAuthSecurityRepository(FakeUserRepository users)
        {
            _users = users;
        }

        public List<AuthOtpCode> OtpCodes { get; } = [];
        public List<RefreshToken> RefreshTokens { get; } = [];

        public AuthOtpCode AddOtp(string email, string purpose, string otpCode)
        {
            var otp = new AuthOtpCode
            {
                Id = Guid.NewGuid(),
                Email = email,
                Purpose = purpose,
                OtpCodeHash = Hash(otpCode),
                ExpiresAt = DateTime.UtcNow.AddMinutes(10),
                CreatedAt = DateTime.UtcNow
            };
            OtpCodes.Add(otp);
            return otp;
        }

        public Task AddOtpCodeAsync(AuthOtpCode otpCode, CancellationToken cancellationToken)
        {
            OtpCodes.Add(otpCode);
            return Task.CompletedTask;
        }

        public Task<AuthOtpCode?> GetLatestActiveOtpCodeAsync(string email, string purpose, CancellationToken cancellationToken)
            => Task.FromResult(OtpCodes
                .Where(x => x.Email == email && x.Purpose == purpose && x.ConsumedAt == null)
                .OrderByDescending(x => x.CreatedAt)
                .FirstOrDefault());

        public Task ConsumeActiveOtpCodesAsync(string email, string purpose, DateTime consumedAt, CancellationToken cancellationToken)
        {
            foreach (var code in OtpCodes.Where(x => x.Email == email && x.Purpose == purpose && x.ConsumedAt == null))
            {
                code.ConsumedAt = consumedAt;
            }

            return Task.CompletedTask;
        }

        public Task UpdateOtpCodeAsync(AuthOtpCode otpCode, CancellationToken cancellationToken) => Task.CompletedTask;

        public Task AddRefreshTokenAsync(RefreshToken refreshToken, CancellationToken cancellationToken)
        {
            refreshToken.User = _users.Users.Single(x => x.UserId == refreshToken.UserId);
            RefreshTokens.Add(refreshToken);
            return Task.CompletedTask;
        }

        public Task<RefreshToken?> GetRefreshTokenByHashAsync(string tokenHash, CancellationToken cancellationToken)
            => Task.FromResult(RefreshTokens.FirstOrDefault(x => x.TokenHash == tokenHash));

        public Task UpdateRefreshTokenAsync(RefreshToken refreshToken, CancellationToken cancellationToken) => Task.CompletedTask;

        public Task RevokeActiveRefreshTokensForUserAsync(Guid userId, DateTime revokedAt, CancellationToken cancellationToken)
        {
            foreach (var token in RefreshTokens.Where(x => x.UserId == userId && x.RevokedAt == null && x.ExpiresAt > revokedAt))
            {
                token.RevokedAt = revokedAt;
            }

            return Task.CompletedTask;
        }
    }

    private sealed class FakeTokenService : ITokenService
    {
        private int _refreshCounter;

        public string GenerateAccessToken(Guid userId, string email, string language) => $"access-{userId}-{email}-{language}";

        public string GenerateRefreshToken() => $"refresh-{++_refreshCounter}";

        public DateTime GetRefreshTokenExpiryUtc() => DateTime.UtcNow.AddDays(30);
    }

    private sealed class FakeHostEnvironment : IHostEnvironment
    {
        public string EnvironmentName { get; set; } = Environments.Development;
        public string ApplicationName { get; set; } = "TravelDecisionEngine.Tests";
        public string ContentRootPath { get; set; } = AppContext.BaseDirectory;
        public IFileProvider ContentRootFileProvider { get; set; } = new NullFileProvider();
    }
}
