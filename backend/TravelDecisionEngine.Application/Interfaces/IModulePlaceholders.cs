namespace TravelDecisionEngine.Application.Interfaces;

public interface ITripDaysService { Task<object> ExecuteAsync(CancellationToken cancellationToken); }
public interface ITripPlacesService { Task<object> ExecuteAsync(CancellationToken cancellationToken); }
public interface ICheckpointsService { Task<object> ExecuteAsync(CancellationToken cancellationToken); }
public interface IRouteBuilderService { Task<object> ExecuteAsync(CancellationToken cancellationToken); }
public interface IAudioGuideService { Task<object> ExecuteAsync(CancellationToken cancellationToken); }
public interface IOfflinePackagesService { Task<object> ExecuteAsync(CancellationToken cancellationToken); }
public interface IReviewsService { Task<object> ExecuteAsync(CancellationToken cancellationToken); }
public interface IPriceReportsService { Task<object> ExecuteAsync(CancellationToken cancellationToken); }
public interface IDiscoveryService { Task<object> ExecuteAsync(CancellationToken cancellationToken); }
public interface IAiTripPlannerService { Task<object> ExecuteAsync(CancellationToken cancellationToken); }
public interface IChatbotService { Task<object> ExecuteAsync(CancellationToken cancellationToken); }
public interface INotificationsService { Task<object> ExecuteAsync(CancellationToken cancellationToken); }
public interface IAdminCmsService { Task<object> ExecuteAsync(CancellationToken cancellationToken); }
