using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;
using TravelDecisionEngine.Application.Interfaces;
using TravelDecisionEngine.Infrastructure.Auth;
using TravelDecisionEngine.Infrastructure.Database;
using TravelDecisionEngine.Infrastructure.ExternalServices.AI;
using TravelDecisionEngine.Infrastructure.ExternalServices.AzureBlob;
using TravelDecisionEngine.Infrastructure.ExternalServices.Firebase;
using TravelDecisionEngine.Infrastructure.ExternalServices.GoogleMaps;
using TravelDecisionEngine.Infrastructure.ExternalServices.TextToSpeech;
using TravelDecisionEngine.Infrastructure.Notifications;
using TravelDecisionEngine.Infrastructure.Repositories;

namespace TravelDecisionEngine.Infrastructure;

public static class DependencyInjection
{
    public static IServiceCollection AddInfrastructure(this IServiceCollection services, IConfiguration configuration)
    {
        services.AddDbContext<TravelDecisionEngineDbContext>(options =>
            options.UseSqlServer(configuration.GetConnectionString("DefaultConnection")));

        services.AddScoped<IUserRepository, UserRepository>();
        services.AddScoped<IAuthSecurityRepository, AuthSecurityRepository>();
        services.AddScoped<ITripRepository, TripRepository>();
        services.AddScoped<IPlaceRepository, PlaceRepository>();

        services.AddScoped<ITokenService, JwtTokenService>();

        services.AddScoped<IGoogleMapsService, GoogleMapsService>();
        services.AddScoped<IFirebasePushService, FirebasePushService>();
        services.AddScoped<IAzureBlobStorageService, AzureBlobStorageService>();
        services.AddScoped<IAiProviderService, AiProviderService>();
        services.AddScoped<ITextToSpeechService, GoogleTextToSpeechService>();
        services.AddScoped<INotificationScheduler, NotificationScheduler>();

        return services;
    }
}
