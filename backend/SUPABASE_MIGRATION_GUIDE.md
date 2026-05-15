# S-Mate Backend: MongoDB to Supabase Migration Guide

## Overview

This guide documents the complete migration from MongoDB/Mongoose to Supabase PostgreSQL for the S-Mate backend.

## What Changed

### Removed
- ❌ MongoDB & Mongoose
- ❌ bcrypt password hashing
- ❌ Custom JWT generation
- ❌ Manual user authentication
- ❌ All Mongoose models

### Added
- ✅ Supabase PostgreSQL
- ✅ Supabase Auth
- ✅ Supabase Storage
- ✅ SQL migrations with RLS policies
- ✅ @supabase/supabase-js client
- ✅ Winston logging
- ✅ Repository pattern for database access

## Architecture

```
Express.js (Business Logic Layer)
    ↓
Supabase Client (Data Layer)
    ↓
PostgreSQL + Auth + Storage
```

**Express handles:**
- API routing
- Business logic
- Validation (Zod)
- AI mock providers
- Swagger documentation
- Custom aggregations
- Mobile-friendly responses

**Supabase provides:**
- Database (PostgreSQL)
- Authentication
- File storage
- Row Level Security
- Realtime subscriptions

## Setup Instructions

### 1. Create Supabase Project

