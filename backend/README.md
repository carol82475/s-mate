# S-Mate Backend API

> **Supabase Edition** - Complete backend for S-Mate AI-powered travel companion app

## 🚀 Quick Start

```bash
# 1. Install dependencies
npm install

# 2. Set up environment
cp .env.example .env
# Edit .env with your Supabase credentials

# 3. Run migrations in Supabase dashboard
# Copy supabase/migrations/001_initial_schema.sql to SQL Editor

# 4. Seed database
npm run seed

# 5. Start development server
npm run dev
```

Server runs at `http://localhost:5000`

## 📚 Documentation

- **API Docs**: http://localhost:5000/api-docs
- **Health Check**: http://localhost:5000/health
- **Migration Guide**: [SUPABASE_MIGRATION_GUIDE.md](./SUPABASE_MIGRATION_GUIDE.md)
- **Cleanup Summary**: [CLEANUP_SUMMARY.md](./CLEANUP_SUMMARY.md)

## 🏗️ Tech Stack

- **Runtime**: Node.js + TypeScript
- **Framework**: Express.js
- **Database**: Supabase PostgreSQL
- **Authentication**: Supabase Auth
- **Storage**: Supabase Storage
- **Real-time**: Socket.IO
- **Validation**: Zod
- **Documentation**: Swagger/OpenAPI
- **Logging**: Winston
- **Security**: Helmet, CORS, Rate Limiting

## 🔑 Features

✅ **Authentication** - Supabase Auth with JWT tokens
✅ **User Management** - Profiles, settings, stats
✅ **Trip Planning** - AI-generated itineraries
✅ **Map Explorer** - Search nearby places
✅ **AI Chat** - Travel assistant
✅ **Traveler Matching** - Find fellow travelers
✅ **Real-time Chat** - Socket.IO messaging
✅ **Travel Forum** - Posts, likes, comments
✅ **Photo Albums** - Trip photo management
✅ **Emergency Support** - Contacts, phrases, tips
✅ **Row Level Security** - Database-level access control

## 📁 Project Structure

```
backend/
├── supabase/
│   ├── migrations/
│   │   └── 001_initial_schema.sql
│   └── seed.sql
├── src/
│   ├── config/
│   │   ├── env.ts
│   │   └── supabase.ts
│   ├── core/
│   │   ├── errors/
│   │   ├── logger/
│   │   ├── responses/
│   │   └── pagination/
│   ├── middlewares/
│   │   ├── auth.middleware.ts
│   │   ├── error.middleware.ts
│   │   ├── validate.middleware.ts
│   │   └── rateLimit.middleware.ts
│   ├── modules/
│   │   ├── auth/
│   │   ├── users/
│   │   ├── trips/
│   │   ├── ai-chat/
│   │   ├── travelers/
│   │   ├── chats/
│   │   ├── forum/
│   │   ├── albums/
│   │   ├── map/
│   │   ├── emergency/
│   │   └── quick-actions/
│   ├── sockets/
│   │   └── chat.socket.ts
│   ├── types/
│   │   └── supabase.types.ts
│   ├── utils/
│   │   └── asyncHandler.ts
│   ├── app.ts
│   └── server.ts
├── package.json
├── tsconfig.json
├── .env.example
└── README.md
```

## 🔧 Environment Variables

```env
# Supabase
SUPABASE_URL=https://your-project.supabase.co
SUPABASE_ANON_KEY=your-anon-key
SUPABASE_SERVICE_ROLE_KEY=your-service-role-key

# Server
PORT=5000
NODE_ENV=development

# CORS
CORS_ORIGIN=http://localhost:3000

# Socket.IO
SOCKET_CORS_ORIGIN=http://localhost:3000
```

## 📡 API Endpoints

### Auth
- `POST /api/v1/auth/register` - Register user
- `POST /api/v1/auth/login` - Login user
- `POST /api/v1/auth/logout` - Logout user
- `GET /api/v1/auth/me` - Get current user
- `POST /api/v1/auth/forgot-password` - Request password reset

### Users
- `GET /api/v1/users/profile` - Get profile
- `PUT /api/v1/users/profile` - Update profile
- `PUT /api/v1/users/settings` - Update settings
- `POST /api/v1/users/change-password` - Change password
- `GET /api/v1/users/trip-history` - Get trip history
- `GET /api/v1/users/stats` - Get statistics

### Trips
- `POST /api/v1/trips` - Create trip
- `GET /api/v1/trips` - List trips
- `GET /api/v1/trips/:id` - Get trip details
- `PUT /api/v1/trips/:id` - Update trip
- `DELETE /api/v1/trips/:id` - Delete trip
- `PATCH /api/v1/trips/:id/checkpoint` - Update checkpoint

### AI Chat
- `POST /api/v1/ai-chat/message` - Send message
- `GET /api/v1/ai-chat/history` - Get history
- `DELETE /api/v1/ai-chat/history` - Clear history

### Travelers
- `GET /api/v1/travelers/search` - Search travelers
- `GET /api/v1/travelers/online` - Get online travelers
- `GET /api/v1/travelers/:id` - Get traveler profile

