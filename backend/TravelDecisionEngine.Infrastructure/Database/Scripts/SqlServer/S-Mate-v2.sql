IF OBJECT_ID(N'[__EFMigrationsHistory]') IS NULL
BEGIN
    CREATE TABLE [__EFMigrationsHistory] (
        [MigrationId] nvarchar(150) NOT NULL,
        [ProductVersion] nvarchar(32) NOT NULL,
        CONSTRAINT [PK___EFMigrationsHistory] PRIMARY KEY ([MigrationId])
    );
END;
GO

BEGIN TRANSACTION;
GO

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260522115500_InitialCreate'
)
BEGIN
    CREATE TABLE [emergency_contacts] (
        [id] uniqueidentifier NOT NULL DEFAULT (NEWID()),
        [created_at] datetime2 NOT NULL DEFAULT (SYSUTCDATETIME()),
        [name] nvarchar(255) NOT NULL,
        [phone] nvarchar(255) NOT NULL,
        [region] nvarchar(255) NOT NULL,
        [status] nvarchar(255) NOT NULL DEFAULT N'active',
        [type] nvarchar(255) NOT NULL,
        [updated_at] datetime2 NULL,
        CONSTRAINT [PK_emergency_contacts] PRIMARY KEY ([id])
    );
END;
GO

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260522115500_InitialCreate'
)
BEGIN
    CREATE TABLE [financial_tools] (
        [id] uniqueidentifier NOT NULL DEFAULT (NEWID()),
        [exchange_rate] float NOT NULL,
        [from_currency] nvarchar(255) NOT NULL,
        [payment_method] nvarchar(255) NULL,
        [status] nvarchar(255) NOT NULL DEFAULT N'active',
        [to_currency] nvarchar(255) NOT NULL,
        [updated_at] datetime2 NOT NULL DEFAULT (SYSUTCDATETIME()),
        CONSTRAINT [PK_financial_tools] PRIMARY KEY ([id])
    );
END;
GO

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260522115500_InitialCreate'
)
BEGIN
    CREATE TABLE [local_laws] (
        [id] uniqueidentifier NOT NULL DEFAULT (NEWID()),
        [category] nvarchar(255) NOT NULL,
        [created_at] datetime2 NOT NULL DEFAULT (SYSUTCDATETIME()),
        [description] nvarchar(max) NOT NULL,
        [region] nvarchar(255) NOT NULL,
        [status] nvarchar(255) NOT NULL DEFAULT N'active',
        [updated_at] datetime2 NULL,
        CONSTRAINT [PK_local_laws] PRIMARY KEY ([id])
    );
END;
GO

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260522115500_InitialCreate'
)
BEGIN
    CREATE TABLE [places] (
        [id] uniqueidentifier NOT NULL DEFAULT (NEWID()),
        [name] nvarchar(255) NOT NULL,
        [description] nvarchar(max) NOT NULL,
        [latitude] decimal(9,6) NOT NULL,
        [longitude] decimal(9,6) NOT NULL,
        [city] nvarchar(255) NOT NULL,
        [country_code] varchar(3) NOT NULL,
        [category] nvarchar(255) NOT NULL,
        [trust_score] decimal(4,2) NOT NULL,
        [tags] nvarchar(max) NOT NULL,
        [open_hours] nvarchar(255) NOT NULL,
        [price_level] nvarchar(30) NOT NULL,
        [address] nvarchar(max) NULL,
        [avg_rating] float NOT NULL DEFAULT 0.0E0,
        [google_place_id] nvarchar(255) NULL,
        [review_count] int NOT NULL DEFAULT 0,
        [status] nvarchar(255) NOT NULL DEFAULT N'active',
        [created_at] datetime2 NOT NULL DEFAULT (SYSUTCDATETIME()),
        [updated_at] datetime2 NOT NULL,
        CONSTRAINT [PK_places] PRIMARY KEY ([id])
    );
END;
GO

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260522115500_InitialCreate'
)
BEGIN
    CREATE TABLE [quick_phrases] (
        [id] uniqueidentifier NOT NULL DEFAULT (NEWID()),
        [audio_url] nvarchar(255) NULL,
        [category] nvarchar(255) NOT NULL,
        [created_at] datetime2 NOT NULL DEFAULT (SYSUTCDATETIME()),
        [language_code] varchar(5) NULL,
        [local_text] nvarchar(255) NOT NULL,
        [sort_order] int NULL,
        [status] nvarchar(255) NOT NULL DEFAULT N'active',
        [translated_text] nvarchar(255) NOT NULL,
        CONSTRAINT [PK_quick_phrases] PRIMARY KEY ([id])
    );
END;
GO

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260522115500_InitialCreate'
)
BEGIN
    CREATE TABLE [subscription_plans] (
        [id] uniqueidentifier NOT NULL DEFAULT (NEWID()),
        [created_at] datetime2 NOT NULL DEFAULT (SYSUTCDATETIME()),
        [duration_days] int NOT NULL,
        [name] nvarchar(255) NOT NULL,
        [price] decimal(18,2) NOT NULL,
        [status] nvarchar(255) NOT NULL DEFAULT N'active',
        [tier] nvarchar(255) NOT NULL,
        CONSTRAINT [PK_subscription_plans] PRIMARY KEY ([id])
    );
END;
GO

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260522115500_InitialCreate'
)
BEGIN
    CREATE TABLE [users] (
        [id] uniqueidentifier NOT NULL DEFAULT (NEWID()),
        [email] nvarchar(255) NOT NULL,
        [password_hash] nvarchar(255) NOT NULL,
        [nationality] nvarchar(255) NULL,
        [language] nvarchar(10) NOT NULL DEFAULT N'en',
        [diet_preference] nvarchar(255) NULL,
        [budget_preference] nvarchar(255) NULL,
        [is_email_verified] bit NOT NULL DEFAULT CAST(0 AS bit),
        [auth_provider] nvarchar(30) NOT NULL DEFAULT N'email',
        [deleted_at] datetime2 NULL,
        [avatar_url] nvarchar(255) NULL,
        [current_lat] float NULL,
        [current_lng] float NULL,
        [display_name] nvarchar(255) NULL,
        [location_updated_at] datetime2 NULL,
        [status] nvarchar(255) NOT NULL DEFAULT N'active',
        [status_text] nvarchar(255) NULL,
        [created_at] datetime2 NOT NULL DEFAULT (SYSUTCDATETIME()),
        [updated_at] datetime2 NOT NULL,
        CONSTRAINT [PK_users] PRIMARY KEY ([id])
    );
END;
GO

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260522115500_InitialCreate'
)
BEGIN
    CREATE TABLE [checkpoints] (
        [id] uniqueidentifier NOT NULL DEFAULT (NEWID()),
        [place_id] uniqueidentifier NOT NULL,
        [name] nvarchar(255) NOT NULL,
        [description] nvarchar(max) NOT NULL,
        [sort_order] int NOT NULL,
        [audio_url] nvarchar(255) NULL,
        [image_url] nvarchar(255) NULL,
        [fun_fact] nvarchar(max) NULL,
        [latitude] decimal(9,6) NOT NULL,
        [longitude] decimal(9,6) NOT NULL,
        [status] nvarchar(255) NOT NULL DEFAULT N'active',
        [created_at] datetime2 NOT NULL DEFAULT (SYSUTCDATETIME()),
        [updated_at] datetime2 NOT NULL,
        CONSTRAINT [PK_checkpoints] PRIMARY KEY ([id]),
        CONSTRAINT [FK_checkpoints_places_place_id] FOREIGN KEY ([place_id]) REFERENCES [places] ([id]) ON DELETE NO ACTION
    );
