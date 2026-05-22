using TravelDecisionEngine.Application.DTOs.Places;
using TravelDecisionEngine.Application.Interfaces;

namespace TravelDecisionEngine.Application.Services;

public class PlacesService : IPlacesService
{
    private readonly IPlaceRepository _places;

    public PlacesService(IPlaceRepository places)
    {
        _places = places;
    }

    public async Task<IReadOnlyCollection<PlaceResponse>> GetPlacesAsync(CancellationToken cancellationToken)
    {
        var data = await _places.GetAllAsync(cancellationToken);
        return data.Select(ToResponse).ToArray();
    }

    public async Task<PlaceResponse> GetPlaceAsync(Guid placeId, CancellationToken cancellationToken)
    {
        var place = await _places.GetByIdAsync(placeId, cancellationToken) ?? throw new InvalidOperationException("Place not found.");
        return ToResponse(place);
    }

    public async Task<IReadOnlyCollection<PlaceResponse>> GetNearbyAsync(decimal lat, decimal lng, CancellationToken cancellationToken)
    {
        var places = await _places.GetNearbyAsync(lat, lng, 5m, cancellationToken);
        return places.Select(ToResponse).ToArray();
    }

    private static PlaceResponse ToResponse(Domain.Entities.Place place) =>
        new(place.PlaceId, place.Name, place.Description, place.Lat, place.Lng, place.City, place.CountryCode, place.Category, place.TrustScore, place.Tags, place.OpenHours, place.PriceLevel, place.CreatedAt, place.UpdatedAt);
}
