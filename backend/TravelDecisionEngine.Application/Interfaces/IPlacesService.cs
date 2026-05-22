using TravelDecisionEngine.Application.DTOs.Places;

namespace TravelDecisionEngine.Application.Interfaces;

public interface IPlacesService
{
    Task<IReadOnlyCollection<PlaceResponse>> GetPlacesAsync(CancellationToken cancellationToken);
    Task<PlaceResponse> GetPlaceAsync(Guid placeId, CancellationToken cancellationToken);
    Task<IReadOnlyCollection<PlaceResponse>> GetNearbyAsync(decimal lat, decimal lng, CancellationToken cancellationToken);
}
