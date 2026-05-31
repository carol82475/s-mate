namespace TravelDecisionEngine.Domain.Entities;

public class PriceReport
{
    public Guid ReportId { get; set; }
    public Guid UserId { get; set; }
    public Guid PlaceId { get; set; }
    public string ItemName { get; set; } = string.Empty;
    public decimal PriceReported { get; set; }
    public decimal MarketPriceMin { get; set; }
    public decimal MarketPriceMax { get; set; }
    public string Currency { get; set; } = "VND";
    public decimal Lat { get; set; }
    public decimal Lng { get; set; }
    public string Status { get; set; } = "Pending";
    public DateTime? ConfirmedAt { get; set; }
    public DateTime CreatedAt { get; set; } = DateTime.UtcNow;
}
