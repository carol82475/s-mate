import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../core/theme.dart';
import '../../l10n/app_localizations.dart';

class MainScaffold extends StatelessWidget {
  final Widget child;

  const MainScaffold({super.key, required this.child});

  int _locationToIndex(String location) {
    if (location.startsWith('/home')) return 0;
    if (location.startsWith('/my-trips')) return 1;
    if (location.startsWith('/itinerary')) return 1;
    if (location.startsWith('/scan')) return 2;
    if (location.startsWith('/map')) return 3;
    if (location.startsWith('/ai-chat')) return 4;

    // Secondary routes map to their logical parent tab.
    if (location.startsWith('/trip-planner')) return 0;
    if (location.startsWith('/trip-camera')) return 2;
    if (location.startsWith('/profile')) return 0;
    if (location.startsWith('/quick-action')) return 2;
    if (location.startsWith('/purchase')) return 0;
    return 0;
  }

  void _onTabTapped(BuildContext context, int index) {
    switch (index) {
      case 0:
        context.go('/home');
        break;
      case 1:
        context.go('/my-trips');
        break;
      case 2:
        context.go('/scan');
        break;
      case 3:
        context.go('/map');
        break;
      case 4:
        context.go('/ai-chat');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final location = GoRouterState.of(context).uri.toString();
    final currentIndex = _locationToIndex(location);
    final l10n = AppLocalizations.of(context);

    return Scaffold(
      body: child,
      bottomNavigationBar: NavigationBar(
        selectedIndex: currentIndex,
        onDestinationSelected: (i) => _onTabTapped(context, i),
        backgroundColor: AppTheme.cardBg,
        indicatorColor: AppTheme.primary.withValues(alpha: 0.15),
        labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
        destinations: [
          NavigationDestination(
            icon: const Icon(Icons.home_outlined),
            selectedIcon: const Icon(Icons.home, color: AppTheme.primary),
            label: l10n.home,
          ),
          NavigationDestination(
            icon: const Icon(Icons.calendar_today_outlined),
            selectedIcon:
                const Icon(Icons.calendar_today, color: AppTheme.primary),
            label: l10n.myTrip,
          ),
          NavigationDestination(
            icon: const Icon(Icons.document_scanner_outlined),
            selectedIcon: const Icon(
              Icons.document_scanner,
              color: AppTheme.primary,
            ),
            label: l10n.scan,
          ),
          NavigationDestination(
            icon: const Icon(Icons.map_outlined),
            selectedIcon: const Icon(Icons.map, color: AppTheme.primary),
            label: l10n.map,
          ),
          NavigationDestination(
            icon: const Icon(Icons.chat_bubble_outline),
            selectedIcon:
                const Icon(Icons.chat_bubble, color: AppTheme.primary),
            label: l10n.aiChat,
          ),
        ],
      ),
    );
  }
}

