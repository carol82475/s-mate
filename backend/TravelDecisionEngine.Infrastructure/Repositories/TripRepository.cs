using Microsoft.EntityFrameworkCore;
using TravelDecisionEngine.Application.Interfaces;
using TravelDecisionEngine.Domain.Entities;
using TravelDecisionEngine.Domain.Enums;
using TravelDecisionEngine.Infrastructure.Database;

namespace TravelDecisionEngine.Infrastructure.Repositories;

public class TripRepository : ITripRepository
{
    private readonly TravelDecisionEngineDbContext _db;

    public TripRepository(TravelDecisionEngineDbContext db)
    {
        _db = db;
    }

    public async Task<IReadOnlyCollection<Trip>> GetByUserIdAsync(Guid userId, CancellationToken cancellationToken)
        => await _db.Trips
            .Include(x => x.TripDays)
                .ThenInclude(x => x.TripPlaces)
            .Where(x => x.UserId == userId)
            .OrderByDescending(x => x.CreatedAt)
            .ToListAsync(cancellationToken);

    public async Task<Trip?> GetByIdAsync(Guid userId, Guid tripId, CancellationToken cancellationToken)
        => await _db.Trips.FirstOrDefaultAsync(x => x.UserId == userId && x.TripId == tripId, cancellationToken);

    public async Task<Trip?> GetByIdWithItineraryAsync(Guid userId, Guid tripId, CancellationToken cancellationToken)
        => await _db.Trips
            .Include(x => x.TripDays)
                .ThenInclude(x => x.TripPlaces)
                    .ThenInclude(x => x.Place)
            .FirstOrDefaultAsync(x => x.UserId == userId && x.TripId == tripId, cancellationToken);

    public async Task AddAsync(Trip trip, CancellationToken cancellationToken)
    {
        await _db.Trips.AddAsync(trip, cancellationToken);
        await _db.SaveChangesAsync(cancellationToken);
    }

    public async Task UpdateAsync(Trip trip, CancellationToken cancellationToken)
    {
        _db.Trips.Update(trip);
        await _db.SaveChangesAsync(cancellationToken);
    }

    public async Task DeleteAsync(Trip trip, CancellationToken cancellationToken)
    {
        _db.Trips.Remove(trip);
        await _db.SaveChangesAsync(cancellationToken);
    }

    public async Task<int> CountActiveTripsAsync(Guid userId, CancellationToken cancellationToken)
        => await _db.Trips.CountAsync(x => x.UserId == userId && (x.Status == TripStatus.Active || x.Status == TripStatus.Draft), cancellationToken);
}
