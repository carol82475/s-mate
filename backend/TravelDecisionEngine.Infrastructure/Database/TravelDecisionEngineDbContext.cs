using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;
using TravelDecisionEngine.Domain.Entities;

namespace TravelDecisionEngine.Infrastructure.Database;

public class TravelDecisionEngineDbContext : DbContext
{
    public TravelDecisionEngineDbContext(DbContextOptions<TravelDecisionEngineDbContext> options) : base(options)
    {
    }

    public DbSet<User> Users => Set<User>();
    public DbSet<AuthOtpCode> AuthOtpCodes => Set<AuthOtpCode>();
    public DbSet<RefreshToken> RefreshTokens => Set<RefreshToken>();
    public DbSet<TravelProfile> TravelProfiles => Set<TravelProfile>();
    public DbSet<Preference> Preferences => Set<Preference>();
    public DbSet<Place> Places => Set<Place>();
    public DbSet<PlaceMedia> PlaceMedia => Set<PlaceMedia>();
    public DbSet<PlaceTag> PlaceTags => Set<PlaceTag>();
    public DbSet<Checkpoint> Checkpoints => Set<Checkpoint>();
    public DbSet<PriceReport> PriceReports => Set<PriceReport>();
    public DbSet<LocalLaw> LocalLaws => Set<LocalLaw>();
    public DbSet<EmergencyContact> EmergencyContacts => Set<EmergencyContact>();
    public DbSet<Trip> Trips => Set<Trip>();
    public DbSet<TripDay> TripDays => Set<TripDay>();
    public DbSet<TripPlace> TripPlaces => Set<TripPlace>();
    public DbSet<ItineraryCost> ItineraryCosts => Set<ItineraryCost>();
    public DbSet<TripRequestRecord> TripRequests => Set<TripRequestRecord>();
    public DbSet<AiGenerationResult> AiGenerationResults => Set<AiGenerationResult>();
    public DbSet<PlaceSuggestion> PlaceSuggestions => Set<PlaceSuggestion>();
    public DbSet<Review> Reviews => Set<Review>();
    public DbSet<Post> Posts => Set<Post>();
    public DbSet<PostMedia> PostMedia => Set<PostMedia>();
    public DbSet<PostTag> PostTags => Set<PostTag>();
    public DbSet<PostLike> PostLikes => Set<PostLike>();
    public DbSet<PostComment> PostComments => Set<PostComment>();
    public DbSet<UserConnection> UserConnections => Set<UserConnection>();
    public DbSet<DirectMessage> DirectMessages => Set<DirectMessage>();
    public DbSet<ChatSession> ChatSessions => Set<ChatSession>();
    public DbSet<ChatMessage> Messages => Set<ChatMessage>();
    public DbSet<QuickPhrase> QuickPhrases => Set<QuickPhrase>();
    public DbSet<TripPhoto> TripPhotos => Set<TripPhoto>();
    public DbSet<TripStat> TripStats => Set<TripStat>();
    public DbSet<FinancialTool> FinancialTools => Set<FinancialTool>();
    public DbSet<SubscriptionPlan> SubscriptionPlans => Set<SubscriptionPlan>();
    public DbSet<Transaction> Transactions => Set<Transaction>();
    public DbSet<Notification> Notifications => Set<Notification>();

    protected override void OnModelCreating(ModelBuilder modelBuilder)
    {
        ConfigureApplicationTables(modelBuilder);
        ConfigureSchemaReferenceTables(modelBuilder);
        SeedData.Seed(modelBuilder);

        base.OnModelCreating(modelBuilder);
    }

