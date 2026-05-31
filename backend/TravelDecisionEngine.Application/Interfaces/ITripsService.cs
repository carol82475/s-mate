using TravelDecisionEngine.Application.DTOs.Trips;

namespace TravelDecisionEngine.Application.Interfaces;

public interface ITripsService
{
    Task<IReadOnlyCollection<TripResponse>> GetTripsAsync(Guid userId, CancellationToken cancellationToken);
    Task<TripResponse> CreateTripAsync(Guid userId, TripRequest request, CancellationToken cancellationToken);
    Task<GeneratedTripResponse> GenerateTripAsync(Guid userId, GenerateTripRequest request, CancellationToken cancellationToken);
    Task<TripDetailsResponse> GetTripAsync(Guid userId, Guid tripId, CancellationToken cancellationToken);
    Task<TripResponse> UpdateTripAsync(Guid userId, Guid tripId, TripRequest request, CancellationToken cancellationToken);
    Task DeleteTripAsync(Guid userId, Guid tripId, CancellationToken cancellationToken);
    Task ArchiveTripAsync(Guid userId, Guid tripId, CancellationToken cancellationToken);
    Task CompleteTripAsync(Guid userId, Guid tripId, CancellationToken cancellationToken);
}
