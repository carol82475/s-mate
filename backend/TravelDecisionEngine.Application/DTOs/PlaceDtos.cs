namespace TravelDecisionEngine.Application.DTOs.Places;

public record PlaceResponse(
    Guid PlaceId,
    string Name,
    string Description,
    decimal Lat,
    decimal Lng,
    string City,
    string CountryCode,
    string Category,
    decimal TrustScore,
    string Tags,
    string OpenHours,
    string PriceLevel,
    DateTime CreatedAt,
    DateTime UpdatedAt);