    private static void ConfigureApplicationTables(ModelBuilder modelBuilder)
    {
        modelBuilder.Entity<User>(entity =>
        {
            entity.ToTable("users");
            entity.HasKey(x => x.UserId);
            entity.Property(x => x.UserId).HasColumnName("id").HasDefaultValueSql("NEWID()");
            RequiredString(entity, nameof(User.Email), "email", 255);
            String(entity, "DisplayName", "display_name");
            String(entity, "AvatarUrl", "avatar_url");
            String(entity, nameof(User.Nationality), "nationality");
            String(entity, "StatusText", "status_text");
            entity.Property<double?>("CurrentLat").HasColumnName("current_lat");
            entity.Property<double?>("CurrentLng").HasColumnName("current_lng");
            DateTime(entity, "LocationUpdatedAt", "location_updated_at");
            RequiredString(entity, nameof(User.Status), "status").HasDefaultValue("active");
            RequiredString(entity, nameof(User.PasswordHash), "password_hash");
            RequiredString(entity, nameof(User.Language), "language", 10).HasDefaultValue("en");
            String(entity, nameof(User.DietPreference), "diet_preference");
            String(entity, nameof(User.BudgetPreference), "budget_preference");
            entity.Property(x => x.IsEmailVerified).HasColumnName("is_email_verified").HasDefaultValue(false);
            RequiredString(entity, nameof(User.AuthProvider), "auth_provider", 30).HasDefaultValue("email");
            DateTime(entity, nameof(User.DeletedAt), "deleted_at");
            RequiredDateTime(entity, nameof(User.CreatedAt), "created_at").HasDefaultValueSql("SYSUTCDATETIME()");
            RequiredDateTime(entity, nameof(User.UpdatedAt), "updated_at");
            entity.HasIndex(x => x.Email).IsUnique();
        });

        modelBuilder.Entity<AuthOtpCode>(entity =>
        {
            entity.ToTable("auth_otp_codes");
            entity.HasKey(x => x.Id);
            entity.Property(x => x.Id).HasColumnName("id").HasDefaultValueSql("NEWID()");
            RequiredString(entity, nameof(AuthOtpCode.Email), "email", 255);
            RequiredString(entity, nameof(AuthOtpCode.Purpose), "purpose", 50);
            RequiredString(entity, nameof(AuthOtpCode.OtpCodeHash), "otp_code_hash", 255);
            RequiredDateTime(entity, nameof(AuthOtpCode.ExpiresAt), "expires_at");
            DateTime(entity, nameof(AuthOtpCode.ConsumedAt), "consumed_at");
            entity.Property(x => x.AttemptCount).HasColumnName("attempt_count").HasDefaultValue(0);
            RequiredDateTime(entity, nameof(AuthOtpCode.CreatedAt), "created_at").HasDefaultValueSql("SYSUTCDATETIME()");
            entity.HasIndex(x => new { x.Email, x.Purpose });
            entity.HasIndex(x => x.ExpiresAt);
        });

        modelBuilder.Entity<RefreshToken>(entity =>
        {
            entity.ToTable("refresh_tokens");
            entity.HasKey(x => x.Id);
            entity.Property(x => x.Id).HasColumnName("id").HasDefaultValueSql("NEWID()");
            entity.Property(x => x.UserId).HasColumnName("user_id");
            RequiredString(entity, nameof(RefreshToken.TokenHash), "token_hash", 255);
            RequiredDateTime(entity, nameof(RefreshToken.ExpiresAt), "expires_at");
            DateTime(entity, nameof(RefreshToken.RevokedAt), "revoked_at");
            RequiredDateTime(entity, nameof(RefreshToken.CreatedAt), "created_at").HasDefaultValueSql("SYSUTCDATETIME()");
            entity.HasIndex(x => x.TokenHash).IsUnique();
            entity.HasIndex(x => x.UserId);
            entity.HasIndex(x => x.ExpiresAt);
            entity.HasOne(x => x.User).WithMany().HasForeignKey(x => x.UserId).OnDelete(DeleteBehavior.Restrict);
        });

        modelBuilder.Entity<Place>(entity =>
        {
            entity.ToTable("places");
            entity.HasKey(x => x.PlaceId);
            entity.Property(x => x.PlaceId).HasColumnName("id").HasDefaultValueSql("NEWID()");
            RequiredString(entity, nameof(Place.Name), "name");
            entity.Property(x => x.Lat).HasColumnName("latitude").HasPrecision(9, 6);
            entity.Property(x => x.Lng).HasColumnName("longitude").HasPrecision(9, 6);
            RequiredString(entity, nameof(Place.Category), "category");
            Text(entity, nameof(Place.Description), "description");
            Text(entity, "Address", "address");
            String(entity, nameof(Place.City), "city");
            String(entity, nameof(Place.CountryCode), "country_code", 3).IsUnicode(false);
            String(entity, "GooglePlaceId", "google_place_id");
            entity.Property<double>("AvgRating").HasColumnName("avg_rating").HasDefaultValue(0d);
            entity.Property<int>("ReviewCount").HasColumnName("review_count").HasDefaultValue(0);
            String(entity, nameof(Place.OpenHours), "open_hours");
            RequiredString(entity, "Status", "status").HasDefaultValue("active");
            entity.Property(x => x.TrustScore).HasColumnName("trust_score").HasPrecision(4, 2);
            Text(entity, nameof(Place.Tags), "tags");
            String(entity, nameof(Place.PriceLevel), "price_level", 30);
            RequiredDateTime(entity, nameof(Place.CreatedAt), "created_at").HasDefaultValueSql("SYSUTCDATETIME()");
            RequiredDateTime(entity, nameof(Place.UpdatedAt), "updated_at");
        });

        modelBuilder.Entity<Checkpoint>(entity =>
        {
            entity.ToTable("checkpoints");
            entity.HasKey(x => x.CheckpointId);
            entity.Property(x => x.CheckpointId).HasColumnName("id").HasDefaultValueSql("NEWID()");
            entity.Property(x => x.PlaceId).HasColumnName("place_id");
            RequiredString(entity, nameof(Checkpoint.Name), "name");
            Text(entity, nameof(Checkpoint.Description), "description");
            entity.Property(x => x.SortOrder).HasColumnName("sort_order");
            String(entity, nameof(Checkpoint.AudioUrl), "audio_url");
            String(entity, nameof(Checkpoint.ImageUrl), "image_url");
            Text(entity, nameof(Checkpoint.FunFact), "fun_fact");
            entity.Property(x => x.Lat).HasColumnName("latitude").HasPrecision(9, 6);
            entity.Property(x => x.Lng).HasColumnName("longitude").HasPrecision(9, 6);
            RequiredString(entity, "Status", "status").HasDefaultValue("active");
            RequiredDateTime(entity, nameof(Checkpoint.CreatedAt), "created_at").HasDefaultValueSql("SYSUTCDATETIME()");
            RequiredDateTime(entity, nameof(Checkpoint.UpdatedAt), "updated_at");
            entity.HasOne(x => x.Place).WithMany(x => x.Checkpoints).HasForeignKey(x => x.PlaceId).OnDelete(DeleteBehavior.Restrict);
        });

        modelBuilder.Entity<PriceReport>(entity =>
        {
            entity.ToTable("price_reports");
            entity.HasKey(x => x.ReportId);
            entity.Property(x => x.ReportId).HasColumnName("id").HasDefaultValueSql("NEWID()");
            entity.Property(x => x.UserId).HasColumnName("user_id");
            entity.Property(x => x.PlaceId).HasColumnName("place_id");
            RequiredString(entity, nameof(PriceReport.ItemName), "item_name");
            entity.Property(x => x.PriceReported).HasColumnName("price_reported").HasPrecision(18, 2);
            entity.Property(x => x.MarketPriceMin).HasColumnName("market_price_min").HasPrecision(18, 2);
            entity.Property(x => x.MarketPriceMax).HasColumnName("market_price_max").HasPrecision(18, 2);
            String(entity, nameof(PriceReport.Currency), "currency").HasDefaultValue("VND");
            entity.Property(x => x.Lat).HasColumnName("latitude").HasPrecision(9, 6);
            entity.Property(x => x.Lng).HasColumnName("longitude").HasPrecision(9, 6);
            entity.Property<double?>("AiConfidence").HasColumnName("ai_confidence");
            entity.Property<bool>("IsConfirmed").HasColumnName("is_confirmed").HasDefaultValue(false);
            DateTime(entity, nameof(PriceReport.ConfirmedAt), "confirmed_at");
            RequiredString(entity, nameof(PriceReport.Status), "status").HasDefaultValue("pending");
            RequiredDateTime(entity, nameof(PriceReport.CreatedAt), "created_at").HasDefaultValueSql("SYSUTCDATETIME()");
            entity.HasOne<User>().WithMany().HasForeignKey(x => x.UserId).OnDelete(DeleteBehavior.Restrict);
            entity.HasOne<Place>().WithMany().HasForeignKey(x => x.PlaceId).OnDelete(DeleteBehavior.Restrict);
        });

        modelBuilder.Entity<Trip>(entity =>
        {
            entity.ToTable("itineraries");
            entity.HasKey(x => x.TripId);
            entity.Property(x => x.TripId).HasColumnName("id").HasDefaultValueSql("NEWID()");
            entity.Property(x => x.UserId).HasColumnName("user_id");
            entity.Property<Guid?>("TripRequestId").HasColumnName("trip_request_id");
            RequiredString(entity, nameof(Trip.Name), "name");
            RequiredString(entity, "Source", "source").HasDefaultValue("manual");
            String(entity, nameof(Trip.Destination), "destination");
            String(entity, nameof(Trip.CountryCode), "country_code", 3).IsUnicode(false);
            entity.Property(x => x.StartDate).HasColumnName("start_date");
            entity.Property(x => x.EndDate).HasColumnName("end_date");
            entity.Property<int?>("NumDays").HasColumnName("num_days");
            entity.Property(x => x.PeopleCount).HasColumnName("people_count");
            entity.Property(x => x.Budget).HasColumnName("budget_total").HasPrecision(18, 2);
            String(entity, "BudgetCurrency", "budget_currency", 3).IsUnicode(false).HasDefaultValue("USD");
            entity.Property<bool>("IsPublished").HasColumnName("is_published").HasDefaultValue(false);
            entity.Property(x => x.Status).HasColumnName("status").HasConversion<string>().HasMaxLength(30);
            RequiredDateTime(entity, nameof(Trip.CreatedAt), "created_at").HasDefaultValueSql("SYSUTCDATETIME()");
            RequiredDateTime(entity, nameof(Trip.UpdatedAt), "updated_at");
            entity.HasOne(x => x.User).WithMany(x => x.Trips).HasForeignKey(x => x.UserId).OnDelete(DeleteBehavior.Restrict);
            entity.HasOne<TripRequestRecord>().WithMany().HasForeignKey("TripRequestId").OnDelete(DeleteBehavior.Restrict);
        });

        modelBuilder.Entity<TripDay>(entity =>
        {
            entity.ToTable("daily_schedules");
            entity.HasKey(x => x.DayId);
            entity.Property(x => x.DayId).HasColumnName("id").HasDefaultValueSql("NEWID()");
            entity.Property(x => x.TripId).HasColumnName("itinerary_id");
            entity.Property(x => x.Date).HasColumnName("schedule_date");
            entity.Property(x => x.DayNumber).HasColumnName("day_number").HasDefaultValue(1);
            entity.Property(x => x.RouteOptimized).HasColumnName("route_optimized").HasDefaultValue(false);
            RequiredString(entity, "Status", "status").HasDefaultValue("active");
            RequiredDateTime(entity, nameof(TripDay.CreatedAt), "created_at").HasDefaultValueSql("SYSUTCDATETIME()");
            RequiredDateTime(entity, nameof(TripDay.UpdatedAt), "updated_at");
            entity.HasOne(x => x.Trip).WithMany(x => x.TripDays).HasForeignKey(x => x.TripId).OnDelete(DeleteBehavior.Restrict);
        });

        modelBuilder.Entity<TripPlace>(entity =>
        {
            entity.ToTable("itinerary_items");
            entity.HasKey(x => x.TripPlaceId);
            entity.Property(x => x.TripPlaceId).HasColumnName("id").HasDefaultValueSql("NEWID()");
            entity.Property(x => x.DayId).HasColumnName("daily_schedule_id");
            entity.Property(x => x.PlaceId).HasColumnName("place_id");
            TimeOnly(entity, "VisitTime", "visit_time");
            String(entity, "TransportMode", "transport_mode");
            entity.Property<int?>("DurationMinutes").HasColumnName("duration_minutes");
            entity.Property(x => x.SortOrder).HasColumnName("sort_order");
            entity.Property(x => x.Status).HasColumnName("activity_status").HasMaxLength(30).HasDefaultValue("upcoming");
            DateTime(entity, "CompletedAt", "completed_at");
            DateTime(entity, nameof(TripPlace.EstimatedArrivalTime), "estimated_arrival_time");
            DateTime(entity, nameof(TripPlace.VisitedAt), "visited_at");
            RequiredString(entity, "StatusRow", "status").HasDefaultValue("active");
            RequiredDateTime(entity, nameof(TripPlace.CreatedAt), "created_at").HasDefaultValueSql("SYSUTCDATETIME()");
            RequiredDateTime(entity, nameof(TripPlace.UpdatedAt), "updated_at");
            entity.HasOne(x => x.TripDay).WithMany(x => x.TripPlaces).HasForeignKey(x => x.DayId).OnDelete(DeleteBehavior.Restrict);
            entity.HasOne(x => x.Place).WithMany().HasForeignKey(x => x.PlaceId).OnDelete(DeleteBehavior.Restrict);
        });

        modelBuilder.Entity<Review>(entity =>
        {
            entity.ToTable("reviews");
            entity.HasKey(x => x.ReviewId);
            entity.Property(x => x.ReviewId).HasColumnName("id").HasDefaultValueSql("NEWID()");
            entity.Property(x => x.PlaceId).HasColumnName("place_id");
            entity.Property(x => x.UserId).HasColumnName("user_id");
            entity.Property(x => x.Rating).HasColumnName("rating");
            Text(entity, nameof(Review.Comment), "content");
            String(entity, nameof(Review.ImageUrl), "image_url");
            entity.Property<double?>("TrustScore").HasColumnName("trust_score");
            entity.Property(x => x.IsVerified).HasColumnName("is_verified").HasDefaultValue(false);
            entity.Property<double?>("GpsProofLat").HasColumnName("gps_proof_lat");
            entity.Property<double?>("GpsProofLng").HasColumnName("gps_proof_lng");
            String(entity, nameof(Review.GpsProof), "gps_proof");
            entity.Property(x => x.ExifVerified).HasColumnName("exif_verified").HasDefaultValue(false);
            DateTime(entity, "VerifiedAt", "verified_at");
            DateTime(entity, nameof(Review.DeletedAt), "deleted_at");
            RequiredString(entity, "Status", "status").HasDefaultValue("active");
            RequiredDateTime(entity, nameof(Review.CreatedAt), "created_at").HasDefaultValueSql("SYSUTCDATETIME()");
            RequiredDateTime(entity, nameof(Review.UpdatedAt), "updated_at");
            entity.HasIndex(x => new { x.PlaceId, x.UserId }).IsUnique();
            entity.HasOne(x => x.Place).WithMany().HasForeignKey(x => x.PlaceId).OnDelete(DeleteBehavior.Restrict);
            entity.HasOne(x => x.User).WithMany().HasForeignKey(x => x.UserId).OnDelete(DeleteBehavior.Restrict);
        });

        modelBuilder.Entity<UserConnection>(entity =>
        {
            entity.ToTable("traveler_connections");
            entity.HasKey(x => x.ConnectionId);
            entity.Property(x => x.ConnectionId).HasColumnName("id").HasDefaultValueSql("NEWID()");
            entity.Property(x => x.UserId1).HasColumnName("sender_id");
            entity.Property(x => x.UserId2).HasColumnName("receiver_id");
            RequiredString(entity, nameof(UserConnection.Status), "status").HasDefaultValue("pending");
            RequiredDateTime(entity, nameof(UserConnection.CreatedAt), "created_at").HasDefaultValueSql("SYSUTCDATETIME()");
            RequiredDateTime(entity, nameof(UserConnection.UpdatedAt), "updated_at");
            entity.HasIndex(x => new { x.UserId1, x.UserId2 }).IsUnique();
            entity.HasOne<User>().WithMany().HasForeignKey(x => x.UserId1).OnDelete(DeleteBehavior.Restrict);
            entity.HasOne<User>().WithMany().HasForeignKey(x => x.UserId2).OnDelete(DeleteBehavior.Restrict);
        });

        modelBuilder.Entity<Notification>(entity =>
        {
            entity.ToTable("notifications");
            entity.HasKey(x => x.NotificationId);
            entity.Property(x => x.NotificationId).HasColumnName("id").HasDefaultValueSql("NEWID()");
            entity.Property(x => x.UserId).HasColumnName("user_id");
            RequiredString(entity, nameof(Notification.Type), "type");
            RequiredString(entity, nameof(Notification.Title), "title");
            Text(entity, nameof(Notification.Content), "content").IsRequired();
            entity.Property<Guid?>("ReferenceId").HasColumnName("reference_id");
            String(entity, "ReferenceType", "reference_type");
            entity.Property(x => x.IsRead).HasColumnName("is_read").HasDefaultValue(false);
            entity.Property(x => x.Priority).HasColumnName("priority").HasConversion<string>().HasMaxLength(30);
            RequiredString(entity, "Status", "status").HasDefaultValue("active");
            RequiredDateTime(entity, nameof(Notification.CreatedAt), "created_at").HasDefaultValueSql("SYSUTCDATETIME()");
            entity.HasOne<User>().WithMany().HasForeignKey(x => x.UserId).OnDelete(DeleteBehavior.Restrict);
        });
    }

