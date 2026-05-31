using TravelDecisionEngine.Application.DTOs.Trips;

namespace TravelDecisionEngine.Application.Validators;

public static class TripValidator
{
    public static List<string> Validate(TripRequest request)
    {
        var errors = new List<string>();
        if (string.IsNullOrWhiteSpace(request.Name)) errors.Add("Trip name is required.");
        if (string.IsNullOrWhiteSpace(request.Destination)) errors.Add("Destination is required.");
        if (request.EndDate.HasValue && request.EndDate.Value < request.StartDate)
        {
            errors.Add("End date must be greater than or equal to start date.");
        }

        if (request.PeopleCount.HasValue && request.PeopleCount <= 0)
        {
            errors.Add("People count must be greater than zero.");
        }

        return errors;
    }
}
