import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/theme.dart';
import '../../shared/widgets/app_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _notificationCount = 3;

  void _showNotifications() {
    setState(() => _notificationCount = 0);
    showModalBottomSheet(
      context: context,
      backgroundColor: AppTheme.cardBg,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (_) => DraggableScrollableSheet(
        expand: false,
        initialChildSize: 0.5,
        builder: (_, ctrl) => Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Notifications', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  TextButton(onPressed: () => Navigator.pop(context), child: const Text('Close')),
                ],
              ),
            ),
            const Divider(height: 1),
            Expanded(
              child: ListView(
                controller: ctrl,
                padding: const EdgeInsets.all(16),
                children: const [
                  _NotificationItem(icon: Icons.calendar_today, title: 'Itinerary Reminder', body: 'Day 2 starts tomorrow — Ha Long Bay cruise!', time: '2h ago'),
                  _NotificationItem(icon: Icons.people, title: 'New Traveler Nearby', body: 'Sarah from Canada is 0.5 km away', time: '4h ago'),
                  _NotificationItem(icon: Icons.forum, title: 'Forum Reply', body: 'Someone replied to your Vietnam post', time: '1d ago'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,
      appBar: AppBar(
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Welcome back, Traveler!', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            Text('Plan your next adventure', style: TextStyle(fontSize: 12, color: AppTheme.textMuted, fontWeight: FontWeight.normal)),
          ],
        ),
        actions: [
          Stack(
            children: [
              IconButton(icon: const Icon(Icons.notifications_outlined), onPressed: _showNotifications),
              if (_notificationCount > 0)
                Positioned(
                  right: 8, top: 8,
                  child: Container(
                    width: 16, height: 16,
                    decoration: const BoxDecoration(color: AppTheme.destructive, shape: BoxShape.circle),
                    child: Center(
                      child: Text('$_notificationCount', style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold)),
                    ),
                  ),
                ),
            ],
          ),
          IconButton(icon: const Icon(Icons.person_outline), onPressed: () => context.go('/profile')),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Quick actions row
            Row(
              children: [
                _QuickActionChip(icon: Icons.camera_alt_outlined, label: 'Camera', onTap: () => context.go('/trip-camera')),
                const SizedBox(width: 8),
                _QuickActionChip(icon: Icons.photo_library_outlined, label: 'Albums', onTap: () => context.go('/trip-albums')),
                const SizedBox(width: 8),
                _QuickActionChip(icon: Icons.shield_outlined, label: 'Safety', onTap: () => context.go('/quick-action')),
                const SizedBox(width: 8),
                _QuickActionChip(icon: Icons.forum_outlined, label: 'Forum', onTap: () => context.go('/forum')),
              ],
            ),
            const SizedBox(height: 24),
            // Current trip
            SectionHeader(title: 'Current Trip', actionLabel: 'View Details', onAction: () => context.go('/itinerary/1')),
            const SizedBox(height: 12),
            AppCard(
              padding: EdgeInsets.zero,
              onTap: () => context.go('/itinerary/1'),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                    child: Stack(
                      children: [
                        Image.network(
                          'https://images.unsplash.com/photo-1727860628226-2d545134f8a9?w=800',
                          height: 180,
                          width: double.infinity,
                          fit: BoxFit.cover,
                          errorBuilder: (_, __, ___) => Container(height: 180, color: AppTheme.accent, child: const Icon(Icons.landscape, size: 64, color: AppTheme.primary)),
                        ),
                        Positioned(
                          top: 12, right: 12,
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                            decoration: BoxDecoration(color: AppTheme.primary, borderRadius: BorderRadius.circular(20)),
                            child: const Text('In Progress', style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w600)),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Exploring Northern Vietnam', style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            const Icon(Icons.location_on_outlined, size: 14, color: AppTheme.textMuted),
                            const SizedBox(width: 4),
                            const Text('Hanoi, Ha Long Bay', style: TextStyle(fontSize: 13, color: AppTheme.textMuted)),
                            const SizedBox(width: 16),
                            const Icon(Icons.access_time, size: 14, color: AppTheme.textMuted),
                            const SizedBox(width: 4),
                            const Text('5 days remaining', style: TextStyle(fontSize: 13, color: AppTheme.textMuted)),
                          ],
                        ),
                        const SizedBox(height: 12),
                        Row(
                          children: [
                            Expanded(
                              child: ElevatedButton(
                                onPressed: () => context.go('/itinerary/1'),
                                child: const Text('View Itinerary'),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: OutlinedButton(
                                onPressed: () => context.go('/map'),
                                child: const Text('Open Map'),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            const SectionHeader(title: 'Popular Destinations'),
            const SizedBox(height: 12),
            SizedBox(
              height: 200,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: const [
                  _DestinationCard(
                    imageUrl: 'https://images.unsplash.com/photo-1737484126640-7381808c768b?w=400',
                    title: 'Ha Long Bay',
                    location: 'Vietnam',
                  ),
                  _DestinationCard(
                    imageUrl: 'https://images.unsplash.com/photo-1541079606130-1f46216e419d?w=400',
                    title: 'Ho Chi Minh City',
                    location: 'Vietnam',
                  ),
                  _DestinationCard(
                    imageUrl: 'https://images.unsplash.com/photo-1643030080539-b411caf44c37?w=400',
                    title: 'Hoi An',
                    location: 'Vietnam',
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}

class _NotificationItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String body;
  final String time;

  const _NotificationItem({required this.icon, required this.title, required this.body, required this.time});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppTheme.accent.withOpacity(0.3),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppTheme.border),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(color: AppTheme.primary.withOpacity(0.1), borderRadius: BorderRadius.circular(8)),
            child: Icon(icon, color: AppTheme.primary, size: 18),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
                const SizedBox(height: 2),
                Text(body, style: const TextStyle(fontSize: 12, color: AppTheme.textMuted)),
              ],
            ),
          ),
          Text(time, style: const TextStyle(fontSize: 11, color: AppTheme.textMuted)),
        ],
      ),
    );
  }
}

class _QuickActionChip extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _QuickActionChip({required this.icon, required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            color: AppTheme.cardBg,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppTheme.border),
          ),
          child: Column(
            children: [
              Icon(icon, color: AppTheme.primary, size: 22),
              const SizedBox(height: 4),
              Text(label, style: const TextStyle(fontSize: 10, color: AppTheme.textMuted)),
            ],
          ),
        ),
      ),
    );
  }
}

class _DestinationCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String location;

  const _DestinationCard({required this.imageUrl, required this.title, required this.location});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      margin: const EdgeInsets.only(right: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppTheme.border),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Image.network(
              imageUrl,
              width: double.infinity,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => Container(color: AppTheme.accent, child: const Icon(Icons.landscape, color: AppTheme.primary)),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600), maxLines: 1, overflow: TextOverflow.ellipsis),
                Text(location, style: const TextStyle(fontSize: 11, color: AppTheme.textMuted)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
