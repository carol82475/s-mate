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
        var user = await _users.GetByIdAsync(userId, cancellationToken) ?? throw new InvalidOperationException("User not found.");
        return ToResponse(user);
    }

    public async Task<UserProfileResponse> UpdateMeAsync(Guid userId, UpdateUserProfileRequest request, CancellationToken cancellationToken)
    {
        var user = await _users.GetByIdAsync(userId, cancellationToken) ?? throw new InvalidOperationException("User not found.");
        user.Nationality = request.Nationality ?? user.Nationality;
        user.DietPreference = request.DietPreference ?? user.DietPreference;
        user.BudgetPreference = request.BudgetPreference ?? user.BudgetPreference;
        user.UpdatedAt = DateTime.UtcNow;
        await _users.UpdateAsync(user, cancellationToken);
        return ToResponse(user);
    }

    public async Task<UserProfileResponse> UpdateLanguageAsync(Guid userId, UpdateLanguageRequest request, CancellationToken cancellationToken)
    {
        if (string.IsNullOrWhiteSpace(request.Language)) throw new ArgumentException("Language is required.");
        var user = await _users.GetByIdAsync(userId, cancellationToken) ?? throw new InvalidOperationException("User not found.");
        user.Language = request.Language;
        user.UpdatedAt = DateTime.UtcNow;
        await _users.UpdateAsync(user, cancellationToken);
        return ToResponse(user);
    }

    public async Task<UserProfileResponse> UpdatePreferencesAsync(Guid userId, UpdatePreferencesRequest request, CancellationToken cancellationToken)
    {
        var user = await _users.GetByIdAsync(userId, cancellationToken) ?? throw new InvalidOperationException("User not found.");
        user.DietPreference = request.DietPreference ?? user.DietPreference;
        user.BudgetPreference = request.BudgetPreference ?? user.BudgetPreference;
        user.UpdatedAt = DateTime.UtcNow;
        await _users.UpdateAsync(user, cancellationToken);
        return ToResponse(user);
    }

    public Task UpdatePrivacyAsync(Guid userId, UpdatePrivacyRequest request, CancellationToken cancellationToken)
    {
        // TODO(Sprint 1-2): Persist privacy preferences in dedicated user settings table.
        _ = userId;
        _ = request;
        return Task.CompletedTask;
    }

    private static UserProfileResponse ToResponse(Domain.Entities.User user) =>
        new(user.UserId, user.Email, user.Nationality, user.Language, user.DietPreference, user.BudgetPreference, user.IsEmailVerified, user.AuthProvider, user.CreatedAt, user.UpdatedAt);
}