    private static void ConfigureSchemaReferenceTables(ModelBuilder modelBuilder)
    {
        modelBuilder.Entity<TravelProfile>(entity =>
        {
            ConfigureId(entity, "travel_profiles");
            entity.Property<Guid>("UserId").HasColumnName("user_id");
            String(entity, "TravelStyle", "travel_style");
            Text(entity, "Description", "description");
            RequiredString(entity, "Status", "status").HasDefaultValue("active");
            RequiredDateTime(entity, "CreatedAt", "created_at").HasDefaultValueSql("SYSUTCDATETIME()");
            DateTime(entity, "UpdatedAt", "updated_at");
            entity.HasOne<User>().WithMany().HasForeignKey("UserId").OnDelete(DeleteBehavior.Restrict);
        });

        modelBuilder.Entity<Preference>(entity =>
        {
            ConfigureId(entity, "preferences");
            entity.Property<Guid>("UserId").HasColumnName("user_id");
            RequiredString(entity, "Type", "type");
            RequiredString(entity, "Value", "value");
            RequiredString(entity, "Status", "status").HasDefaultValue("active");
            RequiredDateTime(entity, "CreatedAt", "created_at").HasDefaultValueSql("SYSUTCDATETIME()");
            entity.HasOne<User>().WithMany().HasForeignKey("UserId").OnDelete(DeleteBehavior.Restrict);
        });

        modelBuilder.Entity<PlaceMedia>(entity =>
        {
            ConfigureId(entity, "place_media");
            entity.Property<Guid>("PlaceId").HasColumnName("place_id");
            RequiredString(entity, "Url", "url");
            RequiredString(entity, "MediaType", "media_type");
            RequiredString(entity, "Source", "source");
            entity.Property<bool>("IsCover").HasColumnName("is_cover").HasDefaultValue(false);
            entity.Property<int>("SortOrder").HasColumnName("sort_order").HasDefaultValue(0);
            RequiredString(entity, "Status", "status").HasDefaultValue("active");
            RequiredDateTime(entity, "UploadedAt", "uploaded_at").HasDefaultValueSql("SYSUTCDATETIME()");
            entity.HasOne<Place>().WithMany().HasForeignKey("PlaceId").OnDelete(DeleteBehavior.Restrict);
        });

        modelBuilder.Entity<PlaceTag>(entity =>
        {
            ConfigureId(entity, "place_tags");
            entity.Property<Guid>("PlaceId").HasColumnName("place_id");
            RequiredString(entity, "Tag", "tag");
            RequiredString(entity, "TagGroup", "tag_group");
            RequiredString(entity, "Status", "status").HasDefaultValue("active");
            entity.HasIndex("PlaceId", "Tag").IsUnique();
            entity.HasOne<Place>().WithMany().HasForeignKey("PlaceId").OnDelete(DeleteBehavior.Restrict);
        });

        modelBuilder.Entity<LocalLaw>(entity =>
        {
            ConfigureId(entity, "local_laws");
            RequiredString(entity, "Region", "region");
            RequiredString(entity, "Category", "category");
            Text(entity, "Description", "description").IsRequired();
            RequiredString(entity, "Status", "status").HasDefaultValue("active");
            RequiredDateTime(entity, "CreatedAt", "created_at").HasDefaultValueSql("SYSUTCDATETIME()");
            DateTime(entity, "UpdatedAt", "updated_at");
        });

        modelBuilder.Entity<EmergencyContact>(entity =>
        {
            ConfigureId(entity, "emergency_contacts");
            RequiredString(entity, "Region", "region");
            RequiredString(entity, "Type", "type");
            RequiredString(entity, "Name", "name");
            RequiredString(entity, "Phone", "phone");
            RequiredString(entity, "Status", "status").HasDefaultValue("active");
            RequiredDateTime(entity, "CreatedAt", "created_at").HasDefaultValueSql("SYSUTCDATETIME()");
            DateTime(entity, "UpdatedAt", "updated_at");
        });

        modelBuilder.Entity<ItineraryCost>(entity =>
        {
            ConfigureId(entity, "itinerary_costs");
            entity.Property<Guid>("ItineraryId").HasColumnName("itinerary_id");
            RequiredString(entity, "Category", "category");
            entity.Property<decimal?>("EstimatedAmount").HasColumnName("estimated_amount").HasPrecision(18, 2);
            String(entity, "Currency", "currency", 3).IsUnicode(false);
            Text(entity, "Note", "note");
            RequiredString(entity, "Status", "status").HasDefaultValue("active");
            entity.HasIndex("ItineraryId", "Category").IsUnique();
            entity.HasOne<Trip>().WithMany().HasForeignKey("ItineraryId").OnDelete(DeleteBehavior.Restrict);
        });

        modelBuilder.Entity<TripRequestRecord>(entity =>
        {
            ConfigureId(entity, "trip_requests");
            entity.Property<Guid>("UserId").HasColumnName("user_id");
            RequiredString(entity, "Destination", "destination");
            entity.Property<int>("NumDays").HasColumnName("num_days");
            entity.Property<decimal?>("Budget").HasColumnName("budget").HasPrecision(18, 2);
            String(entity, "Currency", "currency").HasDefaultValue("USD");
            String(entity, "TravelStyle", "travel_style");
            String(entity, "Interests", "interests");
            Text(entity, "ExtraNote", "extra_note");
            RequiredString(entity, "Status", "status").HasDefaultValue("pending");
            RequiredDateTime(entity, "CreatedAt", "created_at").HasDefaultValueSql("SYSUTCDATETIME()");
            entity.HasOne<User>().WithMany().HasForeignKey("UserId").OnDelete(DeleteBehavior.Restrict);
        });

        modelBuilder.Entity<AiGenerationResult>(entity =>
        {
            ConfigureId(entity, "ai_generation_results");
            entity.Property<Guid>("TripRequestId").HasColumnName("trip_request_id");
            entity.Property<Guid?>("ItineraryId").HasColumnName("itinerary_id");
            String(entity, "ModelUsed", "model_used");
            entity.Property<int?>("PromptTokens").HasColumnName("prompt_tokens");
            entity.Property<int?>("CompletionTokens").HasColumnName("completion_tokens");
            RequiredString(entity, "Status", "status").HasDefaultValue("active");
            RequiredDateTime(entity, "GeneratedAt", "generated_at").HasDefaultValueSql("SYSUTCDATETIME()");
            entity.HasOne<TripRequestRecord>().WithMany().HasForeignKey("TripRequestId").OnDelete(DeleteBehavior.Restrict);
            entity.HasOne<Trip>().WithMany().HasForeignKey("ItineraryId").OnDelete(DeleteBehavior.Restrict);
        });

        modelBuilder.Entity<PlaceSuggestion>(entity =>
        {
            ConfigureId(entity, "place_suggestions");
            entity.Property<Guid>("TripRequestId").HasColumnName("trip_request_id");
            entity.Property<Guid>("PlaceId").HasColumnName("place_id");
            Text(entity, "Reason", "reason");
            entity.Property<double?>("AiScore").HasColumnName("ai_score");
            String(entity, "Category", "category");
            entity.Property<int?>("SortOrder").HasColumnName("sort_order");
            RequiredString(entity, "Status", "status").HasDefaultValue("active");
            entity.HasOne<TripRequestRecord>().WithMany().HasForeignKey("TripRequestId").OnDelete(DeleteBehavior.Restrict);
            entity.HasOne<Place>().WithMany().HasForeignKey("PlaceId").OnDelete(DeleteBehavior.Restrict);
        });

        modelBuilder.Entity<Post>(entity =>
        {
            ConfigureId(entity, "posts");
            entity.Property<Guid>("UserId").HasColumnName("user_id");
            entity.Property<Guid?>("ItineraryId").HasColumnName("itinerary_id");
            RequiredString(entity, "Title", "title");
            Text(entity, "Body", "body");
            RequiredString(entity, "PostType", "post_type").HasDefaultValue("blog");
            entity.Property<Guid?>("ParentPostId").HasColumnName("parent_post_id");
            entity.Property<int>("ViewCount").HasColumnName("view_count").HasDefaultValue(0);
            entity.Property<int>("ShareCount").HasColumnName("share_count").HasDefaultValue(0);
            DateTime(entity, "PublishedAt", "published_at");
            RequiredString(entity, "Status", "status").HasDefaultValue("draft");
            RequiredDateTime(entity, "CreatedAt", "created_at").HasDefaultValueSql("SYSUTCDATETIME()");
            DateTime(entity, "UpdatedAt", "updated_at");
            entity.HasOne<User>().WithMany().HasForeignKey("UserId").OnDelete(DeleteBehavior.Restrict);
            entity.HasOne<Trip>().WithMany().HasForeignKey("ItineraryId").OnDelete(DeleteBehavior.Restrict);
            entity.HasOne<Post>().WithMany().HasForeignKey("ParentPostId").OnDelete(DeleteBehavior.Restrict);
        });

        modelBuilder.Entity<PostMedia>(entity =>
        {
            ConfigureId(entity, "post_media");
            entity.Property<Guid>("PostId").HasColumnName("post_id");
            RequiredString(entity, "Url", "url");
            RequiredString(entity, "MediaType", "media_type");
            entity.Property<int>("SortOrder").HasColumnName("sort_order").HasDefaultValue(0);
            RequiredString(entity, "Status", "status").HasDefaultValue("active");
            RequiredDateTime(entity, "CreatedAt", "created_at").HasDefaultValueSql("SYSUTCDATETIME()");
            entity.HasOne<Post>().WithMany().HasForeignKey("PostId").OnDelete(DeleteBehavior.Restrict);
        });

        modelBuilder.Entity<PostTag>(entity =>
        {
            ConfigureId(entity, "post_tags");
            entity.Property<Guid>("PostId").HasColumnName("post_id");
            RequiredString(entity, "Tag", "tag");
            RequiredString(entity, "Status", "status").HasDefaultValue("active");
            entity.HasOne<Post>().WithMany().HasForeignKey("PostId").OnDelete(DeleteBehavior.Restrict);
        });

        modelBuilder.Entity<PostLike>(entity =>
        {
            ConfigureId(entity, "post_likes");
            entity.Property<Guid>("PostId").HasColumnName("post_id");
            entity.Property<Guid>("UserId").HasColumnName("user_id");
            RequiredString(entity, "Status", "status").HasDefaultValue("active");
            RequiredDateTime(entity, "CreatedAt", "created_at").HasDefaultValueSql("SYSUTCDATETIME()");
            entity.HasIndex("PostId", "UserId").IsUnique();
            entity.HasOne<Post>().WithMany().HasForeignKey("PostId").OnDelete(DeleteBehavior.Restrict);
            entity.HasOne<User>().WithMany().HasForeignKey("UserId").OnDelete(DeleteBehavior.Restrict);
        });

        modelBuilder.Entity<PostComment>(entity =>
        {
            ConfigureId(entity, "post_comments");
            entity.Property<Guid>("PostId").HasColumnName("post_id");
            entity.Property<Guid>("UserId").HasColumnName("user_id");
            entity.Property<Guid?>("ParentId").HasColumnName("parent_id");
            Text(entity, "Content", "content").IsRequired();
            RequiredString(entity, "Status", "status").HasDefaultValue("active");
            RequiredDateTime(entity, "CreatedAt", "created_at").HasDefaultValueSql("SYSUTCDATETIME()");
            DateTime(entity, "UpdatedAt", "updated_at");
            entity.HasOne<Post>().WithMany().HasForeignKey("PostId").OnDelete(DeleteBehavior.Restrict);
            entity.HasOne<User>().WithMany().HasForeignKey("UserId").OnDelete(DeleteBehavior.Restrict);
            entity.HasOne<PostComment>().WithMany().HasForeignKey("ParentId").OnDelete(DeleteBehavior.Restrict);
        });

        modelBuilder.Entity<DirectMessage>(entity =>
        {
            ConfigureId(entity, "direct_messages");
            entity.Property<Guid>("SenderId").HasColumnName("sender_id");
            entity.Property<Guid>("ReceiverId").HasColumnName("receiver_id");
            Text(entity, "Content", "content").IsRequired();
            entity.Property<bool>("IsRead").HasColumnName("is_read").HasDefaultValue(false);
            RequiredString(entity, "Status", "status").HasDefaultValue("active");
            RequiredDateTime(entity, "SentAt", "sent_at").HasDefaultValueSql("SYSUTCDATETIME()");
            entity.HasOne<User>().WithMany().HasForeignKey("SenderId").OnDelete(DeleteBehavior.Restrict);
            entity.HasOne<User>().WithMany().HasForeignKey("ReceiverId").OnDelete(DeleteBehavior.Restrict);
        });

        modelBuilder.Entity<ChatSession>(entity =>
        {
            ConfigureId(entity, "chat_sessions");
            entity.Property<Guid>("UserId").HasColumnName("user_id");
            entity.Property<Guid?>("ItineraryId").HasColumnName("itinerary_id");
            RequiredDateTime(entity, "StartedAt", "started_at").HasDefaultValueSql("SYSUTCDATETIME()");
            DateTime(entity, "EndedAt", "ended_at");
            RequiredString(entity, "Status", "status").HasDefaultValue("active");
            entity.HasOne<User>().WithMany().HasForeignKey("UserId").OnDelete(DeleteBehavior.Restrict);
            entity.HasOne<Trip>().WithMany().HasForeignKey("ItineraryId").OnDelete(DeleteBehavior.Restrict);
        });

        modelBuilder.Entity<ChatMessage>(entity =>
        {
            ConfigureId(entity, "messages");
            entity.Property<Guid>("ChatSessionId").HasColumnName("chat_session_id");
            RequiredString(entity, "Role", "role");
            Text(entity, "Content", "content").IsRequired();
            RequiredString(entity, "Status", "status").HasDefaultValue("active");
            RequiredDateTime(entity, "SentAt", "sent_at").HasDefaultValueSql("SYSUTCDATETIME()");
            entity.HasOne<ChatSession>().WithMany().HasForeignKey("ChatSessionId").OnDelete(DeleteBehavior.Restrict);
        });

        modelBuilder.Entity<QuickPhrase>(entity =>
        {
            ConfigureId(entity, "quick_phrases");
            RequiredString(entity, "Category", "category");
            RequiredString(entity, "LocalText", "local_text");
            RequiredString(entity, "TranslatedText", "translated_text");
            String(entity, "LanguageCode", "language_code", 5).IsUnicode(false);
            String(entity, "AudioUrl", "audio_url");
            entity.Property<int?>("SortOrder").HasColumnName("sort_order");
            RequiredString(entity, "Status", "status").HasDefaultValue("active");
            RequiredDateTime(entity, "CreatedAt", "created_at").HasDefaultValueSql("SYSUTCDATETIME()");
        });

        modelBuilder.Entity<TripPhoto>(entity =>
        {
            ConfigureId(entity, "trip_photos");
            entity.Property<Guid>("UserId").HasColumnName("user_id");
            entity.Property<Guid>("ItineraryId").HasColumnName("itinerary_id");
            entity.Property<Guid?>("ItineraryItemId").HasColumnName("itinerary_item_id");
            RequiredString(entity, "Url", "url");
            String(entity, "ThumbnailUrl", "thumbnail_url");
            entity.Property<double?>("Latitude").HasColumnName("latitude");
            entity.Property<double?>("Longitude").HasColumnName("longitude");
            Text(entity, "Caption", "caption");
            RequiredString(entity, "Status", "status").HasDefaultValue("active");
            DateTime(entity, "TakenAt", "taken_at");
            RequiredDateTime(entity, "CreatedAt", "created_at").HasDefaultValueSql("SYSUTCDATETIME()");
            entity.HasOne<User>().WithMany().HasForeignKey("UserId").OnDelete(DeleteBehavior.Restrict);
            entity.HasOne<Trip>().WithMany().HasForeignKey("ItineraryId").OnDelete(DeleteBehavior.Restrict);
            entity.HasOne<TripPlace>().WithMany().HasForeignKey("ItineraryItemId").OnDelete(DeleteBehavior.Restrict);
        });

        modelBuilder.Entity<TripStat>(entity =>
        {
            ConfigureId(entity, "trip_stats");
            entity.Property<Guid>("ItineraryId").HasColumnName("itinerary_id");
            entity.Property<int>("TotalPhotos").HasColumnName("total_photos").HasDefaultValue(0);
            entity.Property<int>("PlacesVisited").HasColumnName("places_visited").HasDefaultValue(0);
            entity.Property<double>("TotalDistanceKm").HasColumnName("total_distance_km").HasDefaultValue(0d);
            entity.Property<int>("NewFriendsCount").HasColumnName("new_friends_count").HasDefaultValue(0);
            entity.Property<int>("ActivitiesDone").HasColumnName("activities_done").HasDefaultValue(0);
            entity.Property<int>("ActivitiesTotal").HasColumnName("activities_total").HasDefaultValue(0);
            RequiredString(entity, "Status", "status").HasDefaultValue("active");
            DateTime(entity, "UpdatedAt", "updated_at");
            entity.HasOne<Trip>().WithMany().HasForeignKey("ItineraryId").OnDelete(DeleteBehavior.Restrict);
        });

        modelBuilder.Entity<FinancialTool>(entity =>
        {
            ConfigureId(entity, "financial_tools");
            RequiredString(entity, "FromCurrency", "from_currency");
            RequiredString(entity, "ToCurrency", "to_currency");
            entity.Property<double>("ExchangeRate").HasColumnName("exchange_rate");
            String(entity, "PaymentMethod", "payment_method");
            RequiredString(entity, "Status", "status").HasDefaultValue("active");
            RequiredDateTime(entity, "UpdatedAt", "updated_at").HasDefaultValueSql("SYSUTCDATETIME()");
            entity.HasIndex("FromCurrency", "ToCurrency").IsUnique();
        });

        modelBuilder.Entity<SubscriptionPlan>(entity =>
        {
            ConfigureId(entity, "subscription_plans");
            RequiredString(entity, "Name", "name");
            entity.Property<int>("DurationDays").HasColumnName("duration_days");
            entity.Property<decimal>("Price").HasColumnName("price").HasPrecision(18, 2);
            RequiredString(entity, "Tier", "tier");
            RequiredString(entity, "Status", "status").HasDefaultValue("active");
            RequiredDateTime(entity, "CreatedAt", "created_at").HasDefaultValueSql("SYSUTCDATETIME()");
        });

        modelBuilder.Entity<Transaction>(entity =>
        {
            ConfigureId(entity, "transactions");
            entity.Property<Guid>("UserId").HasColumnName("user_id");
            entity.Property<Guid>("PlanId").HasColumnName("plan_id");
            entity.Property<decimal>("Amount").HasColumnName("amount").HasPrecision(18, 2);
            String(entity, "Currency", "currency").HasDefaultValue("USD");
            RequiredString(entity, "Status", "status").HasDefaultValue("pending");
            DateTime(entity, "PaidAt", "paid_at");
            RequiredDateTime(entity, "CreatedAt", "created_at").HasDefaultValueSql("SYSUTCDATETIME()");
            entity.HasOne<User>().WithMany().HasForeignKey("UserId").OnDelete(DeleteBehavior.Restrict);
            entity.HasOne<SubscriptionPlan>().WithMany().HasForeignKey("PlanId").OnDelete(DeleteBehavior.Restrict);
        });
    }

