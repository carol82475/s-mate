-- Enable UUID extension
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

-- Create profiles table
CREATE TABLE profiles (
  id UUID PRIMARY KEY REFERENCES auth.users(id) ON DELETE CASCADE,
  full_name TEXT NOT NULL,
  avatar_url TEXT,
  country TEXT,
  bio TEXT,
  interests TEXT[] DEFAULT '{}',
  language TEXT DEFAULT 'en',
  notifications_enabled BOOLEAN DEFAULT true,
  privacy_show_online BOOLEAN DEFAULT true,
  privacy_show_location BOOLEAN DEFAULT true,
  stats_trips_completed INTEGER DEFAULT 0,
  stats_places_visited INTEGER DEFAULT 0,
  stats_photos_shared INTEGER DEFAULT 0,
  is_online BOOLEAN DEFAULT false,
  last_seen TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Create trips table
CREATE TABLE trips (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  user_id UUID NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
  destination TEXT NOT NULL,
  start_date DATE NOT NULL,
  end_date DATE NOT NULL,
  budget NUMERIC(10, 2) NOT NULL,
  traveler_count INTEGER NOT NULL CHECK (traveler_count > 0),
  preferences JSONB DEFAULT '[]'::jsonb,
  status TEXT DEFAULT 'planning' CHECK (status IN ('planning', 'active', 'completed', 'cancelled')),
  progress INTEGER DEFAULT 0 CHECK (progress >= 0 AND progress <= 100),
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Create itinerary_days table
CREATE TABLE itinerary_days (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  trip_id UUID NOT NULL REFERENCES trips(id) ON DELETE CASCADE,
  day_number INTEGER NOT NULL,
  title TEXT NOT NULL,
  date DATE,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  UNIQUE(trip_id, day_number)
);

-- Create checkpoints table
CREATE TABLE checkpoints (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  itinerary_day_id UUID NOT NULL REFERENCES itinerary_days(id) ON DELETE CASCADE,
  time TEXT NOT NULL,
  title TEXT NOT NULL,
  description TEXT NOT NULL,
  location_name TEXT,
  latitude NUMERIC(10, 8),
  longitude NUMERIC(11, 8),
  completed BOOLEAN DEFAULT false,
  sort_order INTEGER DEFAULT 0,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Create ai_chat_messages table
CREATE TABLE ai_chat_messages (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  user_id UUID NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
  role TEXT NOT NULL CHECK (role IN ('user', 'assistant')),
  content TEXT NOT NULL,
  metadata JSONB DEFAULT '{}'::jsonb,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Create traveler_profiles table (denormalized for search)
CREATE TABLE traveler_profiles (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  user_id UUID NOT NULL UNIQUE REFERENCES auth.users(id) ON DELETE CASCADE,
  display_name TEXT NOT NULL,
  avatar_url TEXT,
  country TEXT,
  bio TEXT,
  interests TEXT[] DEFAULT '{}',
  status TEXT DEFAULT 'available',
  distance TEXT,
  is_online BOOLEAN DEFAULT false,
  last_seen TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Create chat_rooms table
CREATE TABLE chat_rooms (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  last_message TEXT,
  last_message_at TIMESTAMP WITH TIME ZONE,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Create chat_room_members table
CREATE TABLE chat_room_members (
  room_id UUID NOT NULL REFERENCES chat_rooms(id) ON DELETE CASCADE,
  user_id UUID NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
  joined_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  PRIMARY KEY (room_id, user_id)
);

-- Create chat_messages table
CREATE TABLE chat_messages (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  room_id UUID NOT NULL REFERENCES chat_rooms(id) ON DELETE CASCADE,
  sender_id UUID NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
  text TEXT NOT NULL,
  type TEXT DEFAULT 'text' CHECK (type IN ('text', 'image', 'voice', 'video')),
  read_by UUID[] DEFAULT '{}',
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Create forum_posts table
CREATE TABLE forum_posts (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  user_id UUID NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
  destination TEXT NOT NULL,
  content TEXT NOT NULL,
  images TEXT[] DEFAULT '{}',
  likes_count INTEGER DEFAULT 0,
  comments_count INTEGER DEFAULT 0,
  views INTEGER DEFAULT 0,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Create forum_post_likes table
CREATE TABLE forum_post_likes (
  post_id UUID NOT NULL REFERENCES forum_posts(id) ON DELETE CASCADE,
  user_id UUID NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  PRIMARY KEY (post_id, user_id)
);

-- Create forum_comments table
CREATE TABLE forum_comments (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  post_id UUID NOT NULL REFERENCES forum_posts(id) ON DELETE CASCADE,
  user_id UUID NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
  content TEXT NOT NULL,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Create albums table
CREATE TABLE albums (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  user_id UUID NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
  trip_id UUID REFERENCES trips(id) ON DELETE SET NULL,
  title TEXT NOT NULL,
  description TEXT,
  cover_photo_url TEXT,
  photo_count INTEGER DEFAULT 0,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Create photos table
CREATE TABLE photos (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  user_id UUID NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
  album_id UUID REFERENCES albums(id) ON DELETE SET NULL,
  trip_id UUID REFERENCES trips(id) ON DELETE SET NULL,
  image_url TEXT NOT NULL,
  thumbnail_url TEXT,
  caption TEXT,
  likes_count INTEGER DEFAULT 0,
  metadata JSONB DEFAULT '{}'::jsonb,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Create photo_likes table
CREATE TABLE photo_likes (
  photo_id UUID NOT NULL REFERENCES photos(id) ON DELETE CASCADE,
  user_id UUID NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  PRIMARY KEY (photo_id, user_id)
);

-- Create emergency_contacts table
CREATE TABLE emergency_contacts (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  country TEXT NOT NULL,
  service_name TEXT NOT NULL,
  phone_number TEXT NOT NULL,
  type TEXT NOT NULL CHECK (type IN ('police', 'ambulance', 'fire', 'tourist')),
  description TEXT,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Create safety_tips table
CREATE TABLE safety_tips (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  country TEXT,
  title TEXT NOT NULL,
  content TEXT NOT NULL,
  category TEXT NOT NULL,
  icon TEXT,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Create quick_phrases table
CREATE TABLE quick_phrases (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  language TEXT NOT NULL,
  category TEXT,
  original_text TEXT NOT NULL,
  translated_text TEXT NOT NULL,
  pronunciation TEXT,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Create indexes
CREATE INDEX idx_trips_user_id ON trips(user_id);
CREATE INDEX idx_trips_destination ON trips(destination);
CREATE INDEX idx_trips_status ON trips(status);
CREATE INDEX idx_itinerary_days_trip_id ON itinerary_days(trip_id);
CREATE INDEX idx_checkpoints_itinerary_day_id ON checkpoints(itinerary_day_id);
CREATE INDEX idx_ai_chat_messages_user_id ON ai_chat_messages(user_id);
CREATE INDEX idx_traveler_profiles_country ON traveler_profiles(country);
CREATE INDEX idx_traveler_profiles_interests ON traveler_profiles USING GIN(interests);
CREATE INDEX idx_chat_messages_room_id ON chat_messages(room_id);
CREATE INDEX idx_chat_messages_created_at ON chat_messages(created_at);
CREATE INDEX idx_forum_posts_created_at ON forum_posts(created_at DESC);
CREATE INDEX idx_forum_posts_likes_count ON forum_posts(likes_count DESC);
CREATE INDEX idx_forum_posts_user_id ON forum_posts(user_id);
CREATE INDEX idx_albums_user_id ON albums(user_id);
CREATE INDEX idx_photos_album_id ON photos(album_id);
CREATE INDEX idx_photos_user_id ON photos(user_id);

-- Enable Row Level Security
ALTER TABLE profiles ENABLE ROW LEVEL SECURITY;
ALTER TABLE trips ENABLE ROW LEVEL SECURITY;
ALTER TABLE itinerary_days ENABLE ROW LEVEL SECURITY;
ALTER TABLE checkpoints ENABLE ROW LEVEL SECURITY;
ALTER TABLE ai_chat_messages ENABLE ROW LEVEL SECURITY;
ALTER TABLE traveler_profiles ENABLE ROW LEVEL SECURITY;
ALTER TABLE chat_rooms ENABLE ROW LEVEL SECURITY;
ALTER TABLE chat_room_members ENABLE ROW LEVEL SECURITY;
ALTER TABLE chat_messages ENABLE ROW LEVEL SECURITY;
ALTER TABLE forum_posts ENABLE ROW LEVEL SECURITY;
ALTER TABLE forum_post_likes ENABLE ROW LEVEL SECURITY;
ALTER TABLE forum_comments ENABLE ROW LEVEL SECURITY;
ALTER TABLE albums ENABLE ROW LEVEL SECURITY;
ALTER TABLE photos ENABLE ROW LEVEL SECURITY;
ALTER TABLE photo_likes ENABLE ROW LEVEL SECURITY;

-- RLS Policies for profiles
CREATE POLICY "Users can view all profiles" ON profiles FOR SELECT USING (true);
CREATE POLICY "Users can update own profile" ON profiles FOR UPDATE USING (auth.uid() = id);
CREATE POLICY "Users can insert own profile" ON profiles FOR INSERT WITH CHECK (auth.uid() = id);

-- RLS Policies for trips
CREATE POLICY "Users can view own trips" ON trips FOR SELECT USING (auth.uid() = user_id);
CREATE POLICY "Users can insert own trips" ON trips FOR INSERT WITH CHECK (auth.uid() = user_id);
CREATE POLICY "Users can update own trips" ON trips FOR UPDATE USING (auth.uid() = user_id);
CREATE POLICY "Users can delete own trips" ON trips FOR DELETE USING (auth.uid() = user_id);

-- RLS Policies for itinerary_days
CREATE POLICY "Users can view own itinerary days" ON itinerary_days FOR SELECT 
  USING (EXISTS (SELECT 1 FROM trips WHERE trips.id = itinerary_days.trip_id AND trips.user_id = auth.uid()));
CREATE POLICY "Users can insert own itinerary days" ON itinerary_days FOR INSERT 
  WITH CHECK (EXISTS (SELECT 1 FROM trips WHERE trips.id = itinerary_days.trip_id AND trips.user_id = auth.uid()));
CREATE POLICY "Users can update own itinerary days" ON itinerary_days FOR UPDATE 
  USING (EXISTS (SELECT 1 FROM trips WHERE trips.id = itinerary_days.trip_id AND trips.user_id = auth.uid()));
CREATE POLICY "Users can delete own itinerary days" ON itinerary_days FOR DELETE 
  USING (EXISTS (SELECT 1 FROM trips WHERE trips.id = itinerary_days.trip_id AND trips.user_id = auth.uid()));

-- RLS Policies for checkpoints
CREATE POLICY "Users can view own checkpoints" ON checkpoints FOR SELECT 
  USING (EXISTS (
    SELECT 1 FROM itinerary_days 
    JOIN trips ON trips.id = itinerary_days.trip_id 
    WHERE itinerary_days.id = checkpoints.itinerary_day_id AND trips.user_id = auth.uid()
  ));
CREATE POLICY "Users can insert own checkpoints" ON checkpoints FOR INSERT 
  WITH CHECK (EXISTS (
    SELECT 1 FROM itinerary_days 
    JOIN trips ON trips.id = itinerary_days.trip_id 
    WHERE itinerary_days.id = checkpoints.itinerary_day_id AND trips.user_id = auth.uid()
  ));
CREATE POLICY "Users can update own checkpoints" ON checkpoints FOR UPDATE 
  USING (EXISTS (
    SELECT 1 FROM itinerary_days 
    JOIN trips ON trips.id = itinerary_days.trip_id 
    WHERE itinerary_days.id = checkpoints.itinerary_day_id AND trips.user_id = auth.uid()
  ));
CREATE POLICY "Users can delete own checkpoints" ON checkpoints FOR DELETE 
  USING (EXISTS (
    SELECT 1 FROM itinerary_days 
    JOIN trips ON trips.id = itinerary_days.trip_id 
    WHERE itinerary_days.id = checkpoints.itinerary_day_id AND trips.user_id = auth.uid()
  ));

-- RLS Policies for ai_chat_messages
CREATE POLICY "Users can view own chat messages" ON ai_chat_messages FOR SELECT USING (auth.uid() = user_id);
CREATE POLICY "Users can insert own chat messages" ON ai_chat_messages FOR INSERT WITH CHECK (auth.uid() = user_id);
CREATE POLICY "Users can delete own chat messages" ON ai_chat_messages FOR DELETE USING (auth.uid() = user_id);

-- RLS Policies for traveler_profiles
CREATE POLICY "Authenticated users can view traveler profiles" ON traveler_profiles FOR SELECT USING (auth.role() = 'authenticated');
CREATE POLICY "Users can update own traveler profile" ON traveler_profiles FOR UPDATE USING (auth.uid() = user_id);
CREATE POLICY "Users can insert own traveler profile" ON traveler_profiles FOR INSERT WITH CHECK (auth.uid() = user_id);

-- RLS Policies for chat_rooms
CREATE POLICY "Users can view own chat rooms" ON chat_rooms FOR SELECT 
  USING (EXISTS (SELECT 1 FROM chat_room_members WHERE chat_room_members.room_id = chat_rooms.id AND chat_room_members.user_id = auth.uid()));

-- RLS Policies for chat_room_members
CREATE POLICY "Users can view own room memberships" ON chat_room_members FOR SELECT USING (auth.uid() = user_id);
CREATE POLICY "Users can insert room memberships" ON chat_room_members FOR INSERT WITH CHECK (auth.uid() = user_id);

-- RLS Policies for chat_messages
CREATE POLICY "Users can view messages in their rooms" ON chat_messages FOR SELECT 
  USING (EXISTS (SELECT 1 FROM chat_room_members WHERE chat_room_members.room_id = chat_messages.room_id AND chat_room_members.user_id = auth.uid()));
CREATE POLICY "Users can insert messages in their rooms" ON chat_messages FOR INSERT 
  WITH CHECK (EXISTS (SELECT 1 FROM chat_room_members WHERE chat_room_members.room_id = chat_messages.room_id AND chat_room_members.user_id = auth.uid()));

-- RLS Policies for forum_posts
CREATE POLICY "Authenticated users can view forum posts" ON forum_posts FOR SELECT USING (auth.role() = 'authenticated');
CREATE POLICY "Users can insert own forum posts" ON forum_posts FOR INSERT WITH CHECK (auth.uid() = user_id);
CREATE POLICY "Users can update own forum posts" ON forum_posts FOR UPDATE USING (auth.uid() = user_id);
CREATE POLICY "Users can delete own forum posts" ON forum_posts FOR DELETE USING (auth.uid() = user_id);

-- RLS Policies for forum_post_likes
CREATE POLICY "Authenticated users can view post likes" ON forum_post_likes FOR SELECT USING (auth.role() = 'authenticated');
CREATE POLICY "Users can insert own post likes" ON forum_post_likes FOR INSERT WITH CHECK (auth.uid() = user_id);
CREATE POLICY "Users can delete own post likes" ON forum_post_likes FOR DELETE USING (auth.uid() = user_id);

-- RLS Policies for forum_comments
CREATE POLICY "Authenticated users can view comments" ON forum_comments FOR SELECT USING (auth.role() = 'authenticated');
CREATE POLICY "Users can insert own comments" ON forum_comments FOR INSERT WITH CHECK (auth.uid() = user_id);
CREATE POLICY "Users can delete own comments" ON forum_comments FOR DELETE USING (auth.uid() = user_id);

-- RLS Policies for albums
CREATE POLICY "Users can view own albums" ON albums FOR SELECT USING (auth.uid() = user_id);
CREATE POLICY "Users can insert own albums" ON albums FOR INSERT WITH CHECK (auth.uid() = user_id);
CREATE POLICY "Users can update own albums" ON albums FOR UPDATE USING (auth.uid() = user_id);
CREATE POLICY "Users can delete own albums" ON albums FOR DELETE USING (auth.uid() = user_id);

-- RLS Policies for photos
CREATE POLICY "Users can view own photos" ON photos FOR SELECT USING (auth.uid() = user_id);
CREATE POLICY "Users can insert own photos" ON photos FOR INSERT WITH CHECK (auth.uid() = user_id);
CREATE POLICY "Users can update own photos" ON photos FOR UPDATE USING (auth.uid() = user_id);
CREATE POLICY "Users can delete own photos" ON photos FOR DELETE USING (auth.uid() = user_id);

-- RLS Policies for photo_likes
CREATE POLICY "Authenticated users can view photo likes" ON photo_likes FOR SELECT USING (auth.role() = 'authenticated');
CREATE POLICY "Users can insert own photo likes" ON photo_likes FOR INSERT WITH CHECK (auth.uid() = user_id);
CREATE POLICY "Users can delete own photo likes" ON photo_likes FOR DELETE USING (auth.uid() = user_id);

-- Public read policies for emergency data
ALTER TABLE emergency_contacts ENABLE ROW LEVEL SECURITY;
ALTER TABLE safety_tips ENABLE ROW LEVEL SECURITY;
ALTER TABLE quick_phrases ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Anyone can view emergency contacts" ON emergency_contacts FOR SELECT USING (true);
CREATE POLICY "Anyone can view safety tips" ON safety_tips FOR SELECT USING (true);
CREATE POLICY "Anyone can view quick phrases" ON quick_phrases FOR SELECT USING (true);

-- Create function to automatically create profile on user signup
CREATE OR REPLACE FUNCTION public.handle_new_user()
RETURNS TRIGGER AS $$
BEGIN
  INSERT INTO public.profiles (id, full_name, avatar_url)
  VALUES (
    NEW.id,
    COALESCE(NEW.raw_user_meta_data->>'full_name', NEW.email),
    COALESCE(NEW.raw_user_meta_data->>'avatar_url', '')
  );
  
  INSERT INTO public.traveler_profiles (user_id, display_name, avatar_url)
  VALUES (
    NEW.id,
    COALESCE(NEW.raw_user_meta_data->>'full_name', NEW.email),
    COALESCE(NEW.raw_user_meta_data->>'avatar_url', '')
  );
  
  RETURN NEW;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- Trigger to create profile on signup
CREATE TRIGGER on_auth_user_created
  AFTER INSERT ON auth.users
  FOR EACH ROW EXECUTE FUNCTION public.handle_new_user();

-- Create function to update updated_at timestamp
CREATE OR REPLACE FUNCTION update_updated_at_column()
RETURNS TRIGGER AS $$
BEGIN
  NEW.updated_at = NOW();
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Add triggers for updated_at
CREATE TRIGGER update_profiles_updated_at BEFORE UPDATE ON profiles FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();
CREATE TRIGGER update_trips_updated_at BEFORE UPDATE ON trips FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();
CREATE TRIGGER update_checkpoints_updated_at BEFORE UPDATE ON checkpoints FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();
CREATE TRIGGER update_traveler_profiles_updated_at BEFORE UPDATE ON traveler_profiles FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();
CREATE TRIGGER update_chat_rooms_updated_at BEFORE UPDATE ON chat_rooms FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();
CREATE TRIGGER update_forum_posts_updated_at BEFORE UPDATE ON forum_posts FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();
CREATE TRIGGER update_albums_updated_at BEFORE UPDATE ON albums FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();
