using Microsoft.Extensions.DependencyInjection;
using TravelDecisionEngine.Application.Interfaces;
using TravelDecisionEngine.Application.Services;

namespace TravelDecisionEngine.Application;

public static class DependencyInjection
{
    public static IServiceCollection AddApplication(this IServiceCollection services)
    {
        services.AddScoped<IAuthService, AuthService>();
        services.AddScoped<IUsersService, UsersService>();
        services.AddScoped<ITripsService, TripsService>();
        services.AddScoped<IPlacesService, PlacesService>();
        services.AddScoped<IPlaceholderModuleService, PlaceholderModuleService>();

        services.AddScoped<ITripDaysService, TripDaysService>();
        services.AddScoped<ITripPlacesService, TripPlacesService>();
        services.AddScoped<ICheckpointsService, CheckpointsService>();
        services.AddScoped<IRouteBuilderService, RouteBuilderService>();
        services.AddScoped<IAudioGuideService, AudioGuideService>();
        services.AddScoped<IOfflinePackagesService, OfflinePackagesService>();
        services.AddScoped<IReviewsService, ReviewsService>();
        services.AddScoped<IPriceReportsService, PriceReportsService>();
        services.AddScoped<IDiscoveryService, DiscoveryService>();
        services.AddScoped<IAiTripPlannerService, AiTripPlannerService>();
        services.AddScoped<IChatbotService, ChatbotService>();
        services.AddScoped<INotificationsService, NotificationsService>();
        services.AddScoped<IAdminCmsService, AdminCmsService>();

        return services;
    }
}
