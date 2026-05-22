using Microsoft.EntityFrameworkCore;
using TravelDecisionEngine.Application.Interfaces;
using TravelDecisionEngine.Domain.Entities;
using TravelDecisionEngine.Infrastructure.Database;

namespace TravelDecisionEngine.Infrastructure.Repositories;

public class PlaceRepository : IPlaceRepository
{
    private readonly TravelDecisionEngineDbContext _db;

    public PlaceRepository(TravelDecisionEngineDbContext db)
    {
        _db = db;
    }

    public async Task<IReadOnlyCollection<Place>> GetAllAsync(CancellationToken cancellationToken)
        => await _db.Places.OrderBy(x => x.City).ThenBy(x => x.Name).ToListAsync(cancellationToken);

    public async Task<Place?> GetByIdAsync(Guid placeId, CancellationToken cancellationToken)
        => await _db.Places.FirstOrDefaultAsync(x => x.PlaceId == placeId, cancellationToken);

    public async Task<IReadOnlyCollection<Place>> GetNearbyAsync(decimal lat, decimal lng, decimal radiusKm, CancellationToken cancellationToken)
    {
        // Approximate bounding box query for MVP.
        var delta = radiusKm / 111m;
        return await _db.Places
            .Where(x => x.Lat >= lat - delta && x.Lat <= lat + delta && x.Lng >= lng - delta && x.Lng <= lng + delta)
            .ToListAsync(cancellationToken);
    }
}
