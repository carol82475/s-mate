namespace TravelDecisionEngine.Application.DTOs.Trips;

public record TripRequest(
    string Name,
    string Destination,
    string CountryCode,
    DateOnly StartDate,
    DateOnly? EndDate,
    decimal? Budget,
    int? PeopleCount);

public record TripResponse(
    Guid TripId,
    Guid UserId,
    string Name,
    string Destination,
    string CountryCode,
    DateOnly StartDate,
    DateOnly? EndDate,
    decimal? Budget,
    int? PeopleCount,
    string Status,
    DateTime CreatedAt,
    DateTime UpdatedAt);
