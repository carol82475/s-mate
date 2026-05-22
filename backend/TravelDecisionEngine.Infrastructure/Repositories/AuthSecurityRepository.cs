using Microsoft.EntityFrameworkCore;
using TravelDecisionEngine.Application.Interfaces;
using TravelDecisionEngine.Domain.Entities;
using TravelDecisionEngine.Infrastructure.Database;

namespace TravelDecisionEngine.Infrastructure.Repositories;

public class AuthSecurityRepository : IAuthSecurityRepository
{
    private readonly TravelDecisionEngineDbContext _db;

    public AuthSecurityRepository(TravelDecisionEngineDbContext db)
    {
        _db = db;
    }

    public async Task AddOtpCodeAsync(AuthOtpCode otpCode, CancellationToken cancellationToken)
    {
        await _db.AuthOtpCodes.AddAsync(otpCode, cancellationToken);
        await _db.SaveChangesAsync(cancellationToken);
    }

    public async Task<AuthOtpCode?> GetLatestActiveOtpCodeAsync(string email, string purpose, CancellationToken cancellationToken)
        => await _db.AuthOtpCodes
            .Where(x => x.Email == email && x.Purpose == purpose && x.ConsumedAt == null)
            .OrderByDescending(x => x.CreatedAt)
            .FirstOrDefaultAsync(cancellationToken);

    public async Task ConsumeActiveOtpCodesAsync(string email, string purpose, DateTime consumedAt, CancellationToken cancellationToken)
    {
        var activeCodes = await _db.AuthOtpCodes
            .Where(x => x.Email == email && x.Purpose == purpose && x.ConsumedAt == null)
            .ToListAsync(cancellationToken);

        foreach (var code in activeCodes)
        {
            code.ConsumedAt = consumedAt;
        }

        if (activeCodes.Count > 0)
        {
            await _db.SaveChangesAsync(cancellationToken);
        }
    }

    public async Task UpdateOtpCodeAsync(AuthOtpCode otpCode, CancellationToken cancellationToken)
    {
        _db.AuthOtpCodes.Update(otpCode);
        await _db.SaveChangesAsync(cancellationToken);
    }

    public async Task AddRefreshTokenAsync(RefreshToken refreshToken, CancellationToken cancellationToken)
    {
        await _db.RefreshTokens.AddAsync(refreshToken, cancellationToken);
        await _db.SaveChangesAsync(cancellationToken);
    }

    public async Task<RefreshToken?> GetRefreshTokenByHashAsync(string tokenHash, CancellationToken cancellationToken)
        => await _db.RefreshTokens
            .Include(x => x.User)
            .FirstOrDefaultAsync(x => x.TokenHash == tokenHash, cancellationToken);

    public async Task UpdateRefreshTokenAsync(RefreshToken refreshToken, CancellationToken cancellationToken)
    {
        _db.RefreshTokens.Update(refreshToken);
        await _db.SaveChangesAsync(cancellationToken);
    }

    public async Task RevokeActiveRefreshTokensForUserAsync(Guid userId, DateTime revokedAt, CancellationToken cancellationToken)
    {
        var activeTokens = await _db.RefreshTokens
            .Where(x => x.UserId == userId && x.RevokedAt == null && x.ExpiresAt > revokedAt)
            .ToListAsync(cancellationToken);

        foreach (var token in activeTokens)
        {
            token.RevokedAt = revokedAt;
        }

        if (activeTokens.Count > 0)
        {
            await _db.SaveChangesAsync(cancellationToken);
        }
    }
}