END;
GO

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260522115500_InitialCreate'
)
BEGIN
    CREATE TABLE [place_media] (
        [id] uniqueidentifier NOT NULL DEFAULT (NEWID()),
        [is_cover] bit NOT NULL DEFAULT CAST(0 AS bit),
        [media_type] nvarchar(255) NOT NULL,
        [place_id] uniqueidentifier NOT NULL,
        [sort_order] int NOT NULL DEFAULT 0,
        [source] nvarchar(255) NOT NULL,
        [status] nvarchar(255) NOT NULL DEFAULT N'active',
        [uploaded_at] datetime2 NOT NULL DEFAULT (SYSUTCDATETIME()),
        [url] nvarchar(255) NOT NULL,
        CONSTRAINT [PK_place_media] PRIMARY KEY ([id]),
        CONSTRAINT [FK_place_media_places_place_id] FOREIGN KEY ([place_id]) REFERENCES [places] ([id]) ON DELETE NO ACTION
    );
END;
GO

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260522115500_InitialCreate'
)
BEGIN
    CREATE TABLE [place_tags] (
        [id] uniqueidentifier NOT NULL DEFAULT (NEWID()),
        [place_id] uniqueidentifier NOT NULL,
        [status] nvarchar(255) NOT NULL DEFAULT N'active',
        [tag] nvarchar(255) NOT NULL,
        [tag_group] nvarchar(255) NOT NULL,
        CONSTRAINT [PK_place_tags] PRIMARY KEY ([id]),
        CONSTRAINT [FK_place_tags_places_place_id] FOREIGN KEY ([place_id]) REFERENCES [places] ([id]) ON DELETE NO ACTION
    );
END;
GO

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260522115500_InitialCreate'
)
BEGIN
    CREATE TABLE [direct_messages] (
        [id] uniqueidentifier NOT NULL DEFAULT (NEWID()),
        [content] nvarchar(max) NOT NULL,
        [is_read] bit NOT NULL DEFAULT CAST(0 AS bit),
        [receiver_id] uniqueidentifier NOT NULL,
        [sender_id] uniqueidentifier NOT NULL,
        [sent_at] datetime2 NOT NULL DEFAULT (SYSUTCDATETIME()),
        [status] nvarchar(255) NOT NULL DEFAULT N'active',
        CONSTRAINT [PK_direct_messages] PRIMARY KEY ([id]),
        CONSTRAINT [FK_direct_messages_users_receiver_id] FOREIGN KEY ([receiver_id]) REFERENCES [users] ([id]) ON DELETE NO ACTION,
        CONSTRAINT [FK_direct_messages_users_sender_id] FOREIGN KEY ([sender_id]) REFERENCES [users] ([id]) ON DELETE NO ACTION
    );
END;
GO

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260522115500_InitialCreate'
)
BEGIN
    CREATE TABLE [notifications] (
        [id] uniqueidentifier NOT NULL DEFAULT (NEWID()),
        [user_id] uniqueidentifier NOT NULL,
        [type] nvarchar(255) NOT NULL,
        [title] nvarchar(255) NOT NULL,
        [content] nvarchar(max) NOT NULL,
        [is_read] bit NOT NULL DEFAULT CAST(0 AS bit),
        [priority] nvarchar(30) NOT NULL,
        [created_at] datetime2 NOT NULL DEFAULT (SYSUTCDATETIME()),
        [reference_id] uniqueidentifier NULL,
        [reference_type] nvarchar(255) NULL,
        [status] nvarchar(255) NOT NULL DEFAULT N'active',
        CONSTRAINT [PK_notifications] PRIMARY KEY ([id]),
        CONSTRAINT [FK_notifications_users_user_id] FOREIGN KEY ([user_id]) REFERENCES [users] ([id]) ON DELETE NO ACTION
    );
END;
GO

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260522115500_InitialCreate'
)
BEGIN
    CREATE TABLE [preferences] (
        [id] uniqueidentifier NOT NULL DEFAULT (NEWID()),
        [created_at] datetime2 NOT NULL DEFAULT (SYSUTCDATETIME()),
        [status] nvarchar(255) NOT NULL DEFAULT N'active',
        [type] nvarchar(255) NOT NULL,
        [user_id] uniqueidentifier NOT NULL,
        [value] nvarchar(255) NOT NULL,
        CONSTRAINT [PK_preferences] PRIMARY KEY ([id]),
        CONSTRAINT [FK_preferences_users_user_id] FOREIGN KEY ([user_id]) REFERENCES [users] ([id]) ON DELETE NO ACTION
    );
END;
GO

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260522115500_InitialCreate'
)
BEGIN
    CREATE TABLE [price_reports] (
        [id] uniqueidentifier NOT NULL DEFAULT (NEWID()),
        [user_id] uniqueidentifier NOT NULL,
        [place_id] uniqueidentifier NOT NULL,
        [item_name] nvarchar(255) NOT NULL,
        [price_reported] decimal(18,2) NOT NULL,
        [market_price_min] decimal(18,2) NOT NULL,
        [market_price_max] decimal(18,2) NOT NULL,
        [currency] nvarchar(255) NOT NULL DEFAULT N'VND',
        [latitude] decimal(9,6) NOT NULL,
        [longitude] decimal(9,6) NOT NULL,
        [status] nvarchar(255) NOT NULL DEFAULT N'pending',
        [confirmed_at] datetime2 NULL,
        [created_at] datetime2 NOT NULL DEFAULT (SYSUTCDATETIME()),
        [ai_confidence] float NULL,
        [is_confirmed] bit NOT NULL DEFAULT CAST(0 AS bit),
        CONSTRAINT [PK_price_reports] PRIMARY KEY ([id]),
        CONSTRAINT [FK_price_reports_places_place_id] FOREIGN KEY ([place_id]) REFERENCES [places] ([id]) ON DELETE NO ACTION,
        CONSTRAINT [FK_price_reports_users_user_id] FOREIGN KEY ([user_id]) REFERENCES [users] ([id]) ON DELETE NO ACTION
    );
END;
GO

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260522115500_InitialCreate'
)
BEGIN
    CREATE TABLE [reviews] (
        [id] uniqueidentifier NOT NULL DEFAULT (NEWID()),
        [user_id] uniqueidentifier NOT NULL,
        [place_id] uniqueidentifier NOT NULL,
        [rating] int NOT NULL,
        [content] nvarchar(max) NULL,
        [image_url] nvarchar(255) NULL,
        [is_verified] bit NOT NULL DEFAULT CAST(0 AS bit),
        [gps_proof] nvarchar(255) NULL,
        [exif_verified] bit NOT NULL DEFAULT CAST(0 AS bit),
        [deleted_at] datetime2 NULL,
        [gps_proof_lat] float NULL,
        [gps_proof_lng] float NULL,
        [status] nvarchar(255) NOT NULL DEFAULT N'active',
        [trust_score] float NULL,
        [verified_at] datetime2 NULL,
        [created_at] datetime2 NOT NULL DEFAULT (SYSUTCDATETIME()),
        [updated_at] datetime2 NOT NULL,
        CONSTRAINT [PK_reviews] PRIMARY KEY ([id]),
        CONSTRAINT [FK_reviews_places_place_id] FOREIGN KEY ([place_id]) REFERENCES [places] ([id]) ON DELETE NO ACTION,
        CONSTRAINT [FK_reviews_users_user_id] FOREIGN KEY ([user_id]) REFERENCES [users] ([id]) ON DELETE NO ACTION
    );
END;
GO

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260522115500_InitialCreate'
)
BEGIN
    CREATE TABLE [transactions] (
        [id] uniqueidentifier NOT NULL DEFAULT (NEWID()),
        [amount] decimal(18,2) NOT NULL,
        [created_at] datetime2 NOT NULL DEFAULT (SYSUTCDATETIME()),
        [currency] nvarchar(255) NULL DEFAULT N'USD',
        [paid_at] datetime2 NULL,
        [plan_id] uniqueidentifier NOT NULL,
        [status] nvarchar(255) NOT NULL DEFAULT N'pending',
        [user_id] uniqueidentifier NOT NULL,
        CONSTRAINT [PK_transactions] PRIMARY KEY ([id]),
        CONSTRAINT [FK_transactions_subscription_plans_plan_id] FOREIGN KEY ([plan_id]) REFERENCES [subscription_plans] ([id]) ON DELETE NO ACTION,
        CONSTRAINT [FK_transactions_users_user_id] FOREIGN KEY ([user_id]) REFERENCES [users] ([id]) ON DELETE NO ACTION
    );
