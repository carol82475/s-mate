import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/theme.dart';

class MainScaffold extends StatelessWidget {
  final Widget child;
  const MainScaffold({super.key, required this.child});

  int _locationToIndex(String location) {
    if (location.startsWith('/home')) return 0;
    if (location.startsWith('/itinerary')) return 1;
    if (location.startsWith('/trip-planner')) return 2;
    if (location.startsWith('/map')) return 3;
    if (location.startsWith('/ai-chat')) return 4;
    if (location.startsWith('/find-travelers') || location.startsWith('/traveler-chat')) return 5;

    // Secondary routes — map to their logical parent tab
    if (location.startsWith('/forum')) return 0;
    if (location.startsWith('/trip-camera')) return 0;
    if (location.startsWith('/trip-albums')) return 0;
    if (location.startsWith('/profile')) return 0;
    if (location.startsWith('/quick-action')) return 0;
    if (location.startsWith('/antiscam')) return 0;
    return 0;
  }

  void _onTabTapped(BuildContext context, int index) {
    switch (index) {
      case 0: context.go('/home'); break;
      case 1: context.go('/itinerary/1'); break; // Go to current trip (ID 1)
      case 2: context.go('/trip-planner'); break;
      case 3: context.go('/map'); break;
      case 4: context.go('/ai-chat'); break;
      case 5: context.go('/find-travelers'); break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final location = GoRouterState.of(context).uri.toString();
    final currentIndex = _locationToIndex(location);

    return Scaffold(
      body: child,
      bottomNavigationBar: NavigationBar(
        selectedIndex: currentIndex,
        onDestinationSelected: (i) => _onTabTapped(context, i),
        backgroundColor: AppTheme.cardBg,
        indicatorColor: AppTheme.primary.withOpacity(0.15),
        labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home, color: AppTheme.primary),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.auto_awesome_outlined),
            selectedIcon: Icon(Icons.auto_awesome, color: AppTheme.primary),
            label: 'My Trip',
          ),
          NavigationDestination(
            icon: Icon(Icons.calendar_today_outlined),
            selectedIcon: Icon(Icons.calendar_today, color: AppTheme.primary),
            label: 'Planner',
          ),
          NavigationDestination(
            icon: Icon(Icons.map_outlined),
            selectedIcon: Icon(Icons.map, color: AppTheme.primary),
            label: 'Map',
          ),
          NavigationDestination(
            icon: Icon(Icons.chat_bubble_outline),
            selectedIcon: Icon(Icons.chat_bubble, color: AppTheme.primary),
            label: 'AI Chat',
          ),
          NavigationDestination(
            icon: Icon(Icons.people_outline),
            selectedIcon: Icon(Icons.people, color: AppTheme.primary),
            label: 'Travelers',
          ),
        ],
      ),
    );
  }
}
