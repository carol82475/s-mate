namespace TravelDecisionEngine.Application.Interfaces;

public interface ITokenService
{
    string GenerateAccessToken(Guid userId, string email, string language);
    string GenerateRefreshToken();
    DateTime GetRefreshTokenExpiryUtc();
}
