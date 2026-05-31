namespace TravelDecisionEngine.Domain.BusinessRules;

public static class ReviewRules
{
    public static decimal CalculateTrustScore(int verifiedReviewCount, int normalReviewCount, int totalReviewCount, decimal averageRating)
    {
        if (totalReviewCount <= 0)
        {
            return 0m;
        }

        var weighted = verifiedReviewCount * 1.5m + normalReviewCount;
        return decimal.Round((weighted / totalReviewCount) * averageRating, 2);
    }
}