END;
GO

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260522115500_InitialCreate'
)
BEGIN
    CREATE TABLE [travel_profiles] (
        [id] uniqueidentifier NOT NULL DEFAULT (NEWID()),
        [created_at] datetime2 NOT NULL DEFAULT (SYSUTCDATETIME()),
        [description] nvarchar(max) NULL,
        [status] nvarchar(255) NOT NULL DEFAULT N'active',
        [travel_style] nvarchar(255) NULL,
        [updated_at] datetime2 NULL,
        [user_id] uniqueidentifier NOT NULL,
        CONSTRAINT [PK_travel_profiles] PRIMARY KEY ([id]),
        CONSTRAINT [FK_travel_profiles_users_user_id] FOREIGN KEY ([user_id]) REFERENCES [users] ([id]) ON DELETE NO ACTION
    );
END;
GO

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260522115500_InitialCreate'
)
BEGIN
    CREATE TABLE [traveler_connections] (
        [id] uniqueidentifier NOT NULL DEFAULT (NEWID()),
        [sender_id] uniqueidentifier NOT NULL,
        [receiver_id] uniqueidentifier NOT NULL,
        [status] nvarchar(255) NOT NULL DEFAULT N'pending',
        [created_at] datetime2 NOT NULL DEFAULT (SYSUTCDATETIME()),
        [updated_at] datetime2 NOT NULL,
        CONSTRAINT [PK_traveler_connections] PRIMARY KEY ([id]),
        CONSTRAINT [FK_traveler_connections_users_receiver_id] FOREIGN KEY ([receiver_id]) REFERENCES [users] ([id]) ON DELETE NO ACTION,
        CONSTRAINT [FK_traveler_connections_users_sender_id] FOREIGN KEY ([sender_id]) REFERENCES [users] ([id]) ON DELETE NO ACTION
    );
END;
GO

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260522115500_InitialCreate'
)
BEGIN
    CREATE TABLE [trip_requests] (
        [id] uniqueidentifier NOT NULL DEFAULT (NEWID()),
        [budget] decimal(18,2) NULL,
        [created_at] datetime2 NOT NULL DEFAULT (SYSUTCDATETIME()),
        [currency] nvarchar(255) NULL DEFAULT N'USD',
        [destination] nvarchar(255) NOT NULL,
        [extra_note] nvarchar(max) NULL,
        [interests] nvarchar(255) NULL,
        [num_days] int NOT NULL,
        [status] nvarchar(255) NOT NULL DEFAULT N'pending',
        [travel_style] nvarchar(255) NULL,
        [user_id] uniqueidentifier NOT NULL,
        CONSTRAINT [PK_trip_requests] PRIMARY KEY ([id]),
        CONSTRAINT [FK_trip_requests_users_user_id] FOREIGN KEY ([user_id]) REFERENCES [users] ([id]) ON DELETE NO ACTION
    );
END;
GO

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260522115500_InitialCreate'
)
BEGIN
    CREATE TABLE [itineraries] (
        [id] uniqueidentifier NOT NULL DEFAULT (NEWID()),
        [user_id] uniqueidentifier NOT NULL,
        [name] nvarchar(255) NOT NULL,
        [destination] nvarchar(255) NOT NULL,
        [country_code] varchar(3) NOT NULL,
        [start_date] date NOT NULL,
        [end_date] date NULL,
        [budget_total] decimal(18,2) NULL,
        [people_count] int NULL,
        [status] nvarchar(30) NOT NULL,
        [budget_currency] varchar(3) NULL DEFAULT 'USD',
        [is_published] bit NOT NULL DEFAULT CAST(0 AS bit),
        [num_days] int NULL,
        [source] nvarchar(255) NOT NULL DEFAULT N'manual',
        [trip_request_id] uniqueidentifier NULL,
        [created_at] datetime2 NOT NULL DEFAULT (SYSUTCDATETIME()),
        [updated_at] datetime2 NOT NULL,
        CONSTRAINT [PK_itineraries] PRIMARY KEY ([id]),
        CONSTRAINT [FK_itineraries_trip_requests_trip_request_id] FOREIGN KEY ([trip_request_id]) REFERENCES [trip_requests] ([id]) ON DELETE NO ACTION,
        CONSTRAINT [FK_itineraries_users_user_id] FOREIGN KEY ([user_id]) REFERENCES [users] ([id]) ON DELETE NO ACTION
    );
END;
GO

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260522115500_InitialCreate'
)
BEGIN
    CREATE TABLE [place_suggestions] (
        [id] uniqueidentifier NOT NULL DEFAULT (NEWID()),
        [ai_score] float NULL,
        [category] nvarchar(255) NULL,
        [place_id] uniqueidentifier NOT NULL,
        [reason] nvarchar(max) NULL,
        [sort_order] int NULL,
        [status] nvarchar(255) NOT NULL DEFAULT N'active',
        [trip_request_id] uniqueidentifier NOT NULL,
        CONSTRAINT [PK_place_suggestions] PRIMARY KEY ([id]),
        CONSTRAINT [FK_place_suggestions_places_place_id] FOREIGN KEY ([place_id]) REFERENCES [places] ([id]) ON DELETE NO ACTION,
        CONSTRAINT [FK_place_suggestions_trip_requests_trip_request_id] FOREIGN KEY ([trip_request_id]) REFERENCES [trip_requests] ([id]) ON DELETE NO ACTION
    );
END;
GO

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260522115500_InitialCreate'
)
BEGIN
    CREATE TABLE [ai_generation_results] (
        [id] uniqueidentifier NOT NULL DEFAULT (NEWID()),
        [completion_tokens] int NULL,
        [generated_at] datetime2 NOT NULL DEFAULT (SYSUTCDATETIME()),
        [itinerary_id] uniqueidentifier NULL,
        [model_used] nvarchar(255) NULL,
        [prompt_tokens] int NULL,
        [status] nvarchar(255) NOT NULL DEFAULT N'active',
        [trip_request_id] uniqueidentifier NOT NULL,
        CONSTRAINT [PK_ai_generation_results] PRIMARY KEY ([id]),
        CONSTRAINT [FK_ai_generation_results_itineraries_itinerary_id] FOREIGN KEY ([itinerary_id]) REFERENCES [itineraries] ([id]) ON DELETE NO ACTION,
        CONSTRAINT [FK_ai_generation_results_trip_requests_trip_request_id] FOREIGN KEY ([trip_request_id]) REFERENCES [trip_requests] ([id]) ON DELETE NO ACTION
    );
END;
GO

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260522115500_InitialCreate'
)
BEGIN
    CREATE TABLE [chat_sessions] (
        [id] uniqueidentifier NOT NULL DEFAULT (NEWID()),
        [ended_at] datetime2 NULL,
        [itinerary_id] uniqueidentifier NULL,
        [started_at] datetime2 NOT NULL DEFAULT (SYSUTCDATETIME()),
        [status] nvarchar(255) NOT NULL DEFAULT N'active',
        [user_id] uniqueidentifier NOT NULL,
        CONSTRAINT [PK_chat_sessions] PRIMARY KEY ([id]),
        CONSTRAINT [FK_chat_sessions_itineraries_itinerary_id] FOREIGN KEY ([itinerary_id]) REFERENCES [itineraries] ([id]) ON DELETE NO ACTION,
        CONSTRAINT [FK_chat_sessions_users_user_id] FOREIGN KEY ([user_id]) REFERENCES [users] ([id]) ON DELETE NO ACTION
    );
