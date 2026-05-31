using TravelDecisionEngine.Application.Interfaces;

namespace TravelDecisionEngine.Application.Services;

public class PriceReportsService : IPriceReportsService
{
    public Task<object> ExecuteAsync(CancellationToken cancellationToken)
    {
        _ = cancellationToken;
        return Task.FromResult<object>(new { module = "PriceReports", status = "TODO" });
    }
}

