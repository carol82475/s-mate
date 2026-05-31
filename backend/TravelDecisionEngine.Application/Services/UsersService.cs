using System.Security.Cryptography;
using System.Text;
using TravelDecisionEngine.Application.DTOs.Users;
using TravelDecisionEngine.Application.Interfaces;

namespace TravelDecisionEngine.Application.Services;

public class UsersService : IUsersService
{
    private readonly IUserRepository _users;

    public UsersService(IUserRepository users)
    {
        _users = users;
    }

    public async Task<UserProfileResponse> GetMeAsync(Guid userId, CancellationToken cancellationToken)
    {
        return await _users.GetProfileByIdAsync(userId, cancellationToken) ?? throw new InvalidOperationException("User not found.");
    }

    public async Task<UserProfileResponse> UpdateMeAsync(Guid userId, UpdateUserProfileRequest request, CancellationToken cancellationToken)
    {
        var user = await _users.GetByIdAsync(userId, cancellationToken) ?? throw new InvalidOperationException("User not found.");
        user.Nationality = request.Nationality ?? request.Location ?? user.Nationality;
        user.DietPreference = request.DietPreference ?? user.DietPreference;
        user.BudgetPreference = request.BudgetPreference ?? user.BudgetPreference;
        user.UpdatedAt = DateTime.UtcNow;
        await _users.UpdateProfileAsync(user, request.FullName, cancellationToken);
        return await GetMeAsync(userId, cancellationToken);
    }

    public async Task<UserProfileResponse> UpdateLanguageAsync(Guid userId, UpdateLanguageRequest request, CancellationToken cancellationToken)
    {
        var lang = request.LanguageCode ?? request.Language;
        if (string.IsNullOrWhiteSpace(lang)) throw new ArgumentException("Language is required.");
        var user = await _users.GetByIdAsync(userId, cancellationToken) ?? throw new InvalidOperationException("User not found.");
        user.Language = lang;
        user.UpdatedAt = DateTime.UtcNow;
        await _users.UpdateAsync(user, cancellationToken);
        return await GetMeAsync(userId, cancellationToken);
    }

    public async Task<UserProfileResponse> UpdatePreferencesAsync(Guid userId, UpdatePreferencesRequest request, CancellationToken cancellationToken)
    {
        var user = await _users.GetByIdAsync(userId, cancellationToken) ?? throw new InvalidOperationException("User not found.");
        user.DietPreference = request.DietPreference ?? user.DietPreference;
        user.BudgetPreference = request.BudgetPreference ?? user.BudgetPreference;
        user.UpdatedAt = DateTime.UtcNow;
        await _users.UpdateAsync(user, cancellationToken);
        return await GetMeAsync(userId, cancellationToken);
    }

    public Task UpdatePrivacyAsync(Guid userId, UpdatePrivacyRequest request, CancellationToken cancellationToken)
    {
        // TODO(Sprint 1-2): Persist privacy preferences in dedicated user settings table.
        _ = userId;
        _ = request;
        return Task.CompletedTask;
    }

    public async Task ChangePasswordAsync(Guid userId, string newPassword, CancellationToken cancellationToken)
    {
        if (string.IsNullOrWhiteSpace(newPassword) || newPassword.Length < 8)
        {
            throw new ArgumentException("New password must contain at least 8 characters.");
        }

        var user = await _users.GetByIdAsync(userId, cancellationToken) 
            ?? throw new InvalidOperationException("User not found.");

        user.PasswordHash = HashSecret(newPassword);
        user.UpdatedAt = DateTime.UtcNow;
        await _users.UpdateAsync(user, cancellationToken);
    }

    private static string HashSecret(string value)
    {
        using var sha = SHA256.Create();
        var bytes = sha.ComputeHash(Encoding.UTF8.GetBytes(value));
        return Convert.ToHexString(bytes);
    }

    private static UserProfileResponse ToResponse(Domain.Entities.User user) =>
        new(user.UserId, user.Email, user.Nationality, user.Language, user.DietPreference, user.BudgetPreference, user.IsEmailVerified, user.AuthProvider, user.CreatedAt, user.UpdatedAt);
}