END;
GO

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260522115500_InitialCreate'
)
BEGIN
    CREATE TABLE [daily_schedules] (
        [id] uniqueidentifier NOT NULL DEFAULT (NEWID()),
        [itinerary_id] uniqueidentifier NOT NULL,
        [schedule_date] date NOT NULL,
        [route_optimized] bit NOT NULL DEFAULT CAST(0 AS bit),
        [day_number] int NOT NULL DEFAULT 1,
        [status] nvarchar(255) NOT NULL DEFAULT N'active',
        [created_at] datetime2 NOT NULL DEFAULT (SYSUTCDATETIME()),
        [updated_at] datetime2 NOT NULL,
        CONSTRAINT [PK_daily_schedules] PRIMARY KEY ([id]),
        CONSTRAINT [FK_daily_schedules_itineraries_itinerary_id] FOREIGN KEY ([itinerary_id]) REFERENCES [itineraries] ([id]) ON DELETE NO ACTION
    );
END;
GO

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260522115500_InitialCreate'
)
BEGIN
    CREATE TABLE [itinerary_costs] (
        [id] uniqueidentifier NOT NULL DEFAULT (NEWID()),
        [category] nvarchar(255) NOT NULL,
        [currency] varchar(3) NULL,
        [estimated_amount] decimal(18,2) NULL,
        [itinerary_id] uniqueidentifier NOT NULL,
        [note] nvarchar(max) NULL,
        [status] nvarchar(255) NOT NULL DEFAULT N'active',
        CONSTRAINT [PK_itinerary_costs] PRIMARY KEY ([id]),
        CONSTRAINT [FK_itinerary_costs_itineraries_itinerary_id] FOREIGN KEY ([itinerary_id]) REFERENCES [itineraries] ([id]) ON DELETE NO ACTION
    );
END;
GO

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260522115500_InitialCreate'
)
BEGIN
    CREATE TABLE [posts] (
        [id] uniqueidentifier NOT NULL DEFAULT (NEWID()),
        [body] nvarchar(max) NULL,
        [created_at] datetime2 NOT NULL DEFAULT (SYSUTCDATETIME()),
        [itinerary_id] uniqueidentifier NULL,
        [parent_post_id] uniqueidentifier NULL,
        [post_type] nvarchar(255) NOT NULL DEFAULT N'blog',
        [published_at] datetime2 NULL,
        [share_count] int NOT NULL DEFAULT 0,
        [status] nvarchar(255) NOT NULL DEFAULT N'draft',
        [title] nvarchar(255) NOT NULL,
        [updated_at] datetime2 NULL,
        [user_id] uniqueidentifier NOT NULL,
        [view_count] int NOT NULL DEFAULT 0,
        CONSTRAINT [PK_posts] PRIMARY KEY ([id]),
        CONSTRAINT [FK_posts_itineraries_itinerary_id] FOREIGN KEY ([itinerary_id]) REFERENCES [itineraries] ([id]) ON DELETE NO ACTION,
        CONSTRAINT [FK_posts_posts_parent_post_id] FOREIGN KEY ([parent_post_id]) REFERENCES [posts] ([id]) ON DELETE NO ACTION,
        CONSTRAINT [FK_posts_users_user_id] FOREIGN KEY ([user_id]) REFERENCES [users] ([id]) ON DELETE NO ACTION
    );
END;
GO

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260522115500_InitialCreate'
)
BEGIN
    CREATE TABLE [trip_stats] (
        [id] uniqueidentifier NOT NULL DEFAULT (NEWID()),
        [activities_done] int NOT NULL DEFAULT 0,
        [activities_total] int NOT NULL DEFAULT 0,
        [itinerary_id] uniqueidentifier NOT NULL,
        [new_friends_count] int NOT NULL DEFAULT 0,
        [places_visited] int NOT NULL DEFAULT 0,
        [status] nvarchar(255) NOT NULL DEFAULT N'active',
        [total_distance_km] float NOT NULL DEFAULT 0.0E0,
        [total_photos] int NOT NULL DEFAULT 0,
        [updated_at] datetime2 NULL,
        CONSTRAINT [PK_trip_stats] PRIMARY KEY ([id]),
        CONSTRAINT [FK_trip_stats_itineraries_itinerary_id] FOREIGN KEY ([itinerary_id]) REFERENCES [itineraries] ([id]) ON DELETE NO ACTION
    );
END;
GO

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260522115500_InitialCreate'
)
BEGIN
    CREATE TABLE [messages] (
        [id] uniqueidentifier NOT NULL DEFAULT (NEWID()),
        [chat_session_id] uniqueidentifier NOT NULL,
        [content] nvarchar(max) NOT NULL,
        [role] nvarchar(255) NOT NULL,
        [sent_at] datetime2 NOT NULL DEFAULT (SYSUTCDATETIME()),
        [status] nvarchar(255) NOT NULL DEFAULT N'active',
        CONSTRAINT [PK_messages] PRIMARY KEY ([id]),
        CONSTRAINT [FK_messages_chat_sessions_chat_session_id] FOREIGN KEY ([chat_session_id]) REFERENCES [chat_sessions] ([id]) ON DELETE NO ACTION
    );
END;
GO

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260522115500_InitialCreate'
)
BEGIN
    CREATE TABLE [itinerary_items] (
        [id] uniqueidentifier NOT NULL DEFAULT (NEWID()),
        [daily_schedule_id] uniqueidentifier NOT NULL,
        [place_id] uniqueidentifier NOT NULL,
        [sort_order] int NOT NULL,
        [estimated_arrival_time] datetime2 NULL,
        [visited_at] datetime2 NULL,
        [activity_status] nvarchar(30) NOT NULL DEFAULT N'upcoming',
        [completed_at] datetime2 NULL,
        [duration_minutes] int NULL,
        [status] nvarchar(255) NOT NULL DEFAULT N'active',
        [transport_mode] nvarchar(255) NULL,
        [visit_time] time NULL,
        [created_at] datetime2 NOT NULL DEFAULT (SYSUTCDATETIME()),
        [updated_at] datetime2 NOT NULL,
        CONSTRAINT [PK_itinerary_items] PRIMARY KEY ([id]),
        CONSTRAINT [FK_itinerary_items_daily_schedules_daily_schedule_id] FOREIGN KEY ([daily_schedule_id]) REFERENCES [daily_schedules] ([id]) ON DELETE NO ACTION,
        CONSTRAINT [FK_itinerary_items_places_place_id] FOREIGN KEY ([place_id]) REFERENCES [places] ([id]) ON DELETE NO ACTION
    );
END;
GO

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260522115500_InitialCreate'
)
BEGIN
    CREATE TABLE [post_comments] (
        [id] uniqueidentifier NOT NULL DEFAULT (NEWID()),
        [content] nvarchar(max) NOT NULL,
        [created_at] datetime2 NOT NULL DEFAULT (SYSUTCDATETIME()),
        [parent_id] uniqueidentifier NULL,
        [post_id] uniqueidentifier NOT NULL,
        [status] nvarchar(255) NOT NULL DEFAULT N'active',
        [updated_at] datetime2 NULL,
        [user_id] uniqueidentifier NOT NULL,
        CONSTRAINT [PK_post_comments] PRIMARY KEY ([id]),
        CONSTRAINT [FK_post_comments_post_comments_parent_id] FOREIGN KEY ([parent_id]) REFERENCES [post_comments] ([id]) ON DELETE NO ACTION,
        CONSTRAINT [FK_post_comments_posts_post_id] FOREIGN KEY ([post_id]) REFERENCES [posts] ([id]) ON DELETE NO ACTION,
        CONSTRAINT [FK_post_comments_users_user_id] FOREIGN KEY ([user_id]) REFERENCES [users] ([id]) ON DELETE NO ACTION
    );
