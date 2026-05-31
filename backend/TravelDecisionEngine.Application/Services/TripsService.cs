using System.Text.Json;
using TravelDecisionEngine.Application.DTOs.Trips;
using TravelDecisionEngine.Application.Interfaces;
using TravelDecisionEngine.Application.Validators;
using TravelDecisionEngine.Domain.Entities;
using TravelDecisionEngine.Domain.Enums;

namespace TravelDecisionEngine.Application.Services;

public class TripsService : ITripsService
{
    private const int DefaultDays = 3;
    private const int DefaultPeopleCount = 1;

    private readonly ITripRepository _trips;
    private readonly IAiProviderService _ai;

    public TripsService(ITripRepository trips, IAiProviderService ai)
    {
        _trips = trips;
        _ai = ai;
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

        await EnforceActiveTripLimitAsync(userId, cancellationToken);

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
            PeopleCount = request.PeopleCount ?? DefaultPeopleCount,
            Status = TripStatus.Active
        };

        await _trips.AddAsync(trip, cancellationToken);
        return ToResponse(trip);
    }

    public async Task<GeneratedTripResponse> GenerateTripAsync(Guid userId, GenerateTripRequest request, CancellationToken cancellationToken)
    {
        var destination = request.Destination?.Trim();
        if (string.IsNullOrWhiteSpace(destination))
        {
            throw new ArgumentException("Destination is required.");
        }

        await EnforceActiveTripLimitAsync(userId, cancellationToken);

        var days = ResolveDays(request);
        var peopleCount = request.PeopleCount.GetValueOrDefault(DefaultPeopleCount);
        if (peopleCount < 1) peopleCount = DefaultPeopleCount;

        var startDate = request.StartDate ?? DateOnly.FromDateTime(DateTime.UtcNow);
        var endDate = request.EndDate ?? startDate.AddDays(days - 1);
        if (endDate < startDate)
        {
            throw new ArgumentException("End date must be after start date.");
        }

        var aiItinerary = await TryGenerateAiItineraryAsync(request, destination, days, peopleCount, cancellationToken);
        var fallbackUsed = aiItinerary.Count == 0;
        var itinerary = fallbackUsed ? CreateFallbackItinerary(destination, days) : aiItinerary;

        var trip = new Trip
        {
            TripId = Guid.NewGuid(),
            UserId = userId,
            Name = string.IsNullOrWhiteSpace(request.Name) ? $"{destination} trip" : request.Name.Trim(),
            Destination = destination,
            CountryCode = string.IsNullOrWhiteSpace(request.CountryCode) ? "VN" : request.CountryCode.Trim(),
            StartDate = startDate,
            EndDate = endDate,
            Budget = request.Budget,
            PeopleCount = peopleCount,
            Status = TripStatus.Active,
            TripDays = BuildTripDays(itinerary, startDate, request.CountryCode)
        };

        await _trips.AddAsync(trip, cancellationToken);

        return new GeneratedTripResponse(
            trip.TripId,
            trip.TripId,
            fallbackUsed,
            ToItinerary(trip));
    }

    public async Task<TripDetailsResponse> GetTripAsync(Guid userId, Guid tripId, CancellationToken cancellationToken)
    {
        var trip = await _trips.GetByIdWithItineraryAsync(userId, tripId, cancellationToken)
            ?? throw new InvalidOperationException("Trip not found.");

        return ToDetailsResponse(trip);
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
        trip.PeopleCount = request.PeopleCount ?? DefaultPeopleCount;
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

    private async Task EnforceActiveTripLimitAsync(Guid userId, CancellationToken cancellationToken)
    {
        var activeTrips = await _trips.CountActiveTripsAsync(userId, cancellationToken);
        if (activeTrips >= 10) throw new InvalidOperationException("Each user can have maximum 10 active trips.");
    }

    private async Task<List<ItineraryDayResponse>> TryGenerateAiItineraryAsync(
        GenerateTripRequest request,
        string destination,
        int days,
        int peopleCount,
        CancellationToken cancellationToken)
    {
        var prompt = BuildPrompt(request, destination, days, peopleCount);
        var aiText = await _ai.GenerateTripAsync(prompt, cancellationToken);

        return ParseItinerary(aiText, days);
    }

    private static string BuildPrompt(GenerateTripRequest request, string destination, int days, int peopleCount)
    {
        var preferences = request.Preferences is { Count: > 0 }
            ? string.Join(", ", request.Preferences)
            : "balanced sightseeing, food, and rest";

        return $$"""
            Create a {{days}}-day travel itinerary for {{destination}}.
            People: {{peopleCount}}.
            Budget: {{(request.Budget.HasValue ? request.Budget.Value.ToString("0.##") : "not specified")}}.
            Preferences: {{preferences}}.
            Notes: {{request.Description ?? "none"}}.
            Return only valid JSON with this exact shape:
            {
              "itinerary": [
                {
                  "day": 1,
                  "title": "Short day title",
                  "checkpoints": [
                    {
                      "time": "09:00",
                      "title": "Place or activity",
                      "description": "One sentence",
                      "completed": false
                    }
                  ]
                }
              ]
            }
            """;
    }

    private static List<ItineraryDayResponse> ParseItinerary(string aiText, int expectedDays)
    {
        if (string.IsNullOrWhiteSpace(aiText)) return [];

        var json = ExtractJson(aiText);
        if (string.IsNullOrWhiteSpace(json)) return [];

        try
        {
            using var document = JsonDocument.Parse(json);
            var root = document.RootElement;

            JsonElement daysElement;
            if (root.ValueKind == JsonValueKind.Array)
            {
                daysElement = root;
            }
            else if (root.TryGetProperty("itinerary", out var itinerary))
            {
                daysElement = itinerary;
            }
            else if (root.TryGetProperty("days", out var days))
            {
                daysElement = days;
            }
            else
            {
                return [];
            }

            if (daysElement.ValueKind != JsonValueKind.Array) return [];

            var parsed = new List<ItineraryDayResponse>();
            foreach (var dayElement in daysElement.EnumerateArray())
            {
                var dayNumber = ReadInt(dayElement, "day", parsed.Count + 1);
                var title = ReadString(dayElement, "title", $"Day {dayNumber}");
                var checkpointsElement = ReadArray(dayElement, "checkpoints");
                if (checkpointsElement is null) continue;

                var checkpoints = new List<ItineraryCheckpointResponse>();
                foreach (var checkpointElement in checkpointsElement.Value.EnumerateArray())
                {
                    var checkpointTitle = ReadString(checkpointElement, "title", string.Empty);
                    if (string.IsNullOrWhiteSpace(checkpointTitle)) continue;

                    checkpoints.Add(new ItineraryCheckpointResponse(
                        ReadString(checkpointElement, "time", DefaultTime(checkpoints.Count)),
                        checkpointTitle,
                        ReadString(checkpointElement, "description", checkpointTitle),
                        ReadBool(checkpointElement, "completed", false)));
                }

                if (checkpoints.Count > 0)
                {
                    parsed.Add(new ItineraryDayResponse(dayNumber, title, null, null, null, checkpoints));
                }
            }

            return parsed.Count == 0 ? [] : parsed.Take(Math.Max(expectedDays, 1)).ToList();
        }
        catch (JsonException)
        {
            return [];
        }
    }

    private static string? ExtractJson(string value)
    {
        var trimmed = value.Trim();
        if (trimmed.StartsWith("```", StringComparison.Ordinal))
        {
            var firstNewLine = trimmed.IndexOf('\n');
            var lastFence = trimmed.LastIndexOf("```", StringComparison.Ordinal);
            if (firstNewLine >= 0 && lastFence > firstNewLine)
            {
                trimmed = trimmed[(firstNewLine + 1)..lastFence].Trim();
            }
        }

        if (trimmed.StartsWith('{') || trimmed.StartsWith('[')) return trimmed;

        var objectStart = trimmed.IndexOf('{');
        var arrayStart = trimmed.IndexOf('[');
        var start = objectStart >= 0 && arrayStart >= 0
            ? Math.Min(objectStart, arrayStart)
            : Math.Max(objectStart, arrayStart);
        if (start < 0) return null;

        var objectEnd = trimmed.LastIndexOf('}');
        var arrayEnd = trimmed.LastIndexOf(']');
        var end = Math.Max(objectEnd, arrayEnd);
        return end > start ? trimmed[start..(end + 1)] : null;
    }

    private static ICollection<TripDay> BuildTripDays(
        IReadOnlyCollection<ItineraryDayResponse> itinerary,
        DateOnly startDate,
        string? countryCode)
    {
        return itinerary
            .OrderBy(x => x.Day)
            .Select((day, dayIndex) =>
            {
                var date = startDate.AddDays(dayIndex);
                return new TripDay
                {
                    DayId = Guid.NewGuid(),
                    DayNumber = day.Day,
                    Date = date,
                    RouteOptimized = false,
                    TripPlaces = day.Checkpoints.Select((checkpoint, checkpointIndex) =>
                    {
                        var arrival = ParseArrival(date, checkpoint.Time);
                        return new TripPlace
                        {
                            TripPlaceId = Guid.NewGuid(),
                            SortOrder = checkpointIndex + 1,
                            EstimatedArrivalTime = arrival,
                            VisitedAt = checkpoint.Completed ? DateTime.UtcNow : null,
                            Status = checkpoint.Completed ? "completed" : "upcoming",
                            Place = new Place
                            {
                                PlaceId = Guid.NewGuid(),
                                Name = checkpoint.Title,
                                Description = checkpoint.Description,
                                Category = "AI itinerary",
                                City = string.Empty,
                                CountryCode = string.IsNullOrWhiteSpace(countryCode) ? "VN" : countryCode.Trim(),
                                Tags = "ai-generated",
                                OpenHours = string.Empty,
                                PriceLevel = string.Empty,
                                TrustScore = 0
                            }
                        };
                    }).ToList()
                };
            })
            .ToList();
    }

    private static List<ItineraryDayResponse> CreateFallbackItinerary(string destination, int days)
    {
        var template = new[]
        {
            new[]
            {
                ("09:00", $"Arrive in {destination}", "Get settled and take in the area around your stay."),
                ("12:00", "Local lunch", "Try a well-reviewed local restaurant near the city center."),
                ("15:00", "Cultural landmark", "Visit a museum, temple, market, or historic landmark."),
                ("18:00", "Evening walk", "End the day with an easy walk and dinner nearby.")
            },
            new[]
            {
                ("08:30", "Morning excursion", "Explore a popular attraction or scenic neighborhood."),
                ("12:30", "Lunch break", "Recharge with a relaxed meal before the afternoon plan."),
                ("15:00", "Hidden gem stop", "Visit a quieter local spot based on your travel style."),
                ("19:00", "Dinner and rest", "Keep the evening flexible with food and downtime.")
            },
            new[]
            {
                ("09:00", "Slow morning", "Start with coffee, breakfast, and a short walk."),
                ("11:00", "Souvenir stop", "Browse a local market or shopping street."),
                ("15:00", "Final photo spot", "Capture a final memory before wrapping up the trip.")
            }
        };

        return Enumerable.Range(1, days)
            .Select(day =>
            {
                var checkpoints = template[(day - 1) % template.Length]
                    .Select(item => new ItineraryCheckpointResponse(item.Item1, item.Item2, item.Item3, false))
                    .ToArray();

                return new ItineraryDayResponse(day, $"Day {day} in {destination}", null, null, null, checkpoints);
            })
            .ToList();
    }

    private static TripResponse ToResponse(Trip trip) =>
        new(
            trip.TripId,
            trip.TripId,
            trip.UserId,
            trip.Name,
            trip.Destination,
            trip.CountryCode,
            trip.StartDate,
            trip.EndDate,
            trip.Budget,
            trip.PeopleCount,
            trip.Status.ToString(),
            CalculateProgress(trip),
            trip.CreatedAt,
            trip.UpdatedAt);

    private static TripDetailsResponse ToDetailsResponse(Trip trip) =>
        new(
            trip.TripId,
            trip.TripId,
            trip.UserId,
            trip.Name,
            trip.Destination,
            trip.CountryCode,
            trip.StartDate,
            trip.EndDate,
            trip.Budget,
            trip.PeopleCount,
            trip.Status.ToString(),
            CalculateProgress(trip),
            ToItinerary(trip),
            trip.CreatedAt,
            trip.UpdatedAt);

    private static IReadOnlyCollection<ItineraryDayResponse> ToItinerary(Trip trip)
    {
        return trip.TripDays
            .OrderBy(x => x.DayNumber)
            .ThenBy(x => x.Date)
            .Select((day, index) =>
            {
                var dayNumber = day.DayNumber > 0 ? day.DayNumber : index + 1;
                var title = $"Day {dayNumber} in {trip.Destination}";

                return new ItineraryDayResponse(
                    dayNumber,
                    title,
                    day.DayId,
                    day.Date,
                    new DailyScheduleResponse(
                        day.DayId,
                        dayNumber,
                        day.Date,
                        title,
                        day.RouteOptimized),
                    day.TripPlaces
                    .OrderBy(x => x.SortOrder)
                    .Select(place => new ItineraryCheckpointResponse(
                        FormatTime(place.EstimatedArrivalTime),
                        place.Place?.Name ?? "Activity",
                        place.Place?.Description ?? string.Empty,
                        IsCompleted(place)))
                    .ToArray());
            })
            .ToArray();
    }

    private static double? CalculateProgress(Trip trip)
    {
        var checkpoints = trip.TripDays.SelectMany(x => x.TripPlaces).ToArray();
        if (checkpoints.Length == 0) return null;

        var completed = checkpoints.Count(IsCompleted);
        return completed / (double)checkpoints.Length;
    }

    private static bool IsCompleted(TripPlace place)
        => string.Equals(place.Status, "completed", StringComparison.OrdinalIgnoreCase) || place.VisitedAt.HasValue;

    private static int ResolveDays(GenerateTripRequest request)
    {
        if (request.Days.HasValue && request.Days.Value > 0) return Math.Clamp(request.Days.Value, 1, 14);

        if (request.StartDate.HasValue && request.EndDate.HasValue && request.EndDate.Value >= request.StartDate.Value)
        {
            return Math.Clamp(request.EndDate.Value.DayNumber - request.StartDate.Value.DayNumber + 1, 1, 14);
        }

        return DefaultDays;
    }

    private static DateTime? ParseArrival(DateOnly date, string time)
    {
        return TimeOnly.TryParse(time, out var parsed)
            ? DateTime.SpecifyKind(date.ToDateTime(parsed), DateTimeKind.Utc)
            : null;
    }

    private static string FormatTime(DateTime? value)
        => value.HasValue ? $"{value.Value.Hour:00}:{value.Value.Minute:00}" : string.Empty;

    private static string DefaultTime(int index)
    {
        var hour = Math.Min(9 + (index * 3), 21);
        return $"{hour:00}:00";
    }

    private static JsonElement? ReadArray(JsonElement element, string propertyName)
        => element.TryGetProperty(propertyName, out var property) && property.ValueKind == JsonValueKind.Array
            ? property
            : null;

    private static string ReadString(JsonElement element, string propertyName, string fallback)
        => element.TryGetProperty(propertyName, out var property) && property.ValueKind == JsonValueKind.String
            ? property.GetString() ?? fallback
            : fallback;

    private static int ReadInt(JsonElement element, string propertyName, int fallback)
        => element.TryGetProperty(propertyName, out var property) && property.TryGetInt32(out var value)
            ? value
            : fallback;

    private static bool ReadBool(JsonElement element, string propertyName, bool fallback)
        => element.TryGetProperty(propertyName, out var property) && property.ValueKind is JsonValueKind.True or JsonValueKind.False
            ? property.GetBoolean()
            : fallback;
}
