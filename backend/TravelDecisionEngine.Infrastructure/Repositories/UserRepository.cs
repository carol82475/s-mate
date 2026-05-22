using Microsoft.EntityFrameworkCore;
using TravelDecisionEngine.Application.Interfaces;
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

    public async Task AddAsync(User user, CancellationToken cancellationToken)
    {
        await _db.Users.AddAsync(user, cancellationToken);
        await _db.SaveChangesAsync(cancellationToken);
    }

    public async Task UpdateAsync(User user, CancellationToken cancellationToken)
    {
        _db.Users.Update(user);
        await _db.SaveChangesAsync(cancellationToken);
    }

    public async Task<int> CountActiveTripsAsync(Guid userId, CancellationToken cancellationToken)
        => await _db.Trips.CountAsync(x => x.UserId == userId && (x.Status == TripStatus.Active || x.Status == TripStatus.Draft), cancellationToken);
}
