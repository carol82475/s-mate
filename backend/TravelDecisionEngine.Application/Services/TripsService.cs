using TravelDecisionEngine.Application.DTOs.Trips;
using TravelDecisionEngine.Application.Interfaces;
using TravelDecisionEngine.Application.Validators;
using TravelDecisionEngine.Domain.Entities;
using TravelDecisionEngine.Domain.Enums;

namespace TravelDecisionEngine.Application.Services;

public class TripsService : ITripsService
{
    private readonly ITripRepository _trips;

    public TripsService(ITripRepository trips)
    {
        _trips = trips;
    }

    public async Task<IReadOnlyCollection<TripResponse>> GetTripsAsync(Guid userId, CancellationToken cancellationToken)
    {
        var trips = await _trips.GetByUserIdAsync(userId, cancellationToken);
        foreach (var trip in trips)
        {
            if (trip.EndDate.HasValue)
            {
                var endUtc = DateTime.SpecifyKind(trip.EndDate.Value.ToDateTime(new TimeOnly(0, 0)), DateTimeKind.Utc).AddHours(24);
                if (DateTime.UtcNow >= endUtc && trip.Status != TripStatus.Completed)
                {
                    trip.Status = TripStatus.Completed;
                    trip.UpdatedAt = DateTime.UtcNow;
                    await _trips.UpdateAsync(trip, cancellationToken);
                }
            }
        }

        return trips.Select(ToResponse).ToArray();
    }

    public async Task<TripResponse> CreateTripAsync(Guid userId, TripRequest request, CancellationToken cancellationToken)
    {
        var errors = TripValidator.Validate(request);
        if (errors.Count > 0) throw new ArgumentException(string.Join(" ", errors));

        var activeTrips = await _trips.CountActiveTripsAsync(userId, cancellationToken);
        if (activeTrips >= 10) throw new InvalidOperationException("Each user can have maximum 10 active trips.");

        var trip = new Trip
        {
            TripId = Guid.NewGuid(),
            UserId = userId,
            Name = request.Name,
            Destination = request.Destination,
            CountryCode = string.IsNullOrWhiteSpace(request.CountryCode) ? "VN" : request.CountryCode,
            StartDate = request.StartDate,
            EndDate = request.EndDate,
            Budget = request.Budget,
            PeopleCount = request.PeopleCount,
            Status = TripStatus.Active
        };

        await _trips.AddAsync(trip, cancellationToken);
        return ToResponse(trip);
    }

    public async Task<TripResponse> GetTripAsync(Guid userId, Guid tripId, CancellationToken cancellationToken)
    {
        var trip = await _trips.GetByIdAsync(userId, tripId, cancellationToken) ?? throw new InvalidOperationException("Trip not found.");
        return ToResponse(trip);
    }

    public async Task<TripResponse> UpdateTripAsync(Guid userId, Guid tripId, TripRequest request, CancellationToken cancellationToken)
    {
        var errors = TripValidator.Validate(request);
        if (errors.Count > 0) throw new ArgumentException(string.Join(" ", errors));

        var trip = await _trips.GetByIdAsync(userId, tripId, cancellationToken) ?? throw new InvalidOperationException("Trip not found.");
        trip.Name = request.Name;
        trip.Destination = request.Destination;
        trip.CountryCode = request.CountryCode;
        trip.StartDate = request.StartDate;
        trip.EndDate = request.EndDate;
        trip.Budget = request.Budget;
        trip.PeopleCount = request.PeopleCount;
        trip.UpdatedAt = DateTime.UtcNow;

        await _trips.UpdateAsync(trip, cancellationToken);
        return ToResponse(trip);
    }

    public async Task DeleteTripAsync(Guid userId, Guid tripId, CancellationToken cancellationToken)
    {
        var trip = await _trips.GetByIdAsync(userId, tripId, cancellationToken) ?? throw new InvalidOperationException("Trip not found.");
        await _trips.DeleteAsync(trip, cancellationToken);
    }

    public async Task ArchiveTripAsync(Guid userId, Guid tripId, CancellationToken cancellationToken)
    {
        var trip = await _trips.GetByIdAsync(userId, tripId, cancellationToken) ?? throw new InvalidOperationException("Trip not found.");
        trip.Status = TripStatus.Archived;
        trip.UpdatedAt = DateTime.UtcNow;
        await _trips.UpdateAsync(trip, cancellationToken);
    }

    public async Task CompleteTripAsync(Guid userId, Guid tripId, CancellationToken cancellationToken)
    {
        var trip = await _trips.GetByIdAsync(userId, tripId, cancellationToken) ?? throw new InvalidOperationException("Trip not found.");
        trip.Status = TripStatus.Completed;
        trip.UpdatedAt = DateTime.UtcNow;
        await _trips.UpdateAsync(trip, cancellationToken);
    }

    private static TripResponse ToResponse(Trip trip) =>
        new(trip.TripId, trip.UserId, trip.Name, trip.Destination, trip.CountryCode, trip.StartDate, trip.EndDate, trip.Budget, trip.PeopleCount, trip.Status.ToString(), trip.CreatedAt, trip.UpdatedAt);
}