END;
GO

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260522115500_InitialCreate'
)
BEGIN
    CREATE TABLE [post_likes] (
        [id] uniqueidentifier NOT NULL DEFAULT (NEWID()),
        [created_at] datetime2 NOT NULL DEFAULT (SYSUTCDATETIME()),
        [post_id] uniqueidentifier NOT NULL,
        [status] nvarchar(255) NOT NULL DEFAULT N'active',
        [user_id] uniqueidentifier NOT NULL,
        CONSTRAINT [PK_post_likes] PRIMARY KEY ([id]),
        CONSTRAINT [FK_post_likes_posts_post_id] FOREIGN KEY ([post_id]) REFERENCES [posts] ([id]) ON DELETE NO ACTION,
        CONSTRAINT [FK_post_likes_users_user_id] FOREIGN KEY ([user_id]) REFERENCES [users] ([id]) ON DELETE NO ACTION
    );
END;
GO

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260522115500_InitialCreate'
)
BEGIN
    CREATE TABLE [post_media] (
        [id] uniqueidentifier NOT NULL DEFAULT (NEWID()),
        [created_at] datetime2 NOT NULL DEFAULT (SYSUTCDATETIME()),
        [media_type] nvarchar(255) NOT NULL,
        [post_id] uniqueidentifier NOT NULL,
        [sort_order] int NOT NULL DEFAULT 0,
        [status] nvarchar(255) NOT NULL DEFAULT N'active',
        [url] nvarchar(255) NOT NULL,
        CONSTRAINT [PK_post_media] PRIMARY KEY ([id]),
        CONSTRAINT [FK_post_media_posts_post_id] FOREIGN KEY ([post_id]) REFERENCES [posts] ([id]) ON DELETE NO ACTION
    );
END;
GO

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260522115500_InitialCreate'
)
BEGIN
    CREATE TABLE [post_tags] (
        [id] uniqueidentifier NOT NULL DEFAULT (NEWID()),
        [post_id] uniqueidentifier NOT NULL,
        [status] nvarchar(255) NOT NULL DEFAULT N'active',
        [tag] nvarchar(255) NOT NULL,
        CONSTRAINT [PK_post_tags] PRIMARY KEY ([id]),
        CONSTRAINT [FK_post_tags_posts_post_id] FOREIGN KEY ([post_id]) REFERENCES [posts] ([id]) ON DELETE NO ACTION
    );
END;
GO

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260522115500_InitialCreate'
)
BEGIN
    CREATE TABLE [trip_photos] (
        [id] uniqueidentifier NOT NULL DEFAULT (NEWID()),
        [caption] nvarchar(max) NULL,
        [created_at] datetime2 NOT NULL DEFAULT (SYSUTCDATETIME()),
        [itinerary_id] uniqueidentifier NOT NULL,
        [itinerary_item_id] uniqueidentifier NULL,
        [latitude] float NULL,
        [longitude] float NULL,
        [status] nvarchar(255) NOT NULL DEFAULT N'active',
        [taken_at] datetime2 NULL,
        [thumbnail_url] nvarchar(255) NULL,
        [url] nvarchar(255) NOT NULL,
        [user_id] uniqueidentifier NOT NULL,
        CONSTRAINT [PK_trip_photos] PRIMARY KEY ([id]),
        CONSTRAINT [FK_trip_photos_itineraries_itinerary_id] FOREIGN KEY ([itinerary_id]) REFERENCES [itineraries] ([id]) ON DELETE NO ACTION,
        CONSTRAINT [FK_trip_photos_itinerary_items_itinerary_item_id] FOREIGN KEY ([itinerary_item_id]) REFERENCES [itinerary_items] ([id]) ON DELETE NO ACTION,
        CONSTRAINT [FK_trip_photos_users_user_id] FOREIGN KEY ([user_id]) REFERENCES [users] ([id]) ON DELETE NO ACTION
    );
