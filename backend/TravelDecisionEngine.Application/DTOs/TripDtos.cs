namespace TravelDecisionEngine.Application.DTOs.Trips;

public record TripRequest(
    string Name,
    string Destination,
    string CountryCode,
    DateOnly StartDate,
    DateOnly? EndDate,
    decimal? Budget,
    int? PeopleCount);

public record GenerateTripRequest(
    string? Destination,
    int? Days,
    decimal? Budget,
    int? PeopleCount,
    DateOnly? StartDate,
    DateOnly? EndDate,
    string? Name,
    string? CountryCode,
    IReadOnlyCollection<string>? Preferences,
    string? Description);

public record TripResponse(
    Guid Id,
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
    double? Progress,
    DateTime CreatedAt,
    DateTime UpdatedAt);

public record TripDetailsResponse(
    Guid Id,
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
    double? Progress,
    IReadOnlyCollection<ItineraryDayResponse> Itinerary,
    DateTime CreatedAt,
    DateTime UpdatedAt);

public record GeneratedTripResponse(
    Guid Id,
    Guid TripId,
    bool FallbackItineraryUsed,
    IReadOnlyCollection<ItineraryDayResponse> Itinerary);

public record ItineraryDayResponse(
    int Day,
    string Title,
    Guid? DailyScheduleId,
    DateOnly? Date,
    DailyScheduleResponse? DailySchedule,
    IReadOnlyCollection<ItineraryCheckpointResponse> Checkpoints);

public record DailyScheduleResponse(
    Guid Id,
    int DayNumber,
    DateOnly Date,
    string Title,
    bool RouteOptimized);

public record ItineraryCheckpointResponse(
    string Time,
    string Title,
    string Description,
    bool Completed);
