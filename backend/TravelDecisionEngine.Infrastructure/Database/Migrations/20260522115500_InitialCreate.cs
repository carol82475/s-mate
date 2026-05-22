using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

#pragma warning disable CA1814 // Prefer jagged arrays over multidimensional

namespace TravelDecisionEngine.Infrastructure.Database.Migrations
{
    /// <inheritdoc />
    public partial class InitialCreate : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.CreateTable(
                name: "emergency_contacts",
                columns: table => new
                {
                    id = table.Column<Guid>(type: "uniqueidentifier", nullable: false, defaultValueSql: "NEWID()"),
                    created_at = table.Column<DateTime>(type: "datetime2", nullable: false, defaultValueSql: "SYSUTCDATETIME()"),
                    name = table.Column<string>(type: "nvarchar(255)", maxLength: 255, nullable: false),
                    phone = table.Column<string>(type: "nvarchar(255)", maxLength: 255, nullable: false),
                    region = table.Column<string>(type: "nvarchar(255)", maxLength: 255, nullable: false),
                    status = table.Column<string>(type: "nvarchar(255)", maxLength: 255, nullable: false, defaultValue: "active"),
                    type = table.Column<string>(type: "nvarchar(255)", maxLength: 255, nullable: false),
                    updated_at = table.Column<DateTime>(type: "datetime2", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_emergency_contacts", x => x.id);
                });

            migrationBuilder.CreateTable(
                name: "financial_tools",
                columns: table => new
                {
                    id = table.Column<Guid>(type: "uniqueidentifier", nullable: false, defaultValueSql: "NEWID()"),
                    exchange_rate = table.Column<double>(type: "float", nullable: false),
                    from_currency = table.Column<string>(type: "nvarchar(255)", maxLength: 255, nullable: false),
                    payment_method = table.Column<string>(type: "nvarchar(255)", maxLength: 255, nullable: true),
                    status = table.Column<string>(type: "nvarchar(255)", maxLength: 255, nullable: false, defaultValue: "active"),
                    to_currency = table.Column<string>(type: "nvarchar(255)", maxLength: 255, nullable: false),
                    updated_at = table.Column<DateTime>(type: "datetime2", nullable: false, defaultValueSql: "SYSUTCDATETIME()")
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_financial_tools", x => x.id);
                });

            migrationBuilder.CreateTable(
                name: "local_laws",
                columns: table => new
                {
                    id = table.Column<Guid>(type: "uniqueidentifier", nullable: false, defaultValueSql: "NEWID()"),
                    category = table.Column<string>(type: "nvarchar(255)", maxLength: 255, nullable: false),
                    created_at = table.Column<DateTime>(type: "datetime2", nullable: false, defaultValueSql: "SYSUTCDATETIME()"),
                    description = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    region = table.Column<string>(type: "nvarchar(255)", maxLength: 255, nullable: false),
                    status = table.Column<string>(type: "nvarchar(255)", maxLength: 255, nullable: false, defaultValue: "active"),
                    updated_at = table.Column<DateTime>(type: "datetime2", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_local_laws", x => x.id);
                });

            migrationBuilder.CreateTable(
                name: "places",
                columns: table => new
                {
                    id = table.Column<Guid>(type: "uniqueidentifier", nullable: false, defaultValueSql: "NEWID()"),
                    name = table.Column<string>(type: "nvarchar(255)", maxLength: 255, nullable: false),
                    description = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    latitude = table.Column<decimal>(type: "decimal(9,6)", precision: 9, scale: 6, nullable: false),
                    longitude = table.Column<decimal>(type: "decimal(9,6)", precision: 9, scale: 6, nullable: false),
                    city = table.Column<string>(type: "nvarchar(255)", maxLength: 255, nullable: false),
                    country_code = table.Column<string>(type: "varchar(3)", unicode: false, maxLength: 3, nullable: false),
                    category = table.Column<string>(type: "nvarchar(255)", maxLength: 255, nullable: false),
                    trust_score = table.Column<decimal>(type: "decimal(4,2)", precision: 4, scale: 2, nullable: false),
                    tags = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    open_hours = table.Column<string>(type: "nvarchar(255)", maxLength: 255, nullable: false),
                    price_level = table.Column<string>(type: "nvarchar(30)", maxLength: 30, nullable: false),
                    address = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    avg_rating = table.Column<double>(type: "float", nullable: false, defaultValue: 0.0),
                    google_place_id = table.Column<string>(type: "nvarchar(255)", maxLength: 255, nullable: true),
                    review_count = table.Column<int>(type: "int", nullable: false, defaultValue: 0),
                    status = table.Column<string>(type: "nvarchar(255)", maxLength: 255, nullable: false, defaultValue: "active"),
                    created_at = table.Column<DateTime>(type: "datetime2", nullable: false, defaultValueSql: "SYSUTCDATETIME()"),
                    updated_at = table.Column<DateTime>(type: "datetime2", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_places", x => x.id);
                });

            migrationBuilder.CreateTable(
                name: "quick_phrases",
                columns: table => new
                {
                    id = table.Column<Guid>(type: "uniqueidentifier", nullable: false, defaultValueSql: "NEWID()"),
                    audio_url = table.Column<string>(type: "nvarchar(255)", maxLength: 255, nullable: true),
                    category = table.Column<string>(type: "nvarchar(255)", maxLength: 255, nullable: false),
                    created_at = table.Column<DateTime>(type: "datetime2", nullable: false, defaultValueSql: "SYSUTCDATETIME()"),
                    language_code = table.Column<string>(type: "varchar(5)", unicode: false, maxLength: 5, nullable: true),
                    local_text = table.Column<string>(type: "nvarchar(255)", maxLength: 255, nullable: false),
                    sort_order = table.Column<int>(type: "int", nullable: true),
                    status = table.Column<string>(type: "nvarchar(255)", maxLength: 255, nullable: false, defaultValue: "active"),
                    translated_text = table.Column<string>(type: "nvarchar(255)", maxLength: 255, nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_quick_phrases", x => x.id);
                });

            migrationBuilder.CreateTable(
                name: "subscription_plans",
                columns: table => new
                {
                    id = table.Column<Guid>(type: "uniqueidentifier", nullable: false, defaultValueSql: "NEWID()"),
                    created_at = table.Column<DateTime>(type: "datetime2", nullable: false, defaultValueSql: "SYSUTCDATETIME()"),
                    duration_days = table.Column<int>(type: "int", nullable: false),
                    name = table.Column<string>(type: "nvarchar(255)", maxLength: 255, nullable: false),
                    price = table.Column<decimal>(type: "decimal(18,2)", precision: 18, scale: 2, nullable: false),
                    status = table.Column<string>(type: "nvarchar(255)", maxLength: 255, nullable: false, defaultValue: "active"),
                    tier = table.Column<string>(type: "nvarchar(255)", maxLength: 255, nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_subscription_plans", x => x.id);
                });

            migrationBuilder.CreateTable(
                name: "users",
                columns: table => new
                {
                    id = table.Column<Guid>(type: "uniqueidentifier", nullable: false, defaultValueSql: "NEWID()"),
                    email = table.Column<string>(type: "nvarchar(255)", maxLength: 255, nullable: false),
                    password_hash = table.Column<string>(type: "nvarchar(255)", maxLength: 255, nullable: false),
                    nationality = table.Column<string>(type: "nvarchar(255)", maxLength: 255, nullable: true),
                    language = table.Column<string>(type: "nvarchar(10)", maxLength: 10, nullable: false, defaultValue: "en"),
                    diet_preference = table.Column<string>(type: "nvarchar(255)", maxLength: 255, nullable: true),
                    budget_preference = table.Column<string>(type: "nvarchar(255)", maxLength: 255, nullable: true),
                    is_email_verified = table.Column<bool>(type: "bit", nullable: false, defaultValue: false),
                    auth_provider = table.Column<string>(type: "nvarchar(30)", maxLength: 30, nullable: false, defaultValue: "email"),
                    deleted_at = table.Column<DateTime>(type: "datetime2", nullable: true),
                    avatar_url = table.Column<string>(type: "nvarchar(255)", maxLength: 255, nullable: true),
                    current_lat = table.Column<double>(type: "float", nullable: true),
                    current_lng = table.Column<double>(type: "float", nullable: true),
                    display_name = table.Column<string>(type: "nvarchar(255)", maxLength: 255, nullable: true),
                    location_updated_at = table.Column<DateTime>(type: "datetime2", nullable: true),
                    status = table.Column<string>(type: "nvarchar(255)", maxLength: 255, nullable: false, defaultValue: "active"),
                    status_text = table.Column<string>(type: "nvarchar(255)", maxLength: 255, nullable: true),
                    created_at = table.Column<DateTime>(type: "datetime2", nullable: false, defaultValueSql: "SYSUTCDATETIME()"),
                    updated_at = table.Column<DateTime>(type: "datetime2", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_users", x => x.id);
                });

            migrationBuilder.CreateTable(
                name: "checkpoints",
                columns: table => new
                {
                    id = table.Column<Guid>(type: "uniqueidentifier", nullable: false, defaultValueSql: "NEWID()"),
                    place_id = table.Column<Guid>(type: "uniqueidentifier", nullable: false),
                    name = table.Column<string>(type: "nvarchar(255)", maxLength: 255, nullable: false),
                    description = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    sort_order = table.Column<int>(type: "int", nullable: false),
                    audio_url = table.Column<string>(type: "nvarchar(255)", maxLength: 255, nullable: true),
                    image_url = table.Column<string>(type: "nvarchar(255)", maxLength: 255, nullable: true),
                    fun_fact = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    latitude = table.Column<decimal>(type: "decimal(9,6)", precision: 9, scale: 6, nullable: false),
                    longitude = table.Column<decimal>(type: "decimal(9,6)", precision: 9, scale: 6, nullable: false),
                    status = table.Column<string>(type: "nvarchar(255)", maxLength: 255, nullable: false, defaultValue: "active"),
                    created_at = table.Column<DateTime>(type: "datetime2", nullable: false, defaultValueSql: "SYSUTCDATETIME()"),
                    updated_at = table.Column<DateTime>(type: "datetime2", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_checkpoints", x => x.id);
                    table.ForeignKey(
                        name: "FK_checkpoints_places_place_id",
                        column: x => x.place_id,
                        principalTable: "places",
                        principalColumn: "id",
                        onDelete: ReferentialAction.Restrict);
                });

            migrationBuilder.CreateTable(
                name: "place_media",
                columns: table => new
                {
                    id = table.Column<Guid>(type: "uniqueidentifier", nullable: false, defaultValueSql: "NEWID()"),
                    is_cover = table.Column<bool>(type: "bit", nullable: false, defaultValue: false),
                    media_type = table.Column<string>(type: "nvarchar(255)", maxLength: 255, nullable: false),
                    place_id = table.Column<Guid>(type: "uniqueidentifier", nullable: false),
                    sort_order = table.Column<int>(type: "int", nullable: false, defaultValue: 0),
                    source = table.Column<string>(type: "nvarchar(255)", maxLength: 255, nullable: false),
                    status = table.Column<string>(type: "nvarchar(255)", maxLength: 255, nullable: false, defaultValue: "active"),
                    uploaded_at = table.Column<DateTime>(type: "datetime2", nullable: false, defaultValueSql: "SYSUTCDATETIME()"),
                    url = table.Column<string>(type: "nvarchar(255)", maxLength: 255, nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_place_media", x => x.id);
                    table.ForeignKey(
                        name: "FK_place_media_places_place_id",
                        column: x => x.place_id,
                        principalTable: "places",
                        principalColumn: "id",
                        onDelete: ReferentialAction.Restrict);
                });

            migrationBuilder.CreateTable(
                name: "place_tags",
                columns: table => new
                {
                    id = table.Column<Guid>(type: "uniqueidentifier", nullable: false, defaultValueSql: "NEWID()"),
                    place_id = table.Column<Guid>(type: "uniqueidentifier", nullable: false),
                    status = table.Column<string>(type: "nvarchar(255)", maxLength: 255, nullable: false, defaultValue: "active"),
                    tag = table.Column<string>(type: "nvarchar(255)", maxLength: 255, nullable: false),
                    tag_group = table.Column<string>(type: "nvarchar(255)", maxLength: 255, nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_place_tags", x => x.id);
                    table.ForeignKey(
                        name: "FK_place_tags_places_place_id",
                        column: x => x.place_id,
                        principalTable: "places",
                        principalColumn: "id",
                        onDelete: ReferentialAction.Restrict);
                });

            migrationBuilder.CreateTable(
                name: "direct_messages",
                columns: table => new
                {
                    id = table.Column<Guid>(type: "uniqueidentifier", nullable: false, defaultValueSql: "NEWID()"),
                    content = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    is_read = table.Column<bool>(type: "bit", nullable: false, defaultValue: false),
                    receiver_id = table.Column<Guid>(type: "uniqueidentifier", nullable: false),
                    sender_id = table.Column<Guid>(type: "uniqueidentifier", nullable: false),
                    sent_at = table.Column<DateTime>(type: "datetime2", nullable: false, defaultValueSql: "SYSUTCDATETIME()"),
                    status = table.Column<string>(type: "nvarchar(255)", maxLength: 255, nullable: false, defaultValue: "active")
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_direct_messages", x => x.id);
                    table.ForeignKey(
                        name: "FK_direct_messages_users_receiver_id",
                        column: x => x.receiver_id,
                        principalTable: "users",
                        principalColumn: "id",
                        onDelete: ReferentialAction.Restrict);
                    table.ForeignKey(
                        name: "FK_direct_messages_users_sender_id",
                        column: x => x.sender_id,
                        principalTable: "users",
                        principalColumn: "id",
                        onDelete: ReferentialAction.Restrict);
                });

            migrationBuilder.CreateTable(
                name: "notifications",
                columns: table => new
                {
                    id = table.Column<Guid>(type: "uniqueidentifier", nullable: false, defaultValueSql: "NEWID()"),
                    user_id = table.Column<Guid>(type: "uniqueidentifier", nullable: false),
                    type = table.Column<string>(type: "nvarchar(255)", maxLength: 255, nullable: false),
                    title = table.Column<string>(type: "nvarchar(255)", maxLength: 255, nullable: false),
                    content = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    is_read = table.Column<bool>(type: "bit", nullable: false, defaultValue: false),
                    priority = table.Column<string>(type: "nvarchar(30)", maxLength: 30, nullable: false),
                    created_at = table.Column<DateTime>(type: "datetime2", nullable: false, defaultValueSql: "SYSUTCDATETIME()"),
                    reference_id = table.Column<Guid>(type: "uniqueidentifier", nullable: true),
                    reference_type = table.Column<string>(type: "nvarchar(255)", maxLength: 255, nullable: true),
                    status = table.Column<string>(type: "nvarchar(255)", maxLength: 255, nullable: false, defaultValue: "active")
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_notifications", x => x.id);
                    table.ForeignKey(
                        name: "FK_notifications_users_user_id",
                        column: x => x.user_id,
                        principalTable: "users",
                        principalColumn: "id",
                        onDelete: ReferentialAction.Restrict);
                });

            migrationBuilder.CreateTable(
                name: "preferences",
                columns: table => new
                {
                    id = table.Column<Guid>(type: "uniqueidentifier", nullable: false, defaultValueSql: "NEWID()"),
                    created_at = table.Column<DateTime>(type: "datetime2", nullable: false, defaultValueSql: "SYSUTCDATETIME()"),
                    status = table.Column<string>(type: "nvarchar(255)", maxLength: 255, nullable: false, defaultValue: "active"),
                    type = table.Column<string>(type: "nvarchar(255)", maxLength: 255, nullable: false),
                    user_id = table.Column<Guid>(type: "uniqueidentifier", nullable: false),
                    value = table.Column<string>(type: "nvarchar(255)", maxLength: 255, nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_preferences", x => x.id);
                    table.ForeignKey(
                        name: "FK_preferences_users_user_id",
                        column: x => x.user_id,
                        principalTable: "users",
                        principalColumn: "id",
                        onDelete: ReferentialAction.Restrict);
                });

            migrationBuilder.CreateTable(
                name: "price_reports",
                columns: table => new
                {
                    id = table.Column<Guid>(type: "uniqueidentifier", nullable: false, defaultValueSql: "NEWID()"),
                    user_id = table.Column<Guid>(type: "uniqueidentifier", nullable: false),
                    place_id = table.Column<Guid>(type: "uniqueidentifier", nullable: false),
                    item_name = table.Column<string>(type: "nvarchar(255)", maxLength: 255, nullable: false),
                    price_reported = table.Column<decimal>(type: "decimal(18,2)", precision: 18, scale: 2, nullable: false),
                    market_price_min = table.Column<decimal>(type: "decimal(18,2)", precision: 18, scale: 2, nullable: false),
                    market_price_max = table.Column<decimal>(type: "decimal(18,2)", precision: 18, scale: 2, nullable: false),
                    currency = table.Column<string>(type: "nvarchar(255)", maxLength: 255, nullable: false, defaultValue: "VND"),
                    latitude = table.Column<decimal>(type: "decimal(9,6)", precision: 9, scale: 6, nullable: false),
                    longitude = table.Column<decimal>(type: "decimal(9,6)", precision: 9, scale: 6, nullable: false),
                    status = table.Column<string>(type: "nvarchar(255)", maxLength: 255, nullable: false, defaultValue: "pending"),
                    confirmed_at = table.Column<DateTime>(type: "datetime2", nullable: true),
                    created_at = table.Column<DateTime>(type: "datetime2", nullable: false, defaultValueSql: "SYSUTCDATETIME()"),
                    ai_confidence = table.Column<double>(type: "float", nullable: true),
                    is_confirmed = table.Column<bool>(type: "bit", nullable: false, defaultValue: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_price_reports", x => x.id);
                    table.ForeignKey(
                        name: "FK_price_reports_places_place_id",
                        column: x => x.place_id,
                        principalTable: "places",
                        principalColumn: "id",
                        onDelete: ReferentialAction.Restrict);
                    table.ForeignKey(
                        name: "FK_price_reports_users_user_id",
                        column: x => x.user_id,
                        principalTable: "users",
                        principalColumn: "id",
                        onDelete: ReferentialAction.Restrict);
                });

            migrationBuilder.CreateTable(
                name: "reviews",
                columns: table => new
                {
                    id = table.Column<Guid>(type: "uniqueidentifier", nullable: false, defaultValueSql: "NEWID()"),
                    user_id = table.Column<Guid>(type: "uniqueidentifier", nullable: false),
                    place_id = table.Column<Guid>(type: "uniqueidentifier", nullable: false),
                    rating = table.Column<int>(type: "int", nullable: false),
                    content = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    image_url = table.Column<string>(type: "nvarchar(255)", maxLength: 255, nullable: true),
                    is_verified = table.Column<bool>(type: "bit", nullable: false, defaultValue: false),
                    gps_proof = table.Column<string>(type: "nvarchar(255)", maxLength: 255, nullable: true),
                    exif_verified = table.Column<bool>(type: "bit", nullable: false, defaultValue: false),
                    deleted_at = table.Column<DateTime>(type: "datetime2", nullable: true),
                    gps_proof_lat = table.Column<double>(type: "float", nullable: true),
                    gps_proof_lng = table.Column<double>(type: "float", nullable: true),
                    status = table.Column<string>(type: "nvarchar(255)", maxLength: 255, nullable: false, defaultValue: "active"),
                    trust_score = table.Column<double>(type: "float", nullable: true),
                    verified_at = table.Column<DateTime>(type: "datetime2", nullable: true),
                    created_at = table.Column<DateTime>(type: "datetime2", nullable: false, defaultValueSql: "SYSUTCDATETIME()"),
                    updated_at = table.Column<DateTime>(type: "datetime2", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_reviews", x => x.id);
                    table.ForeignKey(
                        name: "FK_reviews_places_place_id",
                        column: x => x.place_id,
                        principalTable: "places",
                        principalColumn: "id",
                        onDelete: ReferentialAction.Restrict);
                    table.ForeignKey(
                        name: "FK_reviews_users_user_id",
                        column: x => x.user_id,
                        principalTable: "users",
                        principalColumn: "id",
                        onDelete: ReferentialAction.Restrict);
                });

            migrationBuilder.CreateTable(
                name: "transactions",
                columns: table => new
                {
                    id = table.Column<Guid>(type: "uniqueidentifier", nullable: false, defaultValueSql: "NEWID()"),
                    amount = table.Column<decimal>(type: "decimal(18,2)", precision: 18, scale: 2, nullable: false),
                    created_at = table.Column<DateTime>(type: "datetime2", nullable: false, defaultValueSql: "SYSUTCDATETIME()"),
                    currency = table.Column<string>(type: "nvarchar(255)", maxLength: 255, nullable: true, defaultValue: "USD"),
                    paid_at = table.Column<DateTime>(type: "datetime2", nullable: true),
                    plan_id = table.Column<Guid>(type: "uniqueidentifier", nullable: false),
                    status = table.Column<string>(type: "nvarchar(255)", maxLength: 255, nullable: false, defaultValue: "pending"),
                    user_id = table.Column<Guid>(type: "uniqueidentifier", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_transactions", x => x.id);
                    table.ForeignKey(
                        name: "FK_transactions_subscription_plans_plan_id",
                        column: x => x.plan_id,
                        principalTable: "subscription_plans",
                        principalColumn: "id",
                        onDelete: ReferentialAction.Restrict);
                    table.ForeignKey(
                        name: "FK_transactions_users_user_id",
                        column: x => x.user_id,
                        principalTable: "users",
                        principalColumn: "id",
                        onDelete: ReferentialAction.Restrict);
                });

            migrationBuilder.CreateTable(
                name: "travel_profiles",
                columns: table => new
                {
                    id = table.Column<Guid>(type: "uniqueidentifier", nullable: false, defaultValueSql: "NEWID()"),
                    created_at = table.Column<DateTime>(type: "datetime2", nullable: false, defaultValueSql: "SYSUTCDATETIME()"),
                    description = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    status = table.Column<string>(type: "nvarchar(255)", maxLength: 255, nullable: false, defaultValue: "active"),
                    travel_style = table.Column<string>(type: "nvarchar(255)", maxLength: 255, nullable: true),
                    updated_at = table.Column<DateTime>(type: "datetime2", nullable: true),
                    user_id = table.Column<Guid>(type: "uniqueidentifier", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_travel_profiles", x => x.id);
                    table.ForeignKey(
                        name: "FK_travel_profiles_users_user_id",
                        column: x => x.user_id,
                        principalTable: "users",
                        principalColumn: "id",
                        onDelete: ReferentialAction.Restrict);
                });

            migrationBuilder.CreateTable(
                name: "traveler_connections",
                columns: table => new
                {
                    id = table.Column<Guid>(type: "uniqueidentifier", nullable: false, defaultValueSql: "NEWID()"),
                    sender_id = table.Column<Guid>(type: "uniqueidentifier", nullable: false),
                    receiver_id = table.Column<Guid>(type: "uniqueidentifier", nullable: false),
                    status = table.Column<string>(type: "nvarchar(255)", maxLength: 255, nullable: false, defaultValue: "pending"),
                    created_at = table.Column<DateTime>(type: "datetime2", nullable: false, defaultValueSql: "SYSUTCDATETIME()"),
                    updated_at = table.Column<DateTime>(type: "datetime2", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_traveler_connections", x => x.id);
                    table.ForeignKey(
                        name: "FK_traveler_connections_users_receiver_id",
                        column: x => x.receiver_id,
                        principalTable: "users",
                        principalColumn: "id",
                        onDelete: ReferentialAction.Restrict);
                    table.ForeignKey(
                        name: "FK_traveler_connections_users_sender_id",
                        column: x => x.sender_id,
                        principalTable: "users",
                        principalColumn: "id",
                        onDelete: ReferentialAction.Restrict);
                });

            migrationBuilder.CreateTable(
                name: "trip_requests",
                columns: table => new
                {
                    id = table.Column<Guid>(type: "uniqueidentifier", nullable: false, defaultValueSql: "NEWID()"),
                    budget = table.Column<decimal>(type: "decimal(18,2)", precision: 18, scale: 2, nullable: true),
                    created_at = table.Column<DateTime>(type: "datetime2", nullable: false, defaultValueSql: "SYSUTCDATETIME()"),
                    currency = table.Column<string>(type: "nvarchar(255)", maxLength: 255, nullable: true, defaultValue: "USD"),
                    destination = table.Column<string>(type: "nvarchar(255)", maxLength: 255, nullable: false),
                    extra_note = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    interests = table.Column<string>(type: "nvarchar(255)", maxLength: 255, nullable: true),
                    num_days = table.Column<int>(type: "int", nullable: false),
                    status = table.Column<string>(type: "nvarchar(255)", maxLength: 255, nullable: false, defaultValue: "pending"),
                    travel_style = table.Column<string>(type: "nvarchar(255)", maxLength: 255, nullable: true),
                    user_id = table.Column<Guid>(type: "uniqueidentifier", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_trip_requests", x => x.id);
                    table.ForeignKey(
                        name: "FK_trip_requests_users_user_id",
                        column: x => x.user_id,
                        principalTable: "users",
                        principalColumn: "id",
                        onDelete: ReferentialAction.Restrict);
                });

            migrationBuilder.CreateTable(
                name: "itineraries",
                columns: table => new
                {
                    id = table.Column<Guid>(type: "uniqueidentifier", nullable: false, defaultValueSql: "NEWID()"),
                    user_id = table.Column<Guid>(type: "uniqueidentifier", nullable: false),
                    name = table.Column<string>(type: "nvarchar(255)", maxLength: 255, nullable: false),
                    destination = table.Column<string>(type: "nvarchar(255)", maxLength: 255, nullable: false),
                    country_code = table.Column<string>(type: "varchar(3)", unicode: false, maxLength: 3, nullable: false),
                    start_date = table.Column<DateOnly>(type: "date", nullable: false),
                    end_date = table.Column<DateOnly>(type: "date", nullable: true),
                    budget_total = table.Column<decimal>(type: "decimal(18,2)", precision: 18, scale: 2, nullable: true),
                    people_count = table.Column<int>(type: "int", nullable: true),
                    status = table.Column<string>(type: "nvarchar(30)", maxLength: 30, nullable: false),
                    budget_currency = table.Column<string>(type: "varchar(3)", unicode: false, maxLength: 3, nullable: true, defaultValue: "USD"),
                    is_published = table.Column<bool>(type: "bit", nullable: false, defaultValue: false),
                    num_days = table.Column<int>(type: "int", nullable: true),
                    source = table.Column<string>(type: "nvarchar(255)", maxLength: 255, nullable: false, defaultValue: "manual"),
                    trip_request_id = table.Column<Guid>(type: "uniqueidentifier", nullable: true),
                    created_at = table.Column<DateTime>(type: "datetime2", nullable: false, defaultValueSql: "SYSUTCDATETIME()"),
                    updated_at = table.Column<DateTime>(type: "datetime2", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_itineraries", x => x.id);
                    table.ForeignKey(
                        name: "FK_itineraries_trip_requests_trip_request_id",
                        column: x => x.trip_request_id,
                        principalTable: "trip_requests",
                        principalColumn: "id",
                        onDelete: ReferentialAction.Restrict);
                    table.ForeignKey(
                        name: "FK_itineraries_users_user_id",
                        column: x => x.user_id,
                        principalTable: "users",
                        principalColumn: "id",
                        onDelete: ReferentialAction.Restrict);
                });

            migrationBuilder.CreateTable(
                name: "place_suggestions",
                columns: table => new
                {
                    id = table.Column<Guid>(type: "uniqueidentifier", nullable: false, defaultValueSql: "NEWID()"),
                    ai_score = table.Column<double>(type: "float", nullable: true),
                    category = table.Column<string>(type: "nvarchar(255)", maxLength: 255, nullable: true),
                    place_id = table.Column<Guid>(type: "uniqueidentifier", nullable: false),
                    reason = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    sort_order = table.Column<int>(type: "int", nullable: true),
                    status = table.Column<string>(type: "nvarchar(255)", maxLength: 255, nullable: false, defaultValue: "active"),
                    trip_request_id = table.Column<Guid>(type: "uniqueidentifier", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_place_suggestions", x => x.id);
                    table.ForeignKey(
                        name: "FK_place_suggestions_places_place_id",
                        column: x => x.place_id,
                        principalTable: "places",
                        principalColumn: "id",
                        onDelete: ReferentialAction.Restrict);
                    table.ForeignKey(
                        name: "FK_place_suggestions_trip_requests_trip_request_id",
                        column: x => x.trip_request_id,
                        principalTable: "trip_requests",
                        principalColumn: "id",
                        onDelete: ReferentialAction.Restrict);
                });

            migrationBuilder.CreateTable(
                name: "ai_generation_results",
                columns: table => new
                {
                    id = table.Column<Guid>(type: "uniqueidentifier", nullable: false, defaultValueSql: "NEWID()"),
                    completion_tokens = table.Column<int>(type: "int", nullable: true),
                    generated_at = table.Column<DateTime>(type: "datetime2", nullable: false, defaultValueSql: "SYSUTCDATETIME()"),
                    itinerary_id = table.Column<Guid>(type: "uniqueidentifier", nullable: true),
                    model_used = table.Column<string>(type: "nvarchar(255)", maxLength: 255, nullable: true),
                    prompt_tokens = table.Column<int>(type: "int", nullable: true),
                    status = table.Column<string>(type: "nvarchar(255)", maxLength: 255, nullable: false, defaultValue: "active"),
                    trip_request_id = table.Column<Guid>(type: "uniqueidentifier", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_ai_generation_results", x => x.id);
                    table.ForeignKey(
                        name: "FK_ai_generation_results_itineraries_itinerary_id",
                        column: x => x.itinerary_id,
                        principalTable: "itineraries",
                        principalColumn: "id",
                        onDelete: ReferentialAction.Restrict);
                    table.ForeignKey(
                        name: "FK_ai_generation_results_trip_requests_trip_request_id",
                        column: x => x.trip_request_id,
                        principalTable: "trip_requests",
                        principalColumn: "id",
                        onDelete: ReferentialAction.Restrict);
                });

            migrationBuilder.CreateTable(
                name: "chat_sessions",
                columns: table => new
                {
                    id = table.Column<Guid>(type: "uniqueidentifier", nullable: false, defaultValueSql: "NEWID()"),
                    ended_at = table.Column<DateTime>(type: "datetime2", nullable: true),
                    itinerary_id = table.Column<Guid>(type: "uniqueidentifier", nullable: true),
                    started_at = table.Column<DateTime>(type: "datetime2", nullable: false, defaultValueSql: "SYSUTCDATETIME()"),
                    status = table.Column<string>(type: "nvarchar(255)", maxLength: 255, nullable: false, defaultValue: "active"),
                    user_id = table.Column<Guid>(type: "uniqueidentifier", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_chat_sessions", x => x.id);
                    table.ForeignKey(
                        name: "FK_chat_sessions_itineraries_itinerary_id",
                        column: x => x.itinerary_id,
                        principalTable: "itineraries",
                        principalColumn: "id",
                        onDelete: ReferentialAction.Restrict);
                    table.ForeignKey(
                        name: "FK_chat_sessions_users_user_id",
                        column: x => x.user_id,
                        principalTable: "users",
                        principalColumn: "id",
                        onDelete: ReferentialAction.Restrict);
                });

            migrationBuilder.CreateTable(
                name: "daily_schedules",
                columns: table => new
                {
                    id = table.Column<Guid>(type: "uniqueidentifier", nullable: false, defaultValueSql: "NEWID()"),
                    itinerary_id = table.Column<Guid>(type: "uniqueidentifier", nullable: false),
                    schedule_date = table.Column<DateOnly>(type: "date", nullable: false),
                    route_optimized = table.Column<bool>(type: "bit", nullable: false, defaultValue: false),
                    day_number = table.Column<int>(type: "int", nullable: false, defaultValue: 1),
                    status = table.Column<string>(type: "nvarchar(255)", maxLength: 255, nullable: false, defaultValue: "active"),
                    created_at = table.Column<DateTime>(type: "datetime2", nullable: false, defaultValueSql: "SYSUTCDATETIME()"),
                    updated_at = table.Column<DateTime>(type: "datetime2", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_daily_schedules", x => x.id);
                    table.ForeignKey(
                        name: "FK_daily_schedules_itineraries_itinerary_id",
                        column: x => x.itinerary_id,
                        principalTable: "itineraries",
                        principalColumn: "id",
                        onDelete: ReferentialAction.Restrict);
                });

            migrationBuilder.CreateTable(
                name: "itinerary_costs",
                columns: table => new
                {
                    id = table.Column<Guid>(type: "uniqueidentifier", nullable: false, defaultValueSql: "NEWID()"),
                    category = table.Column<string>(type: "nvarchar(255)", maxLength: 255, nullable: false),
                    currency = table.Column<string>(type: "varchar(3)", unicode: false, maxLength: 3, nullable: true),
                    estimated_amount = table.Column<decimal>(type: "decimal(18,2)", precision: 18, scale: 2, nullable: true),
                    itinerary_id = table.Column<Guid>(type: "uniqueidentifier", nullable: false),
                    note = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    status = table.Column<string>(type: "nvarchar(255)", maxLength: 255, nullable: false, defaultValue: "active")
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_itinerary_costs", x => x.id);
                    table.ForeignKey(
                        name: "FK_itinerary_costs_itineraries_itinerary_id",
                        column: x => x.itinerary_id,
                        principalTable: "itineraries",
                        principalColumn: "id",
                        onDelete: ReferentialAction.Restrict);
                });

            migrationBuilder.CreateTable(
                name: "posts",
                columns: table => new
                {
                    id = table.Column<Guid>(type: "uniqueidentifier", nullable: false, defaultValueSql: "NEWID()"),
                    body = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    created_at = table.Column<DateTime>(type: "datetime2", nullable: false, defaultValueSql: "SYSUTCDATETIME()"),
                    itinerary_id = table.Column<Guid>(type: "uniqueidentifier", nullable: true),
                    parent_post_id = table.Column<Guid>(type: "uniqueidentifier", nullable: true),
                    post_type = table.Column<string>(type: "nvarchar(255)", maxLength: 255, nullable: false, defaultValue: "blog"),
                    published_at = table.Column<DateTime>(type: "datetime2", nullable: true),
                    share_count = table.Column<int>(type: "int", nullable: false, defaultValue: 0),
                    status = table.Column<string>(type: "nvarchar(255)", maxLength: 255, nullable: false, defaultValue: "draft"),
                    title = table.Column<string>(type: "nvarchar(255)", maxLength: 255, nullable: false),
                    updated_at = table.Column<DateTime>(type: "datetime2", nullable: true),
                    user_id = table.Column<Guid>(type: "uniqueidentifier", nullable: false),
                    view_count = table.Column<int>(type: "int", nullable: false, defaultValue: 0)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_posts", x => x.id);
                    table.ForeignKey(
                        name: "FK_posts_itineraries_itinerary_id",
                        column: x => x.itinerary_id,
                        principalTable: "itineraries",
                        principalColumn: "id",
                        onDelete: ReferentialAction.Restrict);
                    table.ForeignKey(
                        name: "FK_posts_posts_parent_post_id",
                        column: x => x.parent_post_id,
                        principalTable: "posts",
                        principalColumn: "id",
                        onDelete: ReferentialAction.Restrict);
                    table.ForeignKey(
                        name: "FK_posts_users_user_id",
                        column: x => x.user_id,
                        principalTable: "users",
                        principalColumn: "id",
                        onDelete: ReferentialAction.Restrict);
                });

            migrationBuilder.CreateTable(
                name: "trip_stats",
                columns: table => new
                {
                    id = table.Column<Guid>(type: "uniqueidentifier", nullable: false, defaultValueSql: "NEWID()"),
                    activities_done = table.Column<int>(type: "int", nullable: false, defaultValue: 0),
                    activities_total = table.Column<int>(type: "int", nullable: false, defaultValue: 0),
                    itinerary_id = table.Column<Guid>(type: "uniqueidentifier", nullable: false),
                    new_friends_count = table.Column<int>(type: "int", nullable: false, defaultValue: 0),
                    places_visited = table.Column<int>(type: "int", nullable: false, defaultValue: 0),
                    status = table.Column<string>(type: "nvarchar(255)", maxLength: 255, nullable: false, defaultValue: "active"),
                    total_distance_km = table.Column<double>(type: "float", nullable: false, defaultValue: 0.0),
                    total_photos = table.Column<int>(type: "int", nullable: false, defaultValue: 0),
                    updated_at = table.Column<DateTime>(type: "datetime2", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_trip_stats", x => x.id);
                    table.ForeignKey(
                        name: "FK_trip_stats_itineraries_itinerary_id",
                        column: x => x.itinerary_id,
                        principalTable: "itineraries",
                        principalColumn: "id",
                        onDelete: ReferentialAction.Restrict);
                });

            migrationBuilder.CreateTable(
                name: "messages",
                columns: table => new
                {
                    id = table.Column<Guid>(type: "uniqueidentifier", nullable: false, defaultValueSql: "NEWID()"),
                    chat_session_id = table.Column<Guid>(type: "uniqueidentifier", nullable: false),
                    content = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    role = table.Column<string>(type: "nvarchar(255)", maxLength: 255, nullable: false),
                    sent_at = table.Column<DateTime>(type: "datetime2", nullable: false, defaultValueSql: "SYSUTCDATETIME()"),
                    status = table.Column<string>(type: "nvarchar(255)", maxLength: 255, nullable: false, defaultValue: "active")
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_messages", x => x.id);
                    table.ForeignKey(
                        name: "FK_messages_chat_sessions_chat_session_id",
                        column: x => x.chat_session_id,
                        principalTable: "chat_sessions",
                        principalColumn: "id",
                        onDelete: ReferentialAction.Restrict);
                });

            migrationBuilder.CreateTable(
                name: "itinerary_items",
                columns: table => new
                {
                    id = table.Column<Guid>(type: "uniqueidentifier", nullable: false, defaultValueSql: "NEWID()"),
                    daily_schedule_id = table.Column<Guid>(type: "uniqueidentifier", nullable: false),
                    place_id = table.Column<Guid>(type: "uniqueidentifier", nullable: false),
                    sort_order = table.Column<int>(type: "int", nullable: false),
                    estimated_arrival_time = table.Column<DateTime>(type: "datetime2", nullable: true),
                    visited_at = table.Column<DateTime>(type: "datetime2", nullable: true),
                    activity_status = table.Column<string>(type: "nvarchar(30)", maxLength: 30, nullable: false, defaultValue: "upcoming"),
                    completed_at = table.Column<DateTime>(type: "datetime2", nullable: true),
                    duration_minutes = table.Column<int>(type: "int", nullable: true),
                    status = table.Column<string>(type: "nvarchar(255)", maxLength: 255, nullable: false, defaultValue: "active"),
                    transport_mode = table.Column<string>(type: "nvarchar(255)", maxLength: 255, nullable: true),
                    visit_time = table.Column<TimeOnly>(type: "time", nullable: true),
                    created_at = table.Column<DateTime>(type: "datetime2", nullable: false, defaultValueSql: "SYSUTCDATETIME()"),
                    updated_at = table.Column<DateTime>(type: "datetime2", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_itinerary_items", x => x.id);
                    table.ForeignKey(
                        name: "FK_itinerary_items_daily_schedules_daily_schedule_id",
                        column: x => x.daily_schedule_id,
                        principalTable: "daily_schedules",
                        principalColumn: "id",
                        onDelete: ReferentialAction.Restrict);
                    table.ForeignKey(
                        name: "FK_itinerary_items_places_place_id",
                        column: x => x.place_id,
                        principalTable: "places",
                        principalColumn: "id",
                        onDelete: ReferentialAction.Restrict);
                });

            migrationBuilder.CreateTable(
                name: "post_comments",
                columns: table => new
                {
                    id = table.Column<Guid>(type: "uniqueidentifier", nullable: false, defaultValueSql: "NEWID()"),
                    content = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    created_at = table.Column<DateTime>(type: "datetime2", nullable: false, defaultValueSql: "SYSUTCDATETIME()"),
                    parent_id = table.Column<Guid>(type: "uniqueidentifier", nullable: true),
                    post_id = table.Column<Guid>(type: "uniqueidentifier", nullable: false),
                    status = table.Column<string>(type: "nvarchar(255)", maxLength: 255, nullable: false, defaultValue: "active"),
                    updated_at = table.Column<DateTime>(type: "datetime2", nullable: true),
                    user_id = table.Column<Guid>(type: "uniqueidentifier", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_post_comments", x => x.id);
                    table.ForeignKey(
                        name: "FK_post_comments_post_comments_parent_id",
                        column: x => x.parent_id,
                        principalTable: "post_comments",
                        principalColumn: "id",
                        onDelete: ReferentialAction.Restrict);
                    table.ForeignKey(
                        name: "FK_post_comments_posts_post_id",
                        column: x => x.post_id,
                        principalTable: "posts",
                        principalColumn: "id",
                        onDelete: ReferentialAction.Restrict);
                    table.ForeignKey(
                        name: "FK_post_comments_users_user_id",
                        column: x => x.user_id,
                        principalTable: "users",
                        principalColumn: "id",
                        onDelete: ReferentialAction.Restrict);
                });

            migrationBuilder.CreateTable(
                name: "post_likes",
                columns: table => new
                {
                    id = table.Column<Guid>(type: "uniqueidentifier", nullable: false, defaultValueSql: "NEWID()"),
                    created_at = table.Column<DateTime>(type: "datetime2", nullable: false, defaultValueSql: "SYSUTCDATETIME()"),
                    post_id = table.Column<Guid>(type: "uniqueidentifier", nullable: false),
                    status = table.Column<string>(type: "nvarchar(255)", maxLength: 255, nullable: false, defaultValue: "active"),
                    user_id = table.Column<Guid>(type: "uniqueidentifier", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_post_likes", x => x.id);
                    table.ForeignKey(
                        name: "FK_post_likes_posts_post_id",
                        column: x => x.post_id,
                        principalTable: "posts",
                        principalColumn: "id",
                        onDelete: ReferentialAction.Restrict);
                    table.ForeignKey(
                        name: "FK_post_likes_users_user_id",
                        column: x => x.user_id,
                        principalTable: "users",
                        principalColumn: "id",
                        onDelete: ReferentialAction.Restrict);
                });

            migrationBuilder.CreateTable(
                name: "post_media",
                columns: table => new
                {
                    id = table.Column<Guid>(type: "uniqueidentifier", nullable: false, defaultValueSql: "NEWID()"),
                    created_at = table.Column<DateTime>(type: "datetime2", nullable: false, defaultValueSql: "SYSUTCDATETIME()"),
                    media_type = table.Column<string>(type: "nvarchar(255)", maxLength: 255, nullable: false),
                    post_id = table.Column<Guid>(type: "uniqueidentifier", nullable: false),
                    sort_order = table.Column<int>(type: "int", nullable: false, defaultValue: 0),
                    status = table.Column<string>(type: "nvarchar(255)", maxLength: 255, nullable: false, defaultValue: "active"),
                    url = table.Column<string>(type: "nvarchar(255)", maxLength: 255, nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_post_media", x => x.id);
                    table.ForeignKey(
                        name: "FK_post_media_posts_post_id",
                        column: x => x.post_id,
                        principalTable: "posts",
                        principalColumn: "id",
                        onDelete: ReferentialAction.Restrict);
                });

            migrationBuilder.CreateTable(
                name: "post_tags",
                columns: table => new
                {
                    id = table.Column<Guid>(type: "uniqueidentifier", nullable: false, defaultValueSql: "NEWID()"),
                    post_id = table.Column<Guid>(type: "uniqueidentifier", nullable: false),
                    status = table.Column<string>(type: "nvarchar(255)", maxLength: 255, nullable: false, defaultValue: "active"),
                    tag = table.Column<string>(type: "nvarchar(255)", maxLength: 255, nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_post_tags", x => x.id);
                    table.ForeignKey(
                        name: "FK_post_tags_posts_post_id",
                        column: x => x.post_id,
                        principalTable: "posts",
                        principalColumn: "id",
                        onDelete: ReferentialAction.Restrict);
                });

            migrationBuilder.CreateTable(
                name: "trip_photos",
                columns: table => new
                {
                    id = table.Column<Guid>(type: "uniqueidentifier", nullable: false, defaultValueSql: "NEWID()"),
                    caption = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    created_at = table.Column<DateTime>(type: "datetime2", nullable: false, defaultValueSql: "SYSUTCDATETIME()"),
                    itinerary_id = table.Column<Guid>(type: "uniqueidentifier", nullable: false),
                    itinerary_item_id = table.Column<Guid>(type: "uniqueidentifier", nullable: true),
                    latitude = table.Column<double>(type: "float", nullable: true),
                    longitude = table.Column<double>(type: "float", nullable: true),
                    status = table.Column<string>(type: "nvarchar(255)", maxLength: 255, nullable: false, defaultValue: "active"),
                    taken_at = table.Column<DateTime>(type: "datetime2", nullable: true),
                    thumbnail_url = table.Column<string>(type: "nvarchar(255)", maxLength: 255, nullable: true),
                    url = table.Column<string>(type: "nvarchar(255)", maxLength: 255, nullable: false),
                    user_id = table.Column<Guid>(type: "uniqueidentifier", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_trip_photos", x => x.id);
                    table.ForeignKey(
                        name: "FK_trip_photos_itineraries_itinerary_id",
                        column: x => x.itinerary_id,
                        principalTable: "itineraries",
                        principalColumn: "id",
                        onDelete: ReferentialAction.Restrict);
                    table.ForeignKey(
                        name: "FK_trip_photos_itinerary_items_itinerary_item_id",
                        column: x => x.itinerary_item_id,
                        principalTable: "itinerary_items",
                        principalColumn: "id",
                        onDelete: ReferentialAction.Restrict);
                    table.ForeignKey(
                        name: "FK_trip_photos_users_user_id",
                        column: x => x.user_id,
                        principalTable: "users",
                        principalColumn: "id",
                        onDelete: ReferentialAction.Restrict);
                });

            migrationBuilder.InsertData(
                table: "places",
                columns: new[] { "id", "address", "category", "city", "country_code", "created_at", "description", "google_place_id", "latitude", "longitude", "name", "open_hours", "price_level", "tags", "trust_score", "updated_at" },
                values: new object[,]
                {
                    { new Guid("f2000000-0000-0000-0000-000000000001"), null, "Cultural", "Hanoi", "VN", new DateTime(2026, 5, 21, 0, 0, 0, 0, DateTimeKind.Utc), "Historic district with local food and culture.", null, 21.033333m, 105.850000m, "Hanoi Old Quarter", "06:00-23:00", "medium", "food,walking,history", 4.60m, new DateTime(2026, 5, 21, 0, 0, 0, 0, DateTimeKind.Utc) },
                    { new Guid("f2000000-0000-0000-0000-000000000002"), null, "Historical", "Hanoi", "VN", new DateTime(2026, 5, 21, 0, 0, 0, 0, DateTimeKind.Utc), "Vietnam's first national university and heritage site.", null, 21.028511m, 105.835686m, "Temple of Literature", "08:00-17:00", "low", "history,temple,education", 4.70m, new DateTime(2026, 5, 21, 0, 0, 0, 0, DateTimeKind.Utc) },
                    { new Guid("f2000000-0000-0000-0000-000000000003"), null, "Historical", "Ho Chi Minh City", "VN", new DateTime(2026, 5, 21, 0, 0, 0, 0, DateTimeKind.Utc), "Iconic cathedral in central Ho Chi Minh City.", null, 10.779785m, 106.699018m, "Notre-Dame Cathedral Basilica of Saigon", "08:00-18:00", "low", "cathedral,landmark,architecture", 4.50m, new DateTime(2026, 5, 21, 0, 0, 0, 0, DateTimeKind.Utc) },
                    { new Guid("f2000000-0000-0000-0000-000000000004"), null, "Market", "Ho Chi Minh City", "VN", new DateTime(2026, 5, 21, 0, 0, 0, 0, DateTimeKind.Utc), "Major marketplace with local products and street food.", null, 10.772444m, 106.698056m, "Ben Thanh Market", "07:00-19:00", "medium", "shopping,food,market", 4.10m, new DateTime(2026, 5, 21, 0, 0, 0, 0, DateTimeKind.Utc) }
                });

            migrationBuilder.InsertData(
                table: "users",
                columns: new[] { "id", "auth_provider", "avatar_url", "budget_preference", "created_at", "current_lat", "current_lng", "deleted_at", "diet_preference", "display_name", "email", "is_email_verified", "language", "location_updated_at", "nationality", "password_hash", "status_text", "updated_at" },
                values: new object[] { new Guid("f1000000-0000-0000-0000-000000000001"), "seed", null, "medium", new DateTime(2026, 5, 21, 0, 0, 0, 0, DateTimeKind.Utc), null, null, null, "none", null, "guest@travel-engine.local", true, "en", null, "Unknown", "SEED_ONLY", null, new DateTime(2026, 5, 21, 0, 0, 0, 0, DateTimeKind.Utc) });

            migrationBuilder.InsertData(
                table: "checkpoints",
                columns: new[] { "id", "audio_url", "created_at", "description", "fun_fact", "image_url", "latitude", "longitude", "name", "place_id", "sort_order", "updated_at" },
                values: new object[,]
                {
                    { new Guid("f3000000-0000-0000-0000-000000000001"), "https://cdn.example.com/audio/f3000000-0000-0000-0000-000000000001.mp3", new DateTime(2026, 5, 21, 0, 0, 0, 0, DateTimeKind.Utc), "Checkpoint for Dong Xuan Market Gate", "Local cultural context available.", "https://cdn.example.com/images/f3000000-0000-0000-0000-000000000001.jpg", 21.037000m, 105.847000m, "Dong Xuan Market Gate", new Guid("f2000000-0000-0000-0000-000000000001"), 1, new DateTime(2026, 5, 21, 0, 0, 0, 0, DateTimeKind.Utc) },
                    { new Guid("f3000000-0000-0000-0000-000000000002"), "https://cdn.example.com/audio/f3000000-0000-0000-0000-000000000002.mp3", new DateTime(2026, 5, 21, 0, 0, 0, 0, DateTimeKind.Utc), "Checkpoint for Ta Hien Street", "Local cultural context available.", "https://cdn.example.com/images/f3000000-0000-0000-0000-000000000002.jpg", 21.035200m, 105.852200m, "Ta Hien Street", new Guid("f2000000-0000-0000-0000-000000000001"), 2, new DateTime(2026, 5, 21, 0, 0, 0, 0, DateTimeKind.Utc) },
                    { new Guid("f3000000-0000-0000-0000-000000000003"), "https://cdn.example.com/audio/f3000000-0000-0000-0000-000000000003.mp3", new DateTime(2026, 5, 21, 0, 0, 0, 0, DateTimeKind.Utc), "Checkpoint for Main Gate", "Local cultural context available.", "https://cdn.example.com/images/f3000000-0000-0000-0000-000000000003.jpg", 21.028700m, 105.835300m, "Main Gate", new Guid("f2000000-0000-0000-0000-000000000002"), 1, new DateTime(2026, 5, 21, 0, 0, 0, 0, DateTimeKind.Utc) },
                    { new Guid("f3000000-0000-0000-0000-000000000004"), "https://cdn.example.com/audio/f3000000-0000-0000-0000-000000000004.mp3", new DateTime(2026, 5, 21, 0, 0, 0, 0, DateTimeKind.Utc), "Checkpoint for Doctor Stelae", "Local cultural context available.", "https://cdn.example.com/images/f3000000-0000-0000-0000-000000000004.jpg", 21.028400m, 105.835900m, "Doctor Stelae", new Guid("f2000000-0000-0000-0000-000000000002"), 2, new DateTime(2026, 5, 21, 0, 0, 0, 0, DateTimeKind.Utc) },
                    { new Guid("f3000000-0000-0000-0000-000000000005"), "https://cdn.example.com/audio/f3000000-0000-0000-0000-000000000005.mp3", new DateTime(2026, 5, 21, 0, 0, 0, 0, DateTimeKind.Utc), "Checkpoint for Front Plaza", "Local cultural context available.", "https://cdn.example.com/images/f3000000-0000-0000-0000-000000000005.jpg", 10.779700m, 106.698900m, "Front Plaza", new Guid("f2000000-0000-0000-0000-000000000003"), 1, new DateTime(2026, 5, 21, 0, 0, 0, 0, DateTimeKind.Utc) },
                    { new Guid("f3000000-0000-0000-0000-000000000006"), "https://cdn.example.com/audio/f3000000-0000-0000-0000-000000000006.mp3", new DateTime(2026, 5, 21, 0, 0, 0, 0, DateTimeKind.Utc), "Checkpoint for Central Garden", "Local cultural context available.", "https://cdn.example.com/images/f3000000-0000-0000-0000-000000000006.jpg", 10.779900m, 106.699300m, "Central Garden", new Guid("f2000000-0000-0000-0000-000000000003"), 2, new DateTime(2026, 5, 21, 0, 0, 0, 0, DateTimeKind.Utc) },
                    { new Guid("f3000000-0000-0000-0000-000000000007"), "https://cdn.example.com/audio/f3000000-0000-0000-0000-000000000007.mp3", new DateTime(2026, 5, 21, 0, 0, 0, 0, DateTimeKind.Utc), "Checkpoint for South Gate", "Local cultural context available.", "https://cdn.example.com/images/f3000000-0000-0000-0000-000000000007.jpg", 10.772300m, 106.698200m, "South Gate", new Guid("f2000000-0000-0000-0000-000000000004"), 1, new DateTime(2026, 5, 21, 0, 0, 0, 0, DateTimeKind.Utc) },
                    { new Guid("f3000000-0000-0000-0000-000000000008"), "https://cdn.example.com/audio/f3000000-0000-0000-0000-000000000008.mp3", new DateTime(2026, 5, 21, 0, 0, 0, 0, DateTimeKind.Utc), "Checkpoint for Food Court", "Local cultural context available.", "https://cdn.example.com/images/f3000000-0000-0000-0000-000000000008.jpg", 10.772600m, 106.697900m, "Food Court", new Guid("f2000000-0000-0000-0000-000000000004"), 2, new DateTime(2026, 5, 21, 0, 0, 0, 0, DateTimeKind.Utc) }
                });

            migrationBuilder.InsertData(
                table: "price_reports",
                columns: new[] { "id", "ai_confidence", "confirmed_at", "created_at", "currency", "item_name", "latitude", "longitude", "market_price_max", "market_price_min", "place_id", "price_reported", "status", "user_id" },
                values: new object[,]
                {
                    { new Guid("f4000000-0000-0000-0000-000000000001"), null, new DateTime(2026, 5, 21, 0, 0, 0, 0, DateTimeKind.Utc), new DateTime(2026, 5, 21, 0, 0, 0, 0, DateTimeKind.Utc), "VND", "Pho bowl", 10.772444m, 106.698056m, 80000m, 45000m, new Guid("f2000000-0000-0000-0000-000000000004"), 45000m, "Confirmed", new Guid("f1000000-0000-0000-0000-000000000001") },
                    { new Guid("f4000000-0000-0000-0000-000000000002"), null, new DateTime(2026, 5, 21, 0, 0, 0, 0, DateTimeKind.Utc), new DateTime(2026, 5, 21, 0, 0, 0, 0, DateTimeKind.Utc), "VND", "Banh mi", 10.772444m, 106.698056m, 35000m, 15000m, new Guid("f2000000-0000-0000-0000-000000000004"), 15000m, "Confirmed", new Guid("f1000000-0000-0000-0000-000000000001") },
                    { new Guid("f4000000-0000-0000-0000-000000000003"), null, new DateTime(2026, 5, 21, 0, 0, 0, 0, DateTimeKind.Utc), new DateTime(2026, 5, 21, 0, 0, 0, 0, DateTimeKind.Utc), "VND", "Bottled water", 10.772444m, 106.698056m, 25000m, 10000m, new Guid("f2000000-0000-0000-0000-000000000004"), 10000m, "Confirmed", new Guid("f1000000-0000-0000-0000-000000000001") },
                    { new Guid("f4000000-0000-0000-0000-000000000004"), null, new DateTime(2026, 5, 21, 0, 0, 0, 0, DateTimeKind.Utc), new DateTime(2026, 5, 21, 0, 0, 0, 0, DateTimeKind.Utc), "VND", "Iced coffee", 10.772444m, 106.698056m, 45000m, 18000m, new Guid("f2000000-0000-0000-0000-000000000004"), 18000m, "Confirmed", new Guid("f1000000-0000-0000-0000-000000000001") },
                    { new Guid("f4000000-0000-0000-0000-000000000005"), null, new DateTime(2026, 5, 21, 0, 0, 0, 0, DateTimeKind.Utc), new DateTime(2026, 5, 21, 0, 0, 0, 0, DateTimeKind.Utc), "VND", "Taxi airport to center", 10.772444m, 106.698056m, 300000m, 150000m, new Guid("f2000000-0000-0000-0000-000000000004"), 150000m, "Confirmed", new Guid("f1000000-0000-0000-0000-000000000001") },
                    { new Guid("f4000000-0000-0000-0000-000000000006"), null, new DateTime(2026, 5, 21, 0, 0, 0, 0, DateTimeKind.Utc), new DateTime(2026, 5, 21, 0, 0, 0, 0, DateTimeKind.Utc), "VND", "Motorbike ride per km", 10.772444m, 106.698056m, 18000m, 8000m, new Guid("f2000000-0000-0000-0000-000000000004"), 8000m, "Confirmed", new Guid("f1000000-0000-0000-0000-000000000001") },
                    { new Guid("f4000000-0000-0000-0000-000000000007"), null, new DateTime(2026, 5, 21, 0, 0, 0, 0, DateTimeKind.Utc), new DateTime(2026, 5, 21, 0, 0, 0, 0, DateTimeKind.Utc), "VND", "Coconut", 10.772444m, 106.698056m, 40000m, 15000m, new Guid("f2000000-0000-0000-0000-000000000004"), 15000m, "Confirmed", new Guid("f1000000-0000-0000-0000-000000000001") },
                    { new Guid("f4000000-0000-0000-0000-000000000008"), null, new DateTime(2026, 5, 21, 0, 0, 0, 0, DateTimeKind.Utc), new DateTime(2026, 5, 21, 0, 0, 0, 0, DateTimeKind.Utc), "VND", "Fruit smoothie", 10.772444m, 106.698056m, 60000m, 25000m, new Guid("f2000000-0000-0000-0000-000000000004"), 25000m, "Confirmed", new Guid("f1000000-0000-0000-0000-000000000001") },
                    { new Guid("f4000000-0000-0000-0000-000000000009"), null, new DateTime(2026, 5, 21, 0, 0, 0, 0, DateTimeKind.Utc), new DateTime(2026, 5, 21, 0, 0, 0, 0, DateTimeKind.Utc), "VND", "Street BBQ skewer", 10.772444m, 106.698056m, 30000m, 10000m, new Guid("f2000000-0000-0000-0000-000000000004"), 10000m, "Confirmed", new Guid("f1000000-0000-0000-0000-000000000001") },
                    { new Guid("f4000000-0000-0000-0000-000000000010"), null, new DateTime(2026, 5, 21, 0, 0, 0, 0, DateTimeKind.Utc), new DateTime(2026, 5, 21, 0, 0, 0, 0, DateTimeKind.Utc), "VND", "Museum ticket", 10.772444m, 106.698056m, 80000m, 30000m, new Guid("f2000000-0000-0000-0000-000000000004"), 30000m, "Confirmed", new Guid("f1000000-0000-0000-0000-000000000001") },
                    { new Guid("f4000000-0000-0000-0000-000000000011"), null, new DateTime(2026, 5, 21, 0, 0, 0, 0, DateTimeKind.Utc), new DateTime(2026, 5, 21, 0, 0, 0, 0, DateTimeKind.Utc), "VND", "Temple donation", 10.772444m, 106.698056m, 50000m, 10000m, new Guid("f2000000-0000-0000-0000-000000000004"), 10000m, "Confirmed", new Guid("f1000000-0000-0000-0000-000000000001") },
                    { new Guid("f4000000-0000-0000-0000-000000000012"), null, new DateTime(2026, 5, 21, 0, 0, 0, 0, DateTimeKind.Utc), new DateTime(2026, 5, 21, 0, 0, 0, 0, DateTimeKind.Utc), "VND", "Laundry per kg", 10.772444m, 106.698056m, 70000m, 30000m, new Guid("f2000000-0000-0000-0000-000000000004"), 30000m, "Confirmed", new Guid("f1000000-0000-0000-0000-000000000001") },
                    { new Guid("f4000000-0000-0000-0000-000000000013"), null, new DateTime(2026, 5, 21, 0, 0, 0, 0, DateTimeKind.Utc), new DateTime(2026, 5, 21, 0, 0, 0, 0, DateTimeKind.Utc), "VND", "Local SIM 7-day", 10.772444m, 106.698056m, 250000m, 100000m, new Guid("f2000000-0000-0000-0000-000000000004"), 100000m, "Confirmed", new Guid("f1000000-0000-0000-0000-000000000001") },
                    { new Guid("f4000000-0000-0000-0000-000000000014"), null, new DateTime(2026, 5, 21, 0, 0, 0, 0, DateTimeKind.Utc), new DateTime(2026, 5, 21, 0, 0, 0, 0, DateTimeKind.Utc), "VND", "Rain poncho", 10.772444m, 106.698056m, 30000m, 10000m, new Guid("f2000000-0000-0000-0000-000000000004"), 10000m, "Confirmed", new Guid("f1000000-0000-0000-0000-000000000001") },
                    { new Guid("f4000000-0000-0000-0000-000000000015"), null, new DateTime(2026, 5, 21, 0, 0, 0, 0, DateTimeKind.Utc), new DateTime(2026, 5, 21, 0, 0, 0, 0, DateTimeKind.Utc), "VND", "Souvenir magnet", 10.772444m, 106.698056m, 60000m, 20000m, new Guid("f2000000-0000-0000-0000-000000000004"), 20000m, "Confirmed", new Guid("f1000000-0000-0000-0000-000000000001") },
                    { new Guid("f4000000-0000-0000-0000-000000000016"), null, new DateTime(2026, 5, 21, 0, 0, 0, 0, DateTimeKind.Utc), new DateTime(2026, 5, 21, 0, 0, 0, 0, DateTimeKind.Utc), "VND", "Taxi base fare", 10.772444m, 106.698056m, 25000m, 12000m, new Guid("f2000000-0000-0000-0000-000000000004"), 12000m, "Confirmed", new Guid("f1000000-0000-0000-0000-000000000001") },
                    { new Guid("f4000000-0000-0000-0000-000000000017"), null, new DateTime(2026, 5, 21, 0, 0, 0, 0, DateTimeKind.Utc), new DateTime(2026, 5, 21, 0, 0, 0, 0, DateTimeKind.Utc), "VND", "Grilled seafood plate", 10.772444m, 106.698056m, 280000m, 120000m, new Guid("f2000000-0000-0000-0000-000000000004"), 120000m, "Confirmed", new Guid("f1000000-0000-0000-0000-000000000001") },
                    { new Guid("f4000000-0000-0000-0000-000000000018"), null, new DateTime(2026, 5, 21, 0, 0, 0, 0, DateTimeKind.Utc), new DateTime(2026, 5, 21, 0, 0, 0, 0, DateTimeKind.Utc), "VND", "Fresh juice", 10.772444m, 106.698056m, 50000m, 20000m, new Guid("f2000000-0000-0000-0000-000000000004"), 20000m, "Confirmed", new Guid("f1000000-0000-0000-0000-000000000001") },
                    { new Guid("f4000000-0000-0000-0000-000000000019"), null, new DateTime(2026, 5, 21, 0, 0, 0, 0, DateTimeKind.Utc), new DateTime(2026, 5, 21, 0, 0, 0, 0, DateTimeKind.Utc), "VND", "Train station snack", 10.772444m, 106.698056m, 40000m, 15000m, new Guid("f2000000-0000-0000-0000-000000000004"), 15000m, "Confirmed", new Guid("f1000000-0000-0000-0000-000000000001") },
                    { new Guid("f4000000-0000-0000-0000-000000000020"), null, new DateTime(2026, 5, 21, 0, 0, 0, 0, DateTimeKind.Utc), new DateTime(2026, 5, 21, 0, 0, 0, 0, DateTimeKind.Utc), "VND", "Public restroom fee", 10.772444m, 106.698056m, 10000m, 2000m, new Guid("f2000000-0000-0000-0000-000000000004"), 2000m, "Confirmed", new Guid("f1000000-0000-0000-0000-000000000001") }
                });

            migrationBuilder.CreateIndex(
                name: "IX_ai_generation_results_itinerary_id",
                table: "ai_generation_results",
                column: "itinerary_id");

            migrationBuilder.CreateIndex(
                name: "IX_ai_generation_results_trip_request_id",
                table: "ai_generation_results",
                column: "trip_request_id");

            migrationBuilder.CreateIndex(
                name: "IX_chat_sessions_itinerary_id",
                table: "chat_sessions",
                column: "itinerary_id");

            migrationBuilder.CreateIndex(
                name: "IX_chat_sessions_user_id",
                table: "chat_sessions",
                column: "user_id");

            migrationBuilder.CreateIndex(
                name: "IX_checkpoints_place_id",
                table: "checkpoints",
                column: "place_id");

            migrationBuilder.CreateIndex(
                name: "IX_daily_schedules_itinerary_id",
                table: "daily_schedules",
                column: "itinerary_id");

            migrationBuilder.CreateIndex(
                name: "IX_direct_messages_receiver_id",
                table: "direct_messages",
                column: "receiver_id");

            migrationBuilder.CreateIndex(
                name: "IX_direct_messages_sender_id",
                table: "direct_messages",
                column: "sender_id");

            migrationBuilder.CreateIndex(
                name: "IX_financial_tools_from_currency_to_currency",
                table: "financial_tools",
                columns: new[] { "from_currency", "to_currency" },
                unique: true);

            migrationBuilder.CreateIndex(
                name: "IX_itineraries_trip_request_id",
                table: "itineraries",
                column: "trip_request_id");

            migrationBuilder.CreateIndex(
                name: "IX_itineraries_user_id",
                table: "itineraries",
                column: "user_id");

            migrationBuilder.CreateIndex(
                name: "IX_itinerary_costs_itinerary_id_category",
                table: "itinerary_costs",
                columns: new[] { "itinerary_id", "category" },
                unique: true);

            migrationBuilder.CreateIndex(
                name: "IX_itinerary_items_daily_schedule_id",
                table: "itinerary_items",
                column: "daily_schedule_id");

            migrationBuilder.CreateIndex(
                name: "IX_itinerary_items_place_id",
                table: "itinerary_items",
                column: "place_id");

            migrationBuilder.CreateIndex(
                name: "IX_messages_chat_session_id",
                table: "messages",
                column: "chat_session_id");

            migrationBuilder.CreateIndex(
                name: "IX_notifications_user_id",
                table: "notifications",
                column: "user_id");

            migrationBuilder.CreateIndex(
                name: "IX_place_media_place_id",
                table: "place_media",
                column: "place_id");

            migrationBuilder.CreateIndex(
                name: "IX_place_suggestions_place_id",
                table: "place_suggestions",
                column: "place_id");

            migrationBuilder.CreateIndex(
                name: "IX_place_suggestions_trip_request_id",
                table: "place_suggestions",
                column: "trip_request_id");

            migrationBuilder.CreateIndex(
                name: "IX_place_tags_place_id_tag",
                table: "place_tags",
                columns: new[] { "place_id", "tag" },
                unique: true);

            migrationBuilder.CreateIndex(
                name: "IX_post_comments_parent_id",
                table: "post_comments",
                column: "parent_id");

            migrationBuilder.CreateIndex(
                name: "IX_post_comments_post_id",
                table: "post_comments",
                column: "post_id");

            migrationBuilder.CreateIndex(
                name: "IX_post_comments_user_id",
                table: "post_comments",
                column: "user_id");

            migrationBuilder.CreateIndex(
                name: "IX_post_likes_post_id_user_id",
                table: "post_likes",
                columns: new[] { "post_id", "user_id" },
                unique: true);

            migrationBuilder.CreateIndex(
                name: "IX_post_likes_user_id",
                table: "post_likes",
                column: "user_id");

            migrationBuilder.CreateIndex(
                name: "IX_post_media_post_id",
                table: "post_media",
                column: "post_id");

            migrationBuilder.CreateIndex(
                name: "IX_post_tags_post_id",
                table: "post_tags",
                column: "post_id");

            migrationBuilder.CreateIndex(
                name: "IX_posts_itinerary_id",
                table: "posts",
                column: "itinerary_id");

            migrationBuilder.CreateIndex(
                name: "IX_posts_parent_post_id",
                table: "posts",
                column: "parent_post_id");

            migrationBuilder.CreateIndex(
                name: "IX_posts_user_id",
                table: "posts",
                column: "user_id");

            migrationBuilder.CreateIndex(
                name: "IX_preferences_user_id",
                table: "preferences",
                column: "user_id");

            migrationBuilder.CreateIndex(
                name: "IX_price_reports_place_id",
                table: "price_reports",
                column: "place_id");

            migrationBuilder.CreateIndex(
                name: "IX_price_reports_user_id",
                table: "price_reports",
                column: "user_id");

            migrationBuilder.CreateIndex(
                name: "IX_reviews_place_id_user_id",
                table: "reviews",
                columns: new[] { "place_id", "user_id" },
                unique: true);

            migrationBuilder.CreateIndex(
                name: "IX_reviews_user_id",
                table: "reviews",
                column: "user_id");

            migrationBuilder.CreateIndex(
                name: "IX_transactions_plan_id",
                table: "transactions",
                column: "plan_id");

            migrationBuilder.CreateIndex(
                name: "IX_transactions_user_id",
                table: "transactions",
                column: "user_id");

            migrationBuilder.CreateIndex(
                name: "IX_travel_profiles_user_id",
                table: "travel_profiles",
                column: "user_id");

            migrationBuilder.CreateIndex(
                name: "IX_traveler_connections_receiver_id",
                table: "traveler_connections",
                column: "receiver_id");

            migrationBuilder.CreateIndex(
                name: "IX_traveler_connections_sender_id_receiver_id",
                table: "traveler_connections",
                columns: new[] { "sender_id", "receiver_id" },
                unique: true);

            migrationBuilder.CreateIndex(
                name: "IX_trip_photos_itinerary_id",
                table: "trip_photos",
                column: "itinerary_id");

            migrationBuilder.CreateIndex(
                name: "IX_trip_photos_itinerary_item_id",
                table: "trip_photos",
                column: "itinerary_item_id");

            migrationBuilder.CreateIndex(
                name: "IX_trip_photos_user_id",
                table: "trip_photos",
                column: "user_id");

            migrationBuilder.CreateIndex(
                name: "IX_trip_requests_user_id",
                table: "trip_requests",
                column: "user_id");

            migrationBuilder.CreateIndex(
                name: "IX_trip_stats_itinerary_id",
                table: "trip_stats",
                column: "itinerary_id");

            migrationBuilder.CreateIndex(
                name: "IX_users_email",
                table: "users",
                column: "email",
                unique: true);
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropTable(
                name: "ai_generation_results");

            migrationBuilder.DropTable(
                name: "checkpoints");

            migrationBuilder.DropTable(
                name: "direct_messages");

            migrationBuilder.DropTable(
                name: "emergency_contacts");

            migrationBuilder.DropTable(
                name: "financial_tools");

            migrationBuilder.DropTable(
                name: "itinerary_costs");

            migrationBuilder.DropTable(
                name: "local_laws");

            migrationBuilder.DropTable(
                name: "messages");

            migrationBuilder.DropTable(
                name: "notifications");

            migrationBuilder.DropTable(
                name: "place_media");

            migrationBuilder.DropTable(
                name: "place_suggestions");

            migrationBuilder.DropTable(
                name: "place_tags");

            migrationBuilder.DropTable(
                name: "post_comments");

            migrationBuilder.DropTable(
                name: "post_likes");

            migrationBuilder.DropTable(
                name: "post_media");

            migrationBuilder.DropTable(
                name: "post_tags");

            migrationBuilder.DropTable(
                name: "preferences");

            migrationBuilder.DropTable(
                name: "price_reports");

            migrationBuilder.DropTable(
                name: "quick_phrases");

            migrationBuilder.DropTable(
                name: "reviews");

            migrationBuilder.DropTable(
                name: "transactions");

            migrationBuilder.DropTable(
                name: "travel_profiles");

            migrationBuilder.DropTable(
                name: "traveler_connections");

            migrationBuilder.DropTable(
                name: "trip_photos");

            migrationBuilder.DropTable(
                name: "trip_stats");

            migrationBuilder.DropTable(
                name: "chat_sessions");

            migrationBuilder.DropTable(
                name: "posts");

            migrationBuilder.DropTable(
                name: "subscription_plans");

            migrationBuilder.DropTable(
                name: "itinerary_items");

            migrationBuilder.DropTable(
                name: "daily_schedules");

            migrationBuilder.DropTable(
                name: "places");

            migrationBuilder.DropTable(
                name: "itineraries");

            migrationBuilder.DropTable(
                name: "trip_requests");

            migrationBuilder.DropTable(
                name: "users");
        }
    }
}
