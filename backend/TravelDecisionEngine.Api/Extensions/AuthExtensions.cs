using Microsoft.AspNetCore.Authentication.JwtBearer;
using Microsoft.IdentityModel.Tokens;
using System.Text;

namespace TravelDecisionEngine.Api.Extensions;

public static class AuthExtensions
{
    public static IServiceCollection AddJwtAuth(this IServiceCollection services, IConfiguration configuration)
    {
        var issuer = configuration["Jwt:Issuer"];
        var audience = configuration["Jwt:Audience"];
        var secret = configuration["Jwt:Secret"];
        var supabaseUrl = configuration["Supabase:Url"];
        var supabaseJwtSecret = configuration["Supabase:JwtSecret"];

        if (string.IsNullOrWhiteSpace(secret))
        {
            throw new InvalidOperationException("Jwt:Secret cannot be empty.");
        }

        services.AddAuthentication(options =>
        {
            options.DefaultAuthenticateScheme = "Local";
            options.DefaultChallengeScheme = "Local";
        })
            .AddJwtBearer("Local", options =>
            {
                options.TokenValidationParameters = new TokenValidationParameters
                {
                    ValidateIssuer = !string.IsNullOrWhiteSpace(issuer),
                    ValidateAudience = !string.IsNullOrWhiteSpace(audience),
                    ValidateIssuerSigningKey = true,
                    ValidIssuer = issuer,
                    ValidAudience = audience,
                    IssuerSigningKey = new SymmetricSecurityKey(Encoding.UTF8.GetBytes(secret)),
                    ClockSkew = TimeSpan.FromSeconds(30)
                };
            })
            .AddJwtBearer("Supabase", options =>
            {
                options.TokenValidationParameters = new TokenValidationParameters
                {
                    ValidateIssuer = true,
                    ValidIssuer = $"{supabaseUrl}/auth/v1",
                    ValidateAudience = true,
                    ValidAudience = "authenticated",
                    ValidateIssuerSigningKey = true,
                    IssuerSigningKey = new SymmetricSecurityKey(Encoding.UTF8.GetBytes(supabaseJwtSecret))
                };
            });

        return services;
    }
}
