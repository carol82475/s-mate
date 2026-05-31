# TravelDecisionEngine Backend (.NET)

## Prerequisites
- .NET SDK 8.0+
- SQL Server

## Run API
```bash
dotnet restore backend/TravelDecisionEngine.Api/TravelDecisionEngine.Api.csproj
dotnet run --project backend/TravelDecisionEngine.Api/TravelDecisionEngine.Api.csproj
```

## Migrations
```bash
dotnet tool install --global dotnet-ef
dotnet ef migrations add InitialCreate --project backend/TravelDecisionEngine.Infrastructure/TravelDecisionEngine.Infrastructure.csproj --startup-project backend/TravelDecisionEngine.Api/TravelDecisionEngine.Api.csproj --output-dir Database/Migrations
dotnet ef database update --project backend/TravelDecisionEngine.Infrastructure/TravelDecisionEngine.Infrastructure.csproj --startup-project backend/TravelDecisionEngine.Api/TravelDecisionEngine.Api.csproj
```

If dotnet-ef is unavailable, use `backend/TravelDecisionEngine.Infrastructure/Database/Migrations/001_InitialSchema.sql` as a manual baseline.