### Chats
- `GET /api/v1/chats/rooms` - Get chat rooms
- `POST /api/v1/chats/rooms` - Create/get chat room
- `GET /api/v1/chats/rooms/:roomId/messages` - Get messages
- `POST /api/v1/chats/rooms/:roomId/messages` - Send message

### Forum
- `POST /api/v1/forum/posts` - Create post
- `GET /api/v1/forum/posts` - List posts
- `GET /api/v1/forum/posts/:id` - Get post
- `POST /api/v1/forum/posts/:id/like` - Like/unlike post
- `POST /api/v1/forum/posts/:id/comments` - Add comment

### Albums
- `POST /api/v1/albums` - Create album
- `GET /api/v1/albums` - List albums
- `GET /api/v1/albums/:id` - Get album
- `POST /api/v1/albums/:id/photos` - Add photo
- `POST /api/v1/albums/photos/:id/like` - Like photo

### Map
- `GET /api/v1/map/search` - Search places
- `GET /api/v1/map/nearby` - Get nearby places
- `GET /api/v1/map/places/:id` - Get place details

### Emergency
- `GET /api/v1/emergency/contacts` - Get emergency contacts
- `GET /api/v1/emergency/phrases` - Get quick phrases
- `GET /api/v1/emergency/safety-tips` - Get safety tips

### Quick Actions
- `GET /api/v1/quick-actions` - Get dynamic actions

## 🔒 Authentication

### Frontend (Flutter)

```dart
// Register
final response = await supabase.auth.signUp(
  email: 'user@example.com',
  password: 'password123',
  data: {'full_name': 'John Doe'}
);

// Login
final response = await supabase.auth.signInWithPassword(
  email: 'user@example.com',
  password: 'password123'
);

// Get access token
final token = response.session?.accessToken;

// Use token for API calls
final apiResponse = await http.get(
  Uri.parse('http://localhost:5000/api/v1/trips'),
  headers: {
    'Authorization': 'Bearer $token',
    'Content-Type': 'application/json'
  }
);
```

## 🔌 Socket.IO

### Client Connection

```dart
import 'package:socket_io_client/socket_io_client.dart' as IO;

final socket = IO.io('http://localhost:5000', <String, dynamic>{
  'transports': ['websocket'],
  'auth': {'token': supabaseAccessToken}
});

socket.on('connect', (_) => print('Connected'));
socket.emit('join_room', roomId);
socket.on('new_message', (data) => handleMessage(data));
```

### Events

**Client → Server**
- `join_room` - Join chat room
- `leave_room` - Leave chat room
- `send_message` - Send message
- `typing` - Typing indicator
- `call_user` - Initiate call
- `answer_call` - Answer call
- `end_call` - End call

**Server → Client**
- `new_message` - New message received
- `message_notification` - Message notification
- `user_typing` - User typing status
- `incoming_call` - Incoming call
- `call_answered` - Call answered
- `call_ended` - Call ended

## 📦 Scripts

```bash
npm run dev      # Start development server
npm run build    # Build TypeScript
npm start        # Run production build
npm run seed     # Seed database
npm run lint     # Run ESLint
```

## 🗄️ Database

### Tables
- `profiles` - User profiles
- `trips` - Trip data
- `itinerary_days` - Daily itineraries
- `checkpoints` - Itinerary checkpoints
- `ai_chat_messages` - AI chat history
- `traveler_profiles` - Traveler search data
- `chat_rooms` - Chat metadata
- `chat_messages` - Messages
- `forum_posts` - Forum posts
- `albums` - Photo albums
- `photos` - Photo metadata
- `emergency_contacts` - Emergency numbers
- `safety_tips` - Safety information
- `quick_phrases` - Translation phrases

### Row Level Security

All user-owned tables have RLS enabled:
- Users can only access their own data
- Forum posts readable by all authenticated users
- Emergency data publicly readable
- Chat messages only visible to room members

## 🧪 Testing

```bash
# Health check
curl http://localhost:5000/health

# Test protected endpoint (replace TOKEN)
curl -H "Authorization: Bearer TOKEN" \
  http://localhost:5000/api/v1/users/profile
```

## 🌐 Flutter Connection

### Android Emulator
```dart
const baseUrl = 'http://10.0.2.2:5000/api/v1';
```

### iOS Simulator
```dart
const baseUrl = 'http://localhost:5000/api/v1';
```

### Real Device
```dart
const baseUrl = 'http://YOUR_IP:5000/api/v1';
```

## 🐛 Troubleshooting

### "Missing Supabase environment variables"
- Check `.env` file exists and has all required variables

### "relation does not exist"
- Run migrations in Supabase SQL Editor

### "JWT expired"
- Refresh token using Supabase client

### "Row Level Security policy violation"
- Check RLS policies in Supabase dashboard

## 📚 Additional Resources

- [Supabase Documentation](https://supabase.com/docs)
- [Express.js Guide](https://expressjs.com/)
- [TypeScript Handbook](https://www.typescriptlang.org/docs/)
- [Socket.IO Documentation](https://socket.io/docs/)

## 🤝 Contributing

1. Follow existing code structure
2. Use repository pattern for database access
3. Add Zod validation for all inputs
4. Update Swagger documentation
5. Test all endpoints
6. Follow TypeScript best practices

## 📄 License

MIT

---

**Built with ❤️ using Supabase PostgreSQL**
