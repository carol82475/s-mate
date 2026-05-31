using TravelDecisionEngine.Domain.Entities;
using TravelDecisionEngine.Application.DTOs.Users;

namespace TravelDecisionEngine.Application.Interfaces;

public interface IUserRepository
{
    Task<User?> GetByEmailAsync(string email, CancellationToken cancellationToken);
    Task<User?> GetByIdAsync(Guid userId, CancellationToken cancellationToken);
    Task AddAsync(User user, string? displayName, CancellationToken cancellationToken);
    Task UpdateAsync(User user, CancellationToken cancellationToken);
    Task UpdateProfileAsync(User user, string? displayName, CancellationToken cancellationToken);
    Task<UserProfileResponse?> GetProfileByIdAsync(Guid userId, CancellationToken cancellationToken);
    Task<int> CountActiveTripsAsync(Guid userId, CancellationToken cancellationToken);
}

public interface IAuthSecurityRepository
{
    Task AddOtpCodeAsync(AuthOtpCode otpCode, CancellationToken cancellationToken);
    Task<AuthOtpCode?> GetLatestActiveOtpCodeAsync(string email, string purpose, CancellationToken cancellationToken);
    Task ConsumeActiveOtpCodesAsync(string email, string purpose, DateTime consumedAt, CancellationToken cancellationToken);
    Task UpdateOtpCodeAsync(AuthOtpCode otpCode, CancellationToken cancellationToken);
    Task AddRefreshTokenAsync(RefreshToken refreshToken, CancellationToken cancellationToken);
    Task<RefreshToken?> GetRefreshTokenByHashAsync(string tokenHash, CancellationToken cancellationToken);
    Task UpdateRefreshTokenAsync(RefreshToken refreshToken, CancellationToken cancellationToken);
    Task RevokeActiveRefreshTokensForUserAsync(Guid userId, DateTime revokedAt, CancellationToken cancellationToken);
}

public interface ITripRepository
{
    Task<IReadOnlyCollection<Trip>> GetByUserIdAsync(Guid userId, CancellationToken cancellationToken);
    Task<Trip?> GetByIdAsync(Guid userId, Guid tripId, CancellationToken cancellationToken);
    Task AddAsync(Trip trip, CancellationToken cancellationToken);
    Task UpdateAsync(Trip trip, CancellationToken cancellationToken);
    Task DeleteAsync(Trip trip, CancellationToken cancellationToken);
    Task<int> CountActiveTripsAsync(Guid userId, CancellationToken cancellationToken);
}

public interface IPlaceRepository
{
    Task<IReadOnlyCollection<Place>> GetAllAsync(CancellationToken cancellationToken);
    Task<Place?> GetByIdAsync(Guid placeId, CancellationToken cancellationToken);
    Task<IReadOnlyCollection<Place>> GetNearbyAsync(decimal lat, decimal lng, decimal radiusKm, CancellationToken cancellationToken);
}
