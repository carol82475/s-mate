using Microsoft.EntityFrameworkCore;
using TravelDecisionEngine.Domain.Entities;
using TravelDecisionEngine.Domain.Enums;

namespace TravelDecisionEngine.Infrastructure.Database;

public static class SeedData
{
    public static readonly Guid GuestUserId = Guid.Parse("f1000000-0000-0000-0000-000000000001");

    public static void Seed(ModelBuilder modelBuilder)
    {
        var now = new DateTime(2026, 5, 21, 0, 0, 0, DateTimeKind.Utc);

        modelBuilder.Entity<User>().HasData(new User
        {
            UserId = GuestUserId,
            Email = "guest@travel-engine.local",
            PasswordHash = "SEED_ONLY",
            Nationality = "Unknown",
            Language = "en",
            DietPreference = "none",
            BudgetPreference = "medium",
            IsEmailVerified = true,
            AuthProvider = "seed",
            CreatedAt = now,
            UpdatedAt = now,
            DeletedAt = null
        });

        var hanoiOldQuarterId = Guid.Parse("f2000000-0000-0000-0000-000000000001");
        var hanoiTempleLiteratureId = Guid.Parse("f2000000-0000-0000-0000-000000000002");
        var hcmNotreDameId = Guid.Parse("f2000000-0000-0000-0000-000000000003");
        var hcmBenThanhId = Guid.Parse("f2000000-0000-0000-0000-000000000004");

        modelBuilder.Entity<Place>().HasData(
            new Place
            {
                PlaceId = hanoiOldQuarterId,
                Name = "Hanoi Old Quarter",
                Description = "Historic district with local food and culture.",
                Lat = 21.033333m,
                Lng = 105.850000m,
                City = "Hanoi",
                CountryCode = "VN",
                Category = "Cultural",
                TrustScore = 4.60m,
                Tags = "food,walking,history",
                OpenHours = "06:00-23:00",
                PriceLevel = "medium",
                CreatedAt = now,
                UpdatedAt = now
            },
            new Place
            {
                PlaceId = hanoiTempleLiteratureId,
                Name = "Temple of Literature",
                Description = "Vietnam's first national university and heritage site.",
                Lat = 21.028511m,
                Lng = 105.835686m,
                City = "Hanoi",
                CountryCode = "VN",
                Category = "Historical",
                TrustScore = 4.70m,
                Tags = "history,temple,education",
                OpenHours = "08:00-17:00",
                PriceLevel = "low",
                CreatedAt = now,
                UpdatedAt = now
            },
            new Place
            {
                PlaceId = hcmNotreDameId,
                Name = "Notre-Dame Cathedral Basilica of Saigon",
                Description = "Iconic cathedral in central Ho Chi Minh City.",
                Lat = 10.779785m,
                Lng = 106.699018m,
                City = "Ho Chi Minh City",
                CountryCode = "VN",
                Category = "Historical",
                TrustScore = 4.50m,
                Tags = "cathedral,landmark,architecture",
                OpenHours = "08:00-18:00",
                PriceLevel = "low",
                CreatedAt = now,
                UpdatedAt = now
            },
            new Place
            {
                PlaceId = hcmBenThanhId,
                Name = "Ben Thanh Market",
                Description = "Major marketplace with local products and street food.",
                Lat = 10.772444m,
                Lng = 106.698056m,
                City = "Ho Chi Minh City",
                CountryCode = "VN",
                Category = "Market",
                TrustScore = 4.10m,
                Tags = "shopping,food,market",
                OpenHours = "07:00-19:00",
                PriceLevel = "medium",
                CreatedAt = now,
                UpdatedAt = now
            }
        );

        modelBuilder.Entity<Checkpoint>().HasData(
            CreateCheckpoint("f3000000-0000-0000-0000-000000000001", hanoiOldQuarterId, "Dong Xuan Market Gate", 1, 21.037000m, 105.847000m, now),
            CreateCheckpoint("f3000000-0000-0000-0000-000000000002", hanoiOldQuarterId, "Ta Hien Street", 2, 21.035200m, 105.852200m, now),
            CreateCheckpoint("f3000000-0000-0000-0000-000000000003", hanoiTempleLiteratureId, "Main Gate", 1, 21.028700m, 105.835300m, now),
            CreateCheckpoint("f3000000-0000-0000-0000-000000000004", hanoiTempleLiteratureId, "Doctor Stelae", 2, 21.028400m, 105.835900m, now),
            CreateCheckpoint("f3000000-0000-0000-0000-000000000005", hcmNotreDameId, "Front Plaza", 1, 10.779700m, 106.698900m, now),
            CreateCheckpoint("f3000000-0000-0000-0000-000000000006", hcmNotreDameId, "Central Garden", 2, 10.779900m, 106.699300m, now),
            CreateCheckpoint("f3000000-0000-0000-0000-000000000007", hcmBenThanhId, "South Gate", 1, 10.772300m, 106.698200m, now),
            CreateCheckpoint("f3000000-0000-0000-0000-000000000008", hcmBenThanhId, "Food Court", 2, 10.772600m, 106.697900m, now)
        );

        var items = new[]
        {
            ("Pho bowl", 45000m, 80000m), ("Banh mi", 15000m, 35000m), ("Bottled water", 10000m, 25000m),
            ("Iced coffee", 18000m, 45000m), ("Taxi airport to center", 150000m, 300000m), ("Motorbike ride per km", 8000m, 18000m),
            ("Coconut", 15000m, 40000m), ("Fruit smoothie", 25000m, 60000m), ("Street BBQ skewer", 10000m, 30000m),
            ("Museum ticket", 30000m, 80000m), ("Temple donation", 10000m, 50000m), ("Laundry per kg", 30000m, 70000m),
            ("Local SIM 7-day", 100000m, 250000m), ("Rain poncho", 10000m, 30000m), ("Souvenir magnet", 20000m, 60000m),
            ("Taxi base fare", 12000m, 25000m), ("Grilled seafood plate", 120000m, 280000m), ("Fresh juice", 20000m, 50000m),
            ("Train station snack", 15000m, 40000m), ("Public restroom fee", 2000m, 10000m)
        };

        var priceReports = new List<PriceReport>();
        for (var i = 0; i < items.Length; i++)
        {
            var item = items[i];
            priceReports.Add(new PriceReport
            {
                ReportId = Guid.Parse($"f4000000-0000-0000-0000-{(i + 1).ToString("D12")}"),
                UserId = GuestUserId,
                PlaceId = hcmBenThanhId,
                ItemName = item.Item1,
                PriceReported = item.Item2,
                MarketPriceMin = item.Item2,
                MarketPriceMax = item.Item3,
                Currency = "VND",
                Lat = 10.772444m,
                Lng = 106.698056m,
                Status = "Confirmed",
                ConfirmedAt = now,
                CreatedAt = now
            });
        }

        modelBuilder.Entity<PriceReport>().HasData(priceReports);
    }

    private static Checkpoint CreateCheckpoint(string id, Guid placeId, string name, int order, decimal lat, decimal lng, DateTime now)
        => new()
        {
            CheckpointId = Guid.Parse(id),
            PlaceId = placeId,
            Name = name,
            Description = $"Checkpoint for {name}",
            SortOrder = order,
            AudioUrl = $"https://cdn.example.com/audio/{id}.mp3",
            ImageUrl = $"https://cdn.example.com/images/{id}.jpg",
            FunFact = "Local cultural context available.",
            Lat = lat,
            Lng = lng,
            CreatedAt = now,
            UpdatedAt = now
        };
}