1. Go to [supabase.com](https://supabase.com)
2. Create new project
3. Wait for database to provision
4. Note your project URL and keys

### 2. Configure Environment

Copy `.env.example` to `.env`:

```bash
cp .env.example .env
```

Update with your Supabase credentials:

```env
SUPABASE_URL=https://your-project.supabase.co
SUPABASE_ANON_KEY=your-anon-key-here
SUPABASE_SERVICE_ROLE_KEY=your-service-role-key-here
PORT=5000
NODE_ENV=development
```

**Security Note:** Never expose `SUPABASE_SERVICE_ROLE_KEY` to frontend!

### 3. Run Database Migrations

#### Option A: Supabase Dashboard (Recommended)

1. Go to your Supabase project dashboard
2. Navigate to **SQL Editor**
3. Copy content from `supabase/migrations/001_initial_schema.sql`
4. Paste and run the migration
5. Verify tables were created in **Table Editor**

#### Option B: Supabase CLI

```bash
# Install Supabase CLI
npm install -g supabase

# Login
supabase login

# Link project
supabase link --project-ref your-project-ref

# Run migrations
supabase db push
```

### 4. Seed Database

Run seed SQL in Supabase SQL Editor:

```bash
# Copy content from supabase/seed.sql and run in SQL Editor
```

Or use the TypeScript seed script:

```bash
npm run seed
```

### 5. Configure Storage Bucket

1. Go to **Storage** in Supabase dashboard
2. Create new bucket: `trip-photos`
3. Set bucket to **Public** because the mobile app uses `getPublicUrl()`
4. Enable RLS policies for user uploads
5. If uploads fail with a missing bucket error, confirm the bucket name is exactly `trip-photos`

### 6. Install Dependencies

```bash
cd backend
npm install
```

### 7. Start Development Server

```bash
npm run dev
```

Server starts at `http://localhost:5000`

## Database Schema

### Core Tables

1. **profiles** - User profiles (auto-created on signup)
2. **trips** - Trip planning data
3. **itinerary_days** - Daily itineraries
4. **checkpoints** - Itinerary checkpoints
5. **ai_chat_messages** - AI chat history
6. **traveler_profiles** - Searchable traveler data
7. **chat_rooms** - Chat room metadata
8. **chat_room_members** - Room membership
9. **chat_messages** - Chat messages
10. **forum_posts** - Forum posts
11. **forum_post_likes** - Post likes
12. **forum_comments** - Post comments
13. **albums** - Photo albums
14. **photos** - Photo metadata
15. **photo_likes** - Photo likes
16. **emergency_contacts** - Emergency numbers
17. **safety_tips** - Safety information
18. **quick_phrases** - Translation phrases

### Row Level Security (RLS)

All user-owned tables have RLS enabled:

- Users can only access their own trips, albums, photos, AI chat
- Forum posts are readable by all authenticated users
- Emergency data is publicly readable
- Chat messages are only visible to room members

## Authentication Flow

### Registration

```typescript
// Frontend calls Supabase directly
const { data, error } = await supabase.auth.signUp({
  email: 'user@example.com',
  password: 'password123',
  options: {
    data: {
      full_name: 'John Doe'
    }
  }
});

// Trigger automatically creates profile and traveler_profile
```

### Login

```typescript
// Frontend calls Supabase
const { data, error } = await supabase.auth.signInWithPassword({
  email: 'user@example.com',
  password: 'password123'
});

// Use data.session.access_token for API calls
```

### API Requests

```typescript
// Include token in Authorization header
fetch('http://localhost:5000/api/v1/trips', {
  headers: {
    'Authorization': `Bearer ${accessToken}`,
    'Content-Type': 'application/json'
  }
});
```

### Backend Verification

```typescript
// Middleware verifies token with Supabase
const { data: { user }, error } = await supabaseAdmin.auth.getUser(token);
// Attaches user to req.user
```

## API Changes

### Before (MongoDB)

```typescript
// Old: Mongoose model
const user = await User.findById(userId);
const trips = await Trip.find({ userId }).sort({ createdAt: -1 });
```

### After (Supabase)

```typescript
// New: Supabase client
const { data: profile } = await supabase
  .from('profiles')
  .select('*')
  .eq('id', userId)
  .single();

const { data: trips } = await supabase
  .from('trips')
  .select('*')
  .eq('user_id', userId)
  .order('created_at', { ascending: false });
```

## Module Structure

Each module follows this pattern:

```
modules/example/
├── example.routes.ts       # Express routes
├── example.controller.ts   # Request handlers
├── example.service.ts      # Business logic
├── example.repository.ts   # Database queries
├── example.validation.ts   # Zod schemas
└── example.types.ts        # TypeScript types
```

## File Upload Flow

### 1. Get Upload URL

```typescript
POST /api/v1/albums/upload-url
{
  "fileName": "photo.jpg",
  "fileType": "image/jpeg"
}

Response:
{
  "success": true,
  "data": {
    "uploadUrl": "https://...",
    "publicUrl": "https://..."
  }
}
```

### 2. Upload File

```typescript
// Frontend uploads directly to Supabase Storage
await fetch(uploadUrl, {
  method: 'PUT',
  body: file,
  headers: { 'Content-Type': fileType }
});
```

### 3. Save Metadata

```typescript
POST /api/v1/albums/:id/photos
{
  "image_url": "https://...",
  "caption": "Beautiful sunset"
}
```

```http
POST /api/v1/albums/photos
{
  "image_url": "https://...",
  "caption": "Beautiful sunset",
  "location": "Da Lat, Vietnam",
  "metadata": {
    "source": "trip_camera"
  }
}
```

## Socket.IO with Supabase Auth

```typescript
// Client connects with Supabase token
const socket = io('http://localhost:5000', {
  auth: {
    token: supabaseAccessToken
  }
});

// Server verifies token
io.use(async (socket, next) => {
  const token = socket.handshake.auth.token;
  const { data: { user } } = await supabaseAdmin.auth.getUser(token);
  socket.userId = user.id;
  next();
});
```

## Testing

### Health Check

```bash
curl http://localhost:5000/health
```

### Register User

```bash
# Use Supabase client in your app or test with Supabase dashboard
```

### Login and Get Token

```bash
# Use Supabase client to get access_token
```

### Test Protected Endpoint

```bash
curl -H "Authorization: Bearer YOUR_TOKEN" \
  http://localhost:5000/api/v1/users/profile
```

## Common Issues

### Issue: "Missing Supabase environment variables"

**Solution:** Ensure `.env` file has all required Supabase variables

### Issue: "relation does not exist"

**Solution:** Run migrations in Supabase SQL Editor

### Issue: "JWT expired"

**Solution:** Refresh token using Supabase client

### Issue: "Row Level Security policy violation"

**Solution:** Check RLS policies match your query patterns

## Migration Checklist

- [x] Remove MongoDB/Mongoose dependencies
- [x] Add Supabase client
- [x] Create SQL migrations
- [x] Add RLS policies
- [x] Update authentication to use Supabase Auth
- [x] Replace Mongoose models with Supabase queries
- [x] Update all repositories
- [x] Update all services
- [x] Test all endpoints
- [x] Update documentation
- [x] Configure storage bucket
- [x] Update Socket.IO auth

## Performance Tips

1. **Use indexes** - Already added in migration
2. **Batch queries** - Use Supabase's batch operations
3. **Cache frequently accessed data** - Consider Redis
4. **Use connection pooling** - Supabase handles this
5. **Optimize RLS policies** - Keep them simple

## Security Best Practices

1. ✅ Never expose service role key to frontend
2. ✅ Always use RLS policies
3. ✅ Validate all inputs with Zod
4. ✅ Use HTTPS in production
5. ✅ Rate limit authentication endpoints
6. ✅ Sanitize user inputs
7. ✅ Use prepared statements (Supabase does this)

## Next Steps

1. Deploy to production (Vercel, Railway, etc.)
2. Configure custom domain
3. Set up monitoring (Sentry, LogRocket)
4. Add real AI integration (OpenAI/Gemini)
5. Implement caching layer
6. Add automated tests
7. Set up CI/CD pipeline

## Resources

- [Supabase Documentation](https://supabase.com/docs)
- [Supabase Auth Guide](https://supabase.com/docs/guides/auth)
- [Row Level Security](https://supabase.com/docs/guides/auth/row-level-security)
- [Supabase Storage](https://supabase.com/docs/guides/storage)
- [PostgreSQL Documentation](https://www.postgresql.org/docs/)

## Support

For issues or questions:
- Check Supabase documentation
- Review migration guide
- Check application logs
- Contact S-Mate development team