END;
GO

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260522115500_InitialCreate'
)
BEGIN
    IF EXISTS (SELECT * FROM [sys].[identity_columns] WHERE [name] IN (N'id', N'address', N'category', N'city', N'country_code', N'created_at', N'description', N'google_place_id', N'latitude', N'longitude', N'name', N'open_hours', N'price_level', N'tags', N'trust_score', N'updated_at') AND [object_id] = OBJECT_ID(N'[places]'))
        SET IDENTITY_INSERT [places] ON;
    EXEC(N'INSERT INTO [places] ([id], [address], [category], [city], [country_code], [created_at], [description], [google_place_id], [latitude], [longitude], [name], [open_hours], [price_level], [tags], [trust_score], [updated_at])
    VALUES (''f2000000-0000-0000-0000-000000000001'', NULL, N''Cultural'', N''Hanoi'', ''VN'', ''2026-05-21T00:00:00.0000000Z'', N''Historic district with local food and culture.'', NULL, 21.033333, 105.85, N''Hanoi Old Quarter'', N''06:00-23:00'', N''medium'', N''food,walking,history'', 4.6, ''2026-05-21T00:00:00.0000000Z''),
    (''f2000000-0000-0000-0000-000000000002'', NULL, N''Historical'', N''Hanoi'', ''VN'', ''2026-05-21T00:00:00.0000000Z'', N''Vietnam''''s first national university and heritage site.'', NULL, 21.028511, 105.835686, N''Temple of Literature'', N''08:00-17:00'', N''low'', N''history,temple,education'', 4.7, ''2026-05-21T00:00:00.0000000Z''),
    (''f2000000-0000-0000-0000-000000000003'', NULL, N''Historical'', N''Ho Chi Minh City'', ''VN'', ''2026-05-21T00:00:00.0000000Z'', N''Iconic cathedral in central Ho Chi Minh City.'', NULL, 10.779785, 106.699018, N''Notre-Dame Cathedral Basilica of Saigon'', N''08:00-18:00'', N''low'', N''cathedral,landmark,architecture'', 4.5, ''2026-05-21T00:00:00.0000000Z''),
    (''f2000000-0000-0000-0000-000000000004'', NULL, N''Market'', N''Ho Chi Minh City'', ''VN'', ''2026-05-21T00:00:00.0000000Z'', N''Major marketplace with local products and street food.'', NULL, 10.772444, 106.698056, N''Ben Thanh Market'', N''07:00-19:00'', N''medium'', N''shopping,food,market'', 4.1, ''2026-05-21T00:00:00.0000000Z'')');
    IF EXISTS (SELECT * FROM [sys].[identity_columns] WHERE [name] IN (N'id', N'address', N'category', N'city', N'country_code', N'created_at', N'description', N'google_place_id', N'latitude', N'longitude', N'name', N'open_hours', N'price_level', N'tags', N'trust_score', N'updated_at') AND [object_id] = OBJECT_ID(N'[places]'))
        SET IDENTITY_INSERT [places] OFF;
END;
GO

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260522115500_InitialCreate'
)
BEGIN
    IF EXISTS (SELECT * FROM [sys].[identity_columns] WHERE [name] IN (N'id', N'auth_provider', N'avatar_url', N'budget_preference', N'created_at', N'current_lat', N'current_lng', N'deleted_at', N'diet_preference', N'display_name', N'email', N'is_email_verified', N'language', N'location_updated_at', N'nationality', N'password_hash', N'status_text', N'updated_at') AND [object_id] = OBJECT_ID(N'[users]'))
        SET IDENTITY_INSERT [users] ON;
    EXEC(N'INSERT INTO [users] ([id], [auth_provider], [avatar_url], [budget_preference], [created_at], [current_lat], [current_lng], [deleted_at], [diet_preference], [display_name], [email], [is_email_verified], [language], [location_updated_at], [nationality], [password_hash], [status_text], [updated_at])
    VALUES (''f1000000-0000-0000-0000-000000000001'', N''seed'', NULL, N''medium'', ''2026-05-21T00:00:00.0000000Z'', NULL, NULL, NULL, N''none'', NULL, N''guest@travel-engine.local'', CAST(1 AS bit), N''en'', NULL, N''Unknown'', N''SEED_ONLY'', NULL, ''2026-05-21T00:00:00.0000000Z'')');
    IF EXISTS (SELECT * FROM [sys].[identity_columns] WHERE [name] IN (N'id', N'auth_provider', N'avatar_url', N'budget_preference', N'created_at', N'current_lat', N'current_lng', N'deleted_at', N'diet_preference', N'display_name', N'email', N'is_email_verified', N'language', N'location_updated_at', N'nationality', N'password_hash', N'status_text', N'updated_at') AND [object_id] = OBJECT_ID(N'[users]'))
        SET IDENTITY_INSERT [users] OFF;
END;
GO

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260522115500_InitialCreate'
)
BEGIN
    IF EXISTS (SELECT * FROM [sys].[identity_columns] WHERE [name] IN (N'id', N'audio_url', N'created_at', N'description', N'fun_fact', N'image_url', N'latitude', N'longitude', N'name', N'place_id', N'sort_order', N'updated_at') AND [object_id] = OBJECT_ID(N'[checkpoints]'))
        SET IDENTITY_INSERT [checkpoints] ON;
    EXEC(N'INSERT INTO [checkpoints] ([id], [audio_url], [created_at], [description], [fun_fact], [image_url], [latitude], [longitude], [name], [place_id], [sort_order], [updated_at])
    VALUES (''f3000000-0000-0000-0000-000000000001'', N''https://cdn.example.com/audio/f3000000-0000-0000-0000-000000000001.mp3'', ''2026-05-21T00:00:00.0000000Z'', N''Checkpoint for Dong Xuan Market Gate'', N''Local cultural context available.'', N''https://cdn.example.com/images/f3000000-0000-0000-0000-000000000001.jpg'', 21.037, 105.847, N''Dong Xuan Market Gate'', ''f2000000-0000-0000-0000-000000000001'', 1, ''2026-05-21T00:00:00.0000000Z''),
    (''f3000000-0000-0000-0000-000000000002'', N''https://cdn.example.com/audio/f3000000-0000-0000-0000-000000000002.mp3'', ''2026-05-21T00:00:00.0000000Z'', N''Checkpoint for Ta Hien Street'', N''Local cultural context available.'', N''https://cdn.example.com/images/f3000000-0000-0000-0000-000000000002.jpg'', 21.0352, 105.8522, N''Ta Hien Street'', ''f2000000-0000-0000-0000-000000000001'', 2, ''2026-05-21T00:00:00.0000000Z''),
    (''f3000000-0000-0000-0000-000000000003'', N''https://cdn.example.com/audio/f3000000-0000-0000-0000-000000000003.mp3'', ''2026-05-21T00:00:00.0000000Z'', N''Checkpoint for Main Gate'', N''Local cultural context available.'', N''https://cdn.example.com/images/f3000000-0000-0000-0000-000000000003.jpg'', 21.0287, 105.8353, N''Main Gate'', ''f2000000-0000-0000-0000-000000000002'', 1, ''2026-05-21T00:00:00.0000000Z''),
    (''f3000000-0000-0000-0000-000000000004'', N''https://cdn.example.com/audio/f3000000-0000-0000-0000-000000000004.mp3'', ''2026-05-21T00:00:00.0000000Z'', N''Checkpoint for Doctor Stelae'', N''Local cultural context available.'', N''https://cdn.example.com/images/f3000000-0000-0000-0000-000000000004.jpg'', 21.0284, 105.8359, N''Doctor Stelae'', ''f2000000-0000-0000-0000-000000000002'', 2, ''2026-05-21T00:00:00.0000000Z''),
    (''f3000000-0000-0000-0000-000000000005'', N''https://cdn.example.com/audio/f3000000-0000-0000-0000-000000000005.mp3'', ''2026-05-21T00:00:00.0000000Z'', N''Checkpoint for Front Plaza'', N''Local cultural context available.'', N''https://cdn.example.com/images/f3000000-0000-0000-0000-000000000005.jpg'', 10.7797, 106.6989, N''Front Plaza'', ''f2000000-0000-0000-0000-000000000003'', 1, ''2026-05-21T00:00:00.0000000Z''),
    (''f3000000-0000-0000-0000-000000000006'', N''https://cdn.example.com/audio/f3000000-0000-0000-0000-000000000006.mp3'', ''2026-05-21T00:00:00.0000000Z'', N''Checkpoint for Central Garden'', N''Local cultural context available.'', N''https://cdn.example.com/images/f3000000-0000-0000-0000-000000000006.jpg'', 10.7799, 106.6993, N''Central Garden'', ''f2000000-0000-0000-0000-000000000003'', 2, ''2026-05-21T00:00:00.0000000Z''),
    (''f3000000-0000-0000-0000-000000000007'', N''https://cdn.example.com/audio/f3000000-0000-0000-0000-000000000007.mp3'', ''2026-05-21T00:00:00.0000000Z'', N''Checkpoint for South Gate'', N''Local cultural context available.'', N''https://cdn.example.com/images/f3000000-0000-0000-0000-000000000007.jpg'', 10.7723, 106.6982, N''South Gate'', ''f2000000-0000-0000-0000-000000000004'', 1, ''2026-05-21T00:00:00.0000000Z''),
    (''f3000000-0000-0000-0000-000000000008'', N''https://cdn.example.com/audio/f3000000-0000-0000-0000-000000000008.mp3'', ''2026-05-21T00:00:00.0000000Z'', N''Checkpoint for Food Court'', N''Local cultural context available.'', N''https://cdn.example.com/images/f3000000-0000-0000-0000-000000000008.jpg'', 10.7726, 106.6979, N''Food Court'', ''f2000000-0000-0000-0000-000000000004'', 2, ''2026-05-21T00:00:00.0000000Z'')');
    IF EXISTS (SELECT * FROM [sys].[identity_columns] WHERE [name] IN (N'id', N'audio_url', N'created_at', N'description', N'fun_fact', N'image_url', N'latitude', N'longitude', N'name', N'place_id', N'sort_order', N'updated_at') AND [object_id] = OBJECT_ID(N'[checkpoints]'))
        SET IDENTITY_INSERT [checkpoints] OFF;
END;
GO

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260522115500_InitialCreate'
)
BEGIN
    IF EXISTS (SELECT * FROM [sys].[identity_columns] WHERE [name] IN (N'id', N'ai_confidence', N'confirmed_at', N'created_at', N'currency', N'item_name', N'latitude', N'longitude', N'market_price_max', N'market_price_min', N'place_id', N'price_reported', N'status', N'user_id') AND [object_id] = OBJECT_ID(N'[price_reports]'))
        SET IDENTITY_INSERT [price_reports] ON;
    EXEC(N'INSERT INTO [price_reports] ([id], [ai_confidence], [confirmed_at], [created_at], [currency], [item_name], [latitude], [longitude], [market_price_max], [market_price_min], [place_id], [price_reported], [status], [user_id])
    VALUES (''f4000000-0000-0000-0000-000000000001'', NULL, ''2026-05-21T00:00:00.0000000Z'', ''2026-05-21T00:00:00.0000000Z'', N''VND'', N''Pho bowl'', 10.772444, 106.698056, 80000.0, 45000.0, ''f2000000-0000-0000-0000-000000000004'', 45000.0, N''Confirmed'', ''f1000000-0000-0000-0000-000000000001''),
    (''f4000000-0000-0000-0000-000000000002'', NULL, ''2026-05-21T00:00:00.0000000Z'', ''2026-05-21T00:00:00.0000000Z'', N''VND'', N''Banh mi'', 10.772444, 106.698056, 35000.0, 15000.0, ''f2000000-0000-0000-0000-000000000004'', 15000.0, N''Confirmed'', ''f1000000-0000-0000-0000-000000000001''),
    (''f4000000-0000-0000-0000-000000000003'', NULL, ''2026-05-21T00:00:00.0000000Z'', ''2026-05-21T00:00:00.0000000Z'', N''VND'', N''Bottled water'', 10.772444, 106.698056, 25000.0, 10000.0, ''f2000000-0000-0000-0000-000000000004'', 10000.0, N''Confirmed'', ''f1000000-0000-0000-0000-000000000001''),
    (''f4000000-0000-0000-0000-000000000004'', NULL, ''2026-05-21T00:00:00.0000000Z'', ''2026-05-21T00:00:00.0000000Z'', N''VND'', N''Iced coffee'', 10.772444, 106.698056, 45000.0, 18000.0, ''f2000000-0000-0000-0000-000000000004'', 18000.0, N''Confirmed'', ''f1000000-0000-0000-0000-000000000001''),
    (''f4000000-0000-0000-0000-000000000005'', NULL, ''2026-05-21T00:00:00.0000000Z'', ''2026-05-21T00:00:00.0000000Z'', N''VND'', N''Taxi airport to center'', 10.772444, 106.698056, 300000.0, 150000.0, ''f2000000-0000-0000-0000-000000000004'', 150000.0, N''Confirmed'', ''f1000000-0000-0000-0000-000000000001''),
    (''f4000000-0000-0000-0000-000000000006'', NULL, ''2026-05-21T00:00:00.0000000Z'', ''2026-05-21T00:00:00.0000000Z'', N''VND'', N''Motorbike ride per km'', 10.772444, 106.698056, 18000.0, 8000.0, ''f2000000-0000-0000-0000-000000000004'', 8000.0, N''Confirmed'', ''f1000000-0000-0000-0000-000000000001''),
    (''f4000000-0000-0000-0000-000000000007'', NULL, ''2026-05-21T00:00:00.0000000Z'', ''2026-05-21T00:00:00.0000000Z'', N''VND'', N''Coconut'', 10.772444, 106.698056, 40000.0, 15000.0, ''f2000000-0000-0000-0000-000000000004'', 15000.0, N''Confirmed'', ''f1000000-0000-0000-0000-000000000001''),
    (''f4000000-0000-0000-0000-000000000008'', NULL, ''2026-05-21T00:00:00.0000000Z'', ''2026-05-21T00:00:00.0000000Z'', N''VND'', N''Fruit smoothie'', 10.772444, 106.698056, 60000.0, 25000.0, ''f2000000-0000-0000-0000-000000000004'', 25000.0, N''Confirmed'', ''f1000000-0000-0000-0000-000000000001''),
    (''f4000000-0000-0000-0000-000000000009'', NULL, ''2026-05-21T00:00:00.0000000Z'', ''2026-05-21T00:00:00.0000000Z'', N''VND'', N''Street BBQ skewer'', 10.772444, 106.698056, 30000.0, 10000.0, ''f2000000-0000-0000-0000-000000000004'', 10000.0, N''Confirmed'', ''f1000000-0000-0000-0000-000000000001''),
    (''f4000000-0000-0000-0000-000000000010'', NULL, ''2026-05-21T00:00:00.0000000Z'', ''2026-05-21T00:00:00.0000000Z'', N''VND'', N''Museum ticket'', 10.772444, 106.698056, 80000.0, 30000.0, ''f2000000-0000-0000-0000-000000000004'', 30000.0, N''Confirmed'', ''f1000000-0000-0000-0000-000000000001''),
    (''f4000000-0000-0000-0000-000000000011'', NULL, ''2026-05-21T00:00:00.0000000Z'', ''2026-05-21T00:00:00.0000000Z'', N''VND'', N''Temple donation'', 10.772444, 106.698056, 50000.0, 10000.0, ''f2000000-0000-0000-0000-000000000004'', 10000.0, N''Confirmed'', ''f1000000-0000-0000-0000-000000000001''),
    (''f4000000-0000-0000-0000-000000000012'', NULL, ''2026-05-21T00:00:00.0000000Z'', ''2026-05-21T00:00:00.0000000Z'', N''VND'', N''Laundry per kg'', 10.772444, 106.698056, 70000.0, 30000.0, ''f2000000-0000-0000-0000-000000000004'', 30000.0, N''Confirmed'', ''f1000000-0000-0000-0000-000000000001''),
    (''f4000000-0000-0000-0000-000000000013'', NULL, ''2026-05-21T00:00:00.0000000Z'', ''2026-05-21T00:00:00.0000000Z'', N''VND'', N''Local SIM 7-day'', 10.772444, 106.698056, 250000.0, 100000.0, ''f2000000-0000-0000-0000-000000000004'', 100000.0, N''Confirmed'', ''f1000000-0000-0000-0000-000000000001''),
    (''f4000000-0000-0000-0000-000000000014'', NULL, ''2026-05-21T00:00:00.0000000Z'', ''2026-05-21T00:00:00.0000000Z'', N''VND'', N''Rain poncho'', 10.772444, 106.698056, 30000.0, 10000.0, ''f2000000-0000-0000-0000-000000000004'', 10000.0, N''Confirmed'', ''f1000000-0000-0000-0000-000000000001''),
    (''f4000000-0000-0000-0000-000000000015'', NULL, ''2026-05-21T00:00:00.0000000Z'', ''2026-05-21T00:00:00.0000000Z'', N''VND'', N''Souvenir magnet'', 10.772444, 106.698056, 60000.0, 20000.0, ''f2000000-0000-0000-0000-000000000004'', 20000.0, N''Confirmed'', ''f1000000-0000-0000-0000-000000000001''),
    (''f4000000-0000-0000-0000-000000000016'', NULL, ''2026-05-21T00:00:00.0000000Z'', ''2026-05-21T00:00:00.0000000Z'', N''VND'', N''Taxi base fare'', 10.772444, 106.698056, 25000.0, 12000.0, ''f2000000-0000-0000-0000-000000000004'', 12000.0, N''Confirmed'', ''f1000000-0000-0000-0000-000000000001''),
    (''f4000000-0000-0000-0000-000000000017'', NULL, ''2026-05-21T00:00:00.0000000Z'', ''2026-05-21T00:00:00.0000000Z'', N''VND'', N''Grilled seafood plate'', 10.772444, 106.698056, 280000.0, 120000.0, ''f2000000-0000-0000-0000-000000000004'', 120000.0, N''Confirmed'', ''f1000000-0000-0000-0000-000000000001''),
    (''f4000000-0000-0000-0000-000000000018'', NULL, ''2026-05-21T00:00:00.0000000Z'', ''2026-05-21T00:00:00.0000000Z'', N''VND'', N''Fresh juice'', 10.772444, 106.698056, 50000.0, 20000.0, ''f2000000-0000-0000-0000-000000000004'', 20000.0, N''Confirmed'', ''f1000000-0000-0000-0000-000000000001''),
    (''f4000000-0000-0000-0000-000000000019'', NULL, ''2026-05-21T00:00:00.0000000Z'', ''2026-05-21T00:00:00.0000000Z'', N''VND'', N''Train station snack'', 10.772444, 106.698056, 40000.0, 15000.0, ''f2000000-0000-0000-0000-000000000004'', 15000.0, N''Confirmed'', ''f1000000-0000-0000-0000-000000000001''),
    (''f4000000-0000-0000-0000-000000000020'', NULL, ''2026-05-21T00:00:00.0000000Z'', ''2026-05-21T00:00:00.0000000Z'', N''VND'', N''Public restroom fee'', 10.772444, 106.698056, 10000.0, 2000.0, ''f2000000-0000-0000-0000-000000000004'', 2000.0, N''Confirmed'', ''f1000000-0000-0000-0000-000000000001'')');
    IF EXISTS (SELECT * FROM [sys].[identity_columns] WHERE [name] IN (N'id', N'ai_confidence', N'confirmed_at', N'created_at', N'currency', N'item_name', N'latitude', N'longitude', N'market_price_max', N'market_price_min', N'place_id', N'price_reported', N'status', N'user_id') AND [object_id] = OBJECT_ID(N'[price_reports]'))
        SET IDENTITY_INSERT [price_reports] OFF;
END;
GO

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260522115500_InitialCreate'
)
BEGIN
    CREATE INDEX [IX_ai_generation_results_itinerary_id] ON [ai_generation_results] ([itinerary_id]);
END;
GO

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260522115500_InitialCreate'
)
BEGIN
    CREATE INDEX [IX_ai_generation_results_trip_request_id] ON [ai_generation_results] ([trip_request_id]);
END;
GO

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260522115500_InitialCreate'
)
BEGIN
    CREATE INDEX [IX_chat_sessions_itinerary_id] ON [chat_sessions] ([itinerary_id]);
END;
GO

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260522115500_InitialCreate'
)
BEGIN
    CREATE INDEX [IX_chat_sessions_user_id] ON [chat_sessions] ([user_id]);
END;
GO

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260522115500_InitialCreate'
)
BEGIN
    CREATE INDEX [IX_checkpoints_place_id] ON [checkpoints] ([place_id]);
END;
GO

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260522115500_InitialCreate'
)
BEGIN
    CREATE INDEX [IX_daily_schedules_itinerary_id] ON [daily_schedules] ([itinerary_id]);
END;
GO

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260522115500_InitialCreate'
)
BEGIN
    CREATE INDEX [IX_direct_messages_receiver_id] ON [direct_messages] ([receiver_id]);
END;
GO

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260522115500_InitialCreate'
)
BEGIN
    CREATE INDEX [IX_direct_messages_sender_id] ON [direct_messages] ([sender_id]);
END;
GO

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260522115500_InitialCreate'
)
BEGIN
    CREATE UNIQUE INDEX [IX_financial_tools_from_currency_to_currency] ON [financial_tools] ([from_currency], [to_currency]);
END;
GO

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260522115500_InitialCreate'
)
BEGIN
    CREATE INDEX [IX_itineraries_trip_request_id] ON [itineraries] ([trip_request_id]);
END;
GO

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260522115500_InitialCreate'
)
BEGIN
    CREATE INDEX [IX_itineraries_user_id] ON [itineraries] ([user_id]);
END;
GO

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260522115500_InitialCreate'
)
BEGIN
    CREATE UNIQUE INDEX [IX_itinerary_costs_itinerary_id_category] ON [itinerary_costs] ([itinerary_id], [category]);
END;
GO

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260522115500_InitialCreate'
)
BEGIN
    CREATE INDEX [IX_itinerary_items_daily_schedule_id] ON [itinerary_items] ([daily_schedule_id]);
END;
GO

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260522115500_InitialCreate'
)
BEGIN
    CREATE INDEX [IX_itinerary_items_place_id] ON [itinerary_items] ([place_id]);
END;
GO

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260522115500_InitialCreate'
)
BEGIN
    CREATE INDEX [IX_messages_chat_session_id] ON [messages] ([chat_session_id]);
END;
GO

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260522115500_InitialCreate'
)
BEGIN
    CREATE INDEX [IX_notifications_user_id] ON [notifications] ([user_id]);
END;
GO

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260522115500_InitialCreate'
)
BEGIN
    CREATE INDEX [IX_place_media_place_id] ON [place_media] ([place_id]);
END;
GO

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260522115500_InitialCreate'
)
BEGIN
    CREATE INDEX [IX_place_suggestions_place_id] ON [place_suggestions] ([place_id]);
END;
GO

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260522115500_InitialCreate'
)
BEGIN
    CREATE INDEX [IX_place_suggestions_trip_request_id] ON [place_suggestions] ([trip_request_id]);
END;
GO

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260522115500_InitialCreate'
)
BEGIN
    CREATE UNIQUE INDEX [IX_place_tags_place_id_tag] ON [place_tags] ([place_id], [tag]);
END;
GO

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260522115500_InitialCreate'
)
BEGIN
    CREATE INDEX [IX_post_comments_parent_id] ON [post_comments] ([parent_id]);
END;
GO

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260522115500_InitialCreate'
)
BEGIN
    CREATE INDEX [IX_post_comments_post_id] ON [post_comments] ([post_id]);
END;
GO

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260522115500_InitialCreate'
)
BEGIN
    CREATE INDEX [IX_post_comments_user_id] ON [post_comments] ([user_id]);
END;
GO

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260522115500_InitialCreate'
)
BEGIN
    CREATE UNIQUE INDEX [IX_post_likes_post_id_user_id] ON [post_likes] ([post_id], [user_id]);
END;
GO

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260522115500_InitialCreate'
)
BEGIN
    CREATE INDEX [IX_post_likes_user_id] ON [post_likes] ([user_id]);
END;
GO

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260522115500_InitialCreate'
)
BEGIN
    CREATE INDEX [IX_post_media_post_id] ON [post_media] ([post_id]);
END;
GO

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260522115500_InitialCreate'
)
BEGIN
    CREATE INDEX [IX_post_tags_post_id] ON [post_tags] ([post_id]);
END;
GO

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260522115500_InitialCreate'
)
BEGIN
    CREATE INDEX [IX_posts_itinerary_id] ON [posts] ([itinerary_id]);
END;
GO

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260522115500_InitialCreate'
)
BEGIN
    CREATE INDEX [IX_posts_parent_post_id] ON [posts] ([parent_post_id]);
END;
GO

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260522115500_InitialCreate'
)
BEGIN
    CREATE INDEX [IX_posts_user_id] ON [posts] ([user_id]);
END;
GO

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260522115500_InitialCreate'
)
BEGIN
    CREATE INDEX [IX_preferences_user_id] ON [preferences] ([user_id]);
END;
GO

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260522115500_InitialCreate'
)
BEGIN
    CREATE INDEX [IX_price_reports_place_id] ON [price_reports] ([place_id]);
END;
GO

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260522115500_InitialCreate'
)
BEGIN
    CREATE INDEX [IX_price_reports_user_id] ON [price_reports] ([user_id]);
END;
GO

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260522115500_InitialCreate'
)
BEGIN
    CREATE UNIQUE INDEX [IX_reviews_place_id_user_id] ON [reviews] ([place_id], [user_id]);
END;
GO

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260522115500_InitialCreate'
)
BEGIN
    CREATE INDEX [IX_reviews_user_id] ON [reviews] ([user_id]);
END;
GO

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260522115500_InitialCreate'
)
BEGIN
    CREATE INDEX [IX_transactions_plan_id] ON [transactions] ([plan_id]);
END;
GO

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260522115500_InitialCreate'
)
BEGIN
    CREATE INDEX [IX_transactions_user_id] ON [transactions] ([user_id]);
END;
GO

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260522115500_InitialCreate'
)
BEGIN
    CREATE INDEX [IX_travel_profiles_user_id] ON [travel_profiles] ([user_id]);
END;
GO

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260522115500_InitialCreate'
)
BEGIN
    CREATE INDEX [IX_traveler_connections_receiver_id] ON [traveler_connections] ([receiver_id]);
END;
GO

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260522115500_InitialCreate'
)
BEGIN
    CREATE UNIQUE INDEX [IX_traveler_connections_sender_id_receiver_id] ON [traveler_connections] ([sender_id], [receiver_id]);
END;
GO

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260522115500_InitialCreate'
)
BEGIN
    CREATE INDEX [IX_trip_photos_itinerary_id] ON [trip_photos] ([itinerary_id]);
END;
GO

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260522115500_InitialCreate'
)
BEGIN
    CREATE INDEX [IX_trip_photos_itinerary_item_id] ON [trip_photos] ([itinerary_item_id]);
END;
GO

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260522115500_InitialCreate'
)
BEGIN
    CREATE INDEX [IX_trip_photos_user_id] ON [trip_photos] ([user_id]);
END;
GO

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260522115500_InitialCreate'
)
BEGIN
    CREATE INDEX [IX_trip_requests_user_id] ON [trip_requests] ([user_id]);
END;
GO

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260522115500_InitialCreate'
)
BEGIN
    CREATE INDEX [IX_trip_stats_itinerary_id] ON [trip_stats] ([itinerary_id]);
END;
GO

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260522115500_InitialCreate'
)
BEGIN
    CREATE UNIQUE INDEX [IX_users_email] ON [users] ([email]);
END;
GO

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260522115500_InitialCreate'
)
BEGIN
    INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
    VALUES (N'20260522115500_InitialCreate', N'8.0.7');
END;
GO

COMMIT;
GO

