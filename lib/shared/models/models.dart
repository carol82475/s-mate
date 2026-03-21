// Shared data models

class Traveler {
  final String id;
  final String name;
  final String country;
  final String distance;
  final List<String> interests;
  final String status;

  const Traveler({
    required this.id,
    required this.name,
    required this.country,
    required this.distance,
    required this.interests,
    required this.status,
  });
}

class ChatMessage {
  final String id;
  final String senderId;
  final String text;
  final DateTime timestamp;
  final bool isOwn;

  const ChatMessage({
    required this.id,
    required this.senderId,
    required this.text,
    required this.timestamp,
    required this.isOwn,
  });
}

class ItineraryDay {
  final int day;
  final String title;
  final List<Checkpoint> checkpoints;

  ItineraryDay({required this.day, required this.title, required this.checkpoints});
}

class Checkpoint {
  final String time;
  final String title;
  final String description;
  bool completed;

  Checkpoint({
    required this.time,
    required this.title,
    required this.description,
    this.completed = false,
  });
}

class ForumPost {
  final String id;
  final String userName;
  final String userLocation;
  final String destination;
  final String dates;
  final String content;
  int likes;
  int comments;
  final String timestamp;

  ForumPost({
    required this.id,
    required this.userName,
    required this.userLocation,
    required this.destination,
    required this.dates,
    required this.content,
    required this.likes,
    required this.comments,
    required this.timestamp,
  });
}

// Mock data
class MockData {
  static final List<Traveler> travelers = [
    const Traveler(id: '1', name: 'Sarah Johnson', country: 'USA', distance: '0.3 km away', interests: ['Food', 'Culture', 'Photography'], status: 'Exploring Old Quarter'),
    const Traveler(id: '2', name: 'Thomas Müller', country: 'Germany', distance: '0.8 km away', interests: ['History', 'Architecture', 'Hiking'], status: 'At Hoan Kiem Lake'),
    const Traveler(id: '3', name: 'Yuki Tanaka', country: 'Japan', distance: '1.2 km away', interests: ['Food', 'Art', 'Shopping'], status: 'Having coffee nearby'),
    const Traveler(id: '4', name: 'Emma Wilson', country: 'UK', distance: '1.5 km away', interests: ['Adventure', 'Nature', 'Local Culture'], status: 'Planning trip to Sapa'),
    const Traveler(id: '5', name: 'Carlos Rodriguez', country: 'Spain', distance: '2.1 km away', interests: ['Food', 'Nightlife', 'Beach'], status: 'Looking for dinner spot'),
  ];

  static List<ForumPost> get forumPosts => [
    ForumPost(id: '1', userName: 'Sarah Anderson', userLocation: 'New York, USA', destination: 'Japan Cherry Blossom', dates: 'Apr 1 - Apr 10, 2025', content: 'Just completed an amazing 10-day trip through Japan! The cherry blossoms were in full bloom and every location was breathtaking. Would highly recommend visiting Kyoto and Tokyo during this season. 🌸', likes: 124, comments: 23, timestamp: '2 hours ago'),
    ForumPost(id: '2', userName: 'Michael Chen', userLocation: 'Singapore', destination: 'Thailand Adventure', dates: 'Jan 15 - Jan 22, 2026', content: 'Thailand never disappoints! From the bustling streets of Bangkok to the peaceful beaches of Phuket. The food was incredible and the people were so welcoming. Already planning my next trip!', likes: 98, comments: 15, timestamp: '5 hours ago'),
    ForumPost(id: '3', userName: 'Emma Rodriguez', userLocation: 'Barcelona, Spain', destination: 'Northern Vietnam', dates: 'Dec 10 - Dec 20, 2025', content: 'Vietnam stole my heart! Ha Long Bay was like something out of a dream, and the food in Hanoi was absolutely delicious. Don\'t miss the night markets and street food tours! 🇻🇳', likes: 156, comments: 31, timestamp: '1 day ago'),
  ];

  static List<ItineraryDay> get itineraryDays => [
    ItineraryDay(day: 1, title: 'Arrival in Hanoi', checkpoints: [
      Checkpoint(time: '09:00', title: 'Hoan Kiem Lake', description: 'Morning walk around the iconic lake', completed: true),
      Checkpoint(time: '12:00', title: 'Old Quarter Food Tour', description: 'Try authentic Vietnamese cuisine', completed: true),
      Checkpoint(time: '15:00', title: 'Temple of Literature', description: 'Visit Vietnam\'s first university'),
      Checkpoint(time: '18:00', title: 'Water Puppet Show', description: 'Traditional Vietnamese performance'),
    ]),
    ItineraryDay(day: 2, title: 'Ha Long Bay Cruise', checkpoints: [
      Checkpoint(time: '08:00', title: 'Depart for Ha Long Bay', description: '3-hour drive from Hanoi'),
      Checkpoint(time: '12:00', title: 'Board Cruise Ship', description: 'Welcome lunch on board'),
      Checkpoint(time: '15:00', title: 'Kayaking Adventure', description: 'Explore limestone caves'),
      Checkpoint(time: '19:00', title: 'Sunset Dinner', description: 'Fresh seafood on deck'),
    ]),
    ItineraryDay(day: 3, title: 'Sapa Highlands', checkpoints: [
      Checkpoint(time: '07:00', title: 'Rice Terrace Trek', description: 'Hiking through stunning landscapes'),
      Checkpoint(time: '12:00', title: 'Local Village Visit', description: 'Meet ethnic minority communities'),
      Checkpoint(time: '16:00', title: 'Cat Cat Waterfall', description: 'Scenic waterfall viewpoint'),
    ]),
  ];
}
