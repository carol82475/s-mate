import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../core/api_client.dart';
import '../../core/theme.dart';
import '../../shared/widgets/app_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _notificationCount = 3;

  bool _isLoading = true;

  Map<String, dynamic>? _currentTrip;
  List<Map<String, dynamic>> _quickActions = [];
  List<Map<String, dynamic>> _popularDestinations = [];

  @override
  void initState() {
    super.initState();
    _loadHomeData();
  }

  Future<void> _loadHomeData() async {
    try {
      setState(() => _isLoading = true);

      await Future.wait([
        _loadQuickActions(),
        _loadTrips(),
      ]);

      _popularDestinations = [
        {
          'title': 'Ha Long Bay',
          'location': 'Vietnam',
          'imageUrl':
              'https://images.unsplash.com/photo-1737484126640-7381808c768b?w=400',
        },
        {
          'title': 'Ho Chi Minh City',
          'location': 'Vietnam',
          'imageUrl':
              'https://images.unsplash.com/photo-1541079606130-1f46216e419d?w=400',
        },
        {
          'title': 'Hoi An',
          'location': 'Vietnam',
          'imageUrl':
              'https://images.unsplash.com/photo-1643030080539-b411caf44c37?w=400',
        },
      ];
    } catch (e) {
      debugPrint('LOAD HOME ERROR: $e');

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(e.toString()),
            backgroundColor: AppTheme.destructive,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  Future<void> _loadQuickActions() async {
    try {
      final response = await ApiClient.get('/quick-actions');
      final data = response['data'];

      if (data is List) {
        _quickActions = data
            .map<Map<String, dynamic>>(
              (item) => item as Map<String, dynamic>,
            )
            .toList();
      }
    } catch (_) {
      _quickActions = [];
    }
  }

  Future<void> _loadTrips() async {
    try {
      final response = await ApiClient.get('/trips?page=1&limit=1');
      final data = response['data'];

      if (data is List && data.isNotEmpty) {
        _currentTrip = data.first as Map<String, dynamic>;
      }
    } catch (_) {
      _currentTrip = null;
    }
  }

  void _showNotifications() {
    setState(() => _notificationCount = 0);

    showModalBottomSheet(
      context: context,
      backgroundColor: AppTheme.cardBg,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
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
                  const Text(
                    'Notifications',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Close'),
                  ),
                ],
              ),
            ),
            const Divider(height: 1),
            Expanded(
              child: ListView(
                controller: ctrl,
                padding: const EdgeInsets.all(16),
                children: const [
                  _NotificationItem(
                    icon: Icons.calendar_today,
                    title: 'Itinerary Reminder',
                    body: 'Your next activity is coming soon.',
                    time: '2h ago',
                  ),
                  _NotificationItem(
                    icon: Icons.people,
                    title: 'New Traveler Nearby',
                    body: 'Someone is looking for travel buddies.',
                    time: '4h ago',
                  ),
                  _NotificationItem(
                    icon: Icons.forum,
                    title: 'Forum Reply',
                    body: 'Someone replied to your travel post.',
                    time: '1d ago',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _tripId() {
    return _currentTrip?['id']?.toString() ?? 'new';
  }

  String _tripTitle() {
    return _currentTrip?['title']?.toString() ??
        _currentTrip?['destination']?.toString() ??
        'Plan Your First Trip';
  }

  String _tripLocation() {
    return _currentTrip?['destination']?.toString() ??
        _currentTrip?['location']?.toString() ??
        'Choose your destination';
  }

  String _tripStatus() {
    return _currentTrip?['status']?.toString() ?? 'New';
  }

  String _tripImage() {
    return _currentTrip?['image_url']?.toString() ??
        _currentTrip?['imageUrl']?.toString() ??
        'https://images.unsplash.com/photo-1727860628226-2d545134f8a9?w=800';
  }

  List<_QuickActionData> get _fallbackQuickActions {
    return [
      _QuickActionData(
        icon: Icons.camera_alt_outlined,
        label: 'Camera',
        route: '/trip-camera',
      ),
      _QuickActionData(
        icon: Icons.photo_library_outlined,
        label: 'Albums',
        route: '/trip-albums',
      ),
      _QuickActionData(
        icon: Icons.shield_outlined,
        label: 'Safety',
        route: '/quick-action',
      ),
      _QuickActionData(
        icon: Icons.forum_outlined,
        label: 'Forum',
        route: '/forum',
      ),
    ];
  }

  List<_QuickActionData> get _resolvedQuickActions {
    if (_quickActions.isEmpty) return _fallbackQuickActions;

    final actions = _quickActions.map((item) {
      return _QuickActionData(
        icon: _iconFromName(item['icon']?.toString()),
        label: item['label']?.toString() ??
            item['title']?.toString() ??
            'Action',
        route: _normalizeRoute(
          item['route']?.toString() ??
              item['path']?.toString() ??
              '/home',
        ),
      );
    }).toList();

    if (!actions.any((action) => action.route == '/trip-camera')) {
      actions.insert(0, _fallbackQuickActions.first);
    }

    return actions.take(4).toList();
  }

  String _normalizeRoute(String route) {
    switch (route) {
      case '/camera':
      case '/tripCamera':
      case '/trip-camera/':
        return '/trip-camera';
      default:
        return route;
    }
  }

  IconData _iconFromName(String? name) {
    switch (name) {
      case 'camera':
      case 'camera_alt':
        return Icons.camera_alt_outlined;
      case 'album':
      case 'photo':
      case 'photo_library':
        return Icons.photo_library_outlined;
      case 'safety':
      case 'shield':
        return Icons.shield_outlined;
      case 'forum':
        return Icons.forum_outlined;
      case 'map':
        return Icons.map_outlined;
      case 'chat':
        return Icons.chat_bubble_outline;
      default:
        return Icons.apps_outlined;
    }
  }

  @override
  Widget build(BuildContext context) {
    final quickActions = _resolvedQuickActions;

    return Scaffold(
      backgroundColor: AppTheme.background,
      appBar: AppBar(
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Welcome back, Traveler!',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text(
              'Plan your next adventure',
              style: TextStyle(
                fontSize: 12,
                color: AppTheme.textMuted,
                fontWeight: FontWeight.normal,
              ),
            ),
          ],
        ),
        actions: [
          Stack(
            children: [
              IconButton(
                icon: const Icon(Icons.notifications_outlined),
                onPressed: _showNotifications,
              ),
              if (_notificationCount > 0)
                Positioned(
                  right: 8,
                  top: 8,
                  child: Container(
                    width: 16,
                    height: 16,
                    decoration: const BoxDecoration(
                      color: AppTheme.destructive,
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Text(
                        '$_notificationCount',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
            ],
          ),
          IconButton(
            icon: const Icon(Icons.person_outline),
            onPressed: () => context.go('/profile'),
          ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : RefreshIndicator(
              onRefresh: _loadHomeData,
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: quickActions
                          .map(
                            (action) => _QuickActionChip(
                              icon: action.icon,
                              label: action.label,
                              onTap: () => context.go(action.route),
                            ),
                          )
                          .toList(),
                    ),
                    const SizedBox(height: 24),
                    SectionHeader(
                      title: 'Current Trip',
                      actionLabel: 'View Details',
                      onAction: () => context.go('/itinerary/${_tripId()}'),
                    ),
                    const SizedBox(height: 12),
                    AppCard(
                      padding: EdgeInsets.zero,
                      onTap: () => context.go('/itinerary/${_tripId()}'),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius: const BorderRadius.vertical(
                              top: Radius.circular(16),
                            ),
                            child: Stack(
                              children: [
                                Image.network(
                                  _tripImage(),
                                  height: 180,
                                  width: double.infinity,
                                  fit: BoxFit.cover,
                                  errorBuilder: (_, __, ___) => Container(
                                    height: 180,
                                    color: AppTheme.accent,
                                    child: const Icon(
                                      Icons.landscape,
                                      size: 64,
                                      color: AppTheme.primary,
                                    ),
                                  ),
                                ),
                                Positioned(
                                  top: 12,
                                  right: 12,
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 12,
                                      vertical: 6,
                                    ),
                                    decoration: BoxDecoration(
                                      color: AppTheme.primary,
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Text(
                                      _tripStatus(),
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
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
                                Text(
                                  _tripTitle(),
                                  style: const TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Row(
                                  children: [
                                    const Icon(
                                      Icons.location_on_outlined,
                                      size: 14,
                                      color: AppTheme.textMuted,
                                    ),
                                    const SizedBox(width: 4),
                                    Expanded(
                                      child: Text(
                                        _tripLocation(),
                                        style: const TextStyle(
                                          fontSize: 13,
                                          color: AppTheme.textMuted,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 12),
                                Row(
                                  children: [
                                    Expanded(
                                      child: ElevatedButton(
                                        onPressed: () => context.go(
                                          '/itinerary/${_tripId()}',
                                        ),
                                        child: Text(
                                          _currentTrip == null
                                              ? 'Create Trip'
                                              : 'View Itinerary',
                                        ),
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
                        children: _popularDestinations
                            .map(
                              (item) => _DestinationCard(
                                imageUrl: item['imageUrl'].toString(),
                                title: item['title'].toString(),
                                location: item['location'].toString(),
                              ),
                            )
                            .toList(),
                      ),
                    ),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
    );
  }
}

class _QuickActionData {
  final IconData icon;
  final String label;
  final String route;

  const _QuickActionData({
    required this.icon,
    required this.label,
    required this.route,
  });
}

class _NotificationItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String body;
  final String time;

  const _NotificationItem({
    required this.icon,
    required this.title,
    required this.body,
    required this.time,
  });

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
            decoration: BoxDecoration(
              color: AppTheme.primary.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: AppTheme.primary, size: 18),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  body,
                  style: const TextStyle(
                    fontSize: 12,
                    color: AppTheme.textMuted,
                  ),
                ),
              ],
            ),
          ),
          Text(
            time,
            style: const TextStyle(fontSize: 11, color: AppTheme.textMuted),
          ),
        ],
      ),
    );
  }
}

class _QuickActionChip extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _QuickActionChip({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          margin: const EdgeInsets.only(right: 8),
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
              Text(
                label,
                style: const TextStyle(
                  fontSize: 10,
                  color: AppTheme.textMuted,
                ),
              ),
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

  const _DestinationCard({
    required this.imageUrl,
    required this.title,
    required this.location,
  });

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
              errorBuilder: (_, __, ___) => Container(
                color: AppTheme.accent,
                child: const Icon(
                  Icons.landscape,
                  color: AppTheme.primary,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  location,
                  style: const TextStyle(
                    fontSize: 11,
                    color: AppTheme.textMuted,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
