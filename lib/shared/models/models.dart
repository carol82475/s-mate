// Shared data models

class ItineraryDay {
  final int day;
  String title;
  final List<Checkpoint> checkpoints;

  ItineraryDay({
    required this.day,
    required this.title,
    required this.checkpoints,
  });
}

class Checkpoint {
  String time;
  String title;
  String description;
  bool completed;

  Checkpoint({
    required this.time,
    required this.title,
    required this.description,
    this.completed = false,
  });
}

// Local fallback itinerary template.
// Used only when previewing a new itinerary before backend data exists.
class MockData {
  static List<ItineraryDay> get itineraryDays => [
        ItineraryDay(
          day: 1,
          title: 'Arrival & Local Discovery',
          checkpoints: [
            Checkpoint(
              time: '09:00',
              title: 'City Landmark Visit',
              description: 'Start your trip with a famous local landmark.',
            ),
            Checkpoint(
              time: '12:00',
              title: 'Local Food Experience',
              description: 'Try authentic local food near the city center.',
            ),
            Checkpoint(
              time: '15:00',
              title: 'Cultural Site',
              description: 'Visit a museum, temple, or cultural destination.',
            ),
            Checkpoint(
              time: '18:00',
              title: 'Evening Walk',
              description: 'Enjoy the city atmosphere in the evening.',
            ),
          ],
        ),
        ItineraryDay(
          day: 2,
          title: 'Adventure & Exploration',
          checkpoints: [
            Checkpoint(
              time: '08:00',
              title: 'Morning Excursion',
              description: 'Take a short trip to a nearby attraction.',
            ),
            Checkpoint(
              time: '12:00',
              title: 'Lunch Break',
              description: 'Recharge with a recommended local restaurant.',
            ),
            Checkpoint(
              time: '15:00',
              title: 'Outdoor Activity',
              description: 'Explore nature, markets, or hidden gems.',
            ),
            Checkpoint(
              time: '19:00',
              title: 'Dinner & Relaxation',
              description: 'End your day with a relaxing dinner.',
            ),
          ],
        ),
        ItineraryDay(
          day: 3,
          title: 'Relaxed Final Day',
          checkpoints: [
            Checkpoint(
              time: '09:00',
              title: 'Slow Morning',
              description: 'Enjoy a slower start with coffee or breakfast.',
            ),
            Checkpoint(
              time: '11:00',
              title: 'Souvenir Shopping',
              description: 'Buy souvenirs or visit a local market.',
            ),
            Checkpoint(
              time: '15:00',
              title: 'Final Photo Spot',
              description: 'Capture final memories before leaving.',
            ),
          ],
        ),
      ];
}