    private static void ConfigureId<TEntity>(EntityTypeBuilder<TEntity> entity, string tableName)
        where TEntity : class
    {
        entity.ToTable(tableName);
        entity.HasKey("Id");
        entity.Property<Guid>("Id").HasColumnName("id").HasDefaultValueSql("NEWID()");
    }

    private static PropertyBuilder<string> RequiredString(EntityTypeBuilder entity, string propertyName, string columnName, int maxLength = 255)
        => String(entity, propertyName, columnName, maxLength).IsRequired();

    private static PropertyBuilder<string> String(EntityTypeBuilder entity, string propertyName, string columnName, int maxLength = 255)
        => entity.Property<string>(propertyName).HasColumnName(columnName).HasMaxLength(maxLength);

    private static PropertyBuilder<string> Text(EntityTypeBuilder entity, string propertyName, string columnName)
        => entity.Property<string>(propertyName).HasColumnName(columnName).HasColumnType("nvarchar(max)");

    private static PropertyBuilder<DateTime> RequiredDateTime(EntityTypeBuilder entity, string propertyName, string columnName)
        => entity.Property<DateTime>(propertyName).HasColumnName(columnName).HasColumnType("datetime2");

    private static PropertyBuilder<DateTime?> DateTime(EntityTypeBuilder entity, string propertyName, string columnName)
        => entity.Property<DateTime?>(propertyName).HasColumnName(columnName).HasColumnType("datetime2");

    private static PropertyBuilder<TimeOnly?> TimeOnly(EntityTypeBuilder entity, string propertyName, string columnName)
        => entity.Property<TimeOnly?>(propertyName).HasColumnName(columnName).HasColumnType("time");
}
