using Microsoft.EntityFrameworkCore;
using TravelDecisionEngine.Application.Interfaces;
using TravelDecisionEngine.Application.DTOs.Users;
using TravelDecisionEngine.Domain.Entities;
using TravelDecisionEngine.Domain.Enums;
using TravelDecisionEngine.Infrastructure.Database;

namespace TravelDecisionEngine.Infrastructure.Repositories;

public class UserRepository : IUserRepository
{
    private readonly TravelDecisionEngineDbContext _db;

    public UserRepository(TravelDecisionEngineDbContext db)
    {
        _db = db;
    }

    public async Task<User?> GetByEmailAsync(string email, CancellationToken cancellationToken)
        => await _db.Users.FirstOrDefaultAsync(x => x.Email == email && x.DeletedAt == null, cancellationToken);

    public async Task<User?> GetByIdAsync(Guid userId, CancellationToken cancellationToken)
        => await _db.Users.FirstOrDefaultAsync(x => x.UserId == userId && x.DeletedAt == null, cancellationToken);

    public async Task AddAsync(User user, string? displayName, CancellationToken cancellationToken)
    {
        await _db.Users.AddAsync(user, cancellationToken);
        if (displayName != null)
        {
            _db.Entry(user).Property("DisplayName").CurrentValue = displayName;
        }
        await _db.SaveChangesAsync(cancellationToken);
    }

    public async Task UpdateAsync(User user, CancellationToken cancellationToken)
    {
        _db.Users.Update(user);
        await _db.SaveChangesAsync(cancellationToken);
    }

    public async Task UpdateProfileAsync(User user, string? displayName, CancellationToken cancellationToken)
    {
        _db.Users.Update(user);
        if (displayName != null)
        {
            _db.Entry(user).Property("DisplayName").CurrentValue = displayName;
        }
        await _db.SaveChangesAsync(cancellationToken);
    }

    public async Task<UserProfileResponse?> GetProfileByIdAsync(Guid userId, CancellationToken cancellationToken)
    {
        var user = await _db.Users.FirstOrDefaultAsync(x => x.UserId == userId && x.DeletedAt == null, cancellationToken);
        if (user == null) return null;

        var displayName = _db.Entry(user).Property("DisplayName").CurrentValue as string;

        return new UserProfileResponse(
            user.UserId,
            user.Email,
            user.Nationality,
            user.Language,
            user.DietPreference,
            user.BudgetPreference,
            user.IsEmailVerified,
            user.AuthProvider,
            user.CreatedAt,
            user.UpdatedAt,
            displayName,
            user.Nationality
        );
    }

    public async Task<int> CountActiveTripsAsync(Guid userId, CancellationToken cancellationToken)
        => await _db.Trips.CountAsync(x => x.UserId == userId && (x.Status == TripStatus.Active || x.Status == TripStatus.Draft), cancellationToken);
}
