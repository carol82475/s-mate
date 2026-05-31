import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

import '../features/intro/intro_screen.dart';
import '../features/auth/login_screen.dart';
import '../features/home/home_screen.dart';
import '../features/trip_planner/trip_planner_screen.dart';
import '../features/itinerary/itinerary_screen.dart';
import '../features/my_trips/my_trips_screen.dart';
import '../features/map/map_screen.dart';
import '../features/ai_chat/ai_chat_screen.dart';
import '../features/scan/scan_screen.dart';
import '../features/camera/trip_camera_screen.dart';
import '../features/albums/trip_albums_screen.dart';
import '../features/profile/profile_screen.dart';
import '../features/purchase/purchase_screen.dart';
import '../features/quick_action/quick_action_screen.dart';
import '../shared/widgets/main_scaffold.dart';
import 'api_client.dart';

const _publicRoutes = {'/', '/login'};

final GoRouter appRouter = GoRouter(
  initialLocation: '/',
  refreshListenable: ApiAuth.instance,
  redirect: (context, state) {
    final isLoggedIn = ApiAuth.instance.isLoggedIn;

    final location = state.uri.path;
    final isPublicRoute = _publicRoutes.contains(location);

    if (!isLoggedIn && !isPublicRoute) {
      return '/';
    }

    if (isLoggedIn && isPublicRoute) {
      return '/home';
    }

    return null;
  },
  errorBuilder: (context, state) => const _RouteFallback(),
  routes: [
    GoRoute(
      path: '/',
      builder: (_, __) => const IntroScreen(),
    ),
    GoRoute(
      path: '/login',
      builder: (_, __) => const LoginScreen(),
    ),
    ShellRoute(
      builder: (context, state, child) => MainScaffold(child: child),
      routes: [
        GoRoute(
          path: '/home',
          builder: (_, __) => const HomeScreen(),
        ),
        GoRoute(
          path: '/trip-planner',
          builder: (_, __) => const TripPlannerScreen(),
        ),
        GoRoute(
          path: '/itinerary/:id',
          builder: (_, state) {
            final id = state.pathParameters['id'] ?? '1';
            final extra = state.extra as Map<String, dynamic>?;
            return ItineraryScreen(id: id, extra: extra);
          },
        ),
        GoRoute(
          path: '/my-trips',
          builder: (_, __) => const MyTripsScreen(),
        ),
        GoRoute(
          path: '/scan',
          builder: (_, __) => const ScanScreen(),
        ),
        GoRoute(
          path: '/map',
          builder: (_, __) => const MapScreen(),
        ),
        GoRoute(
          path: '/ai-chat',
          builder: (_, __) => const AiChatScreen(),
        ),
        GoRoute(
          path: '/purchase',
          builder: (_, state) {
            final extra = state.extra as Map<String, dynamic>?;
            return PurchaseScreen(extra: extra);
          },
        ),
        GoRoute(
          path: '/trip-camera',
          builder: (_, __) => const TripCameraScreen(),
        ),
        GoRoute(
          path: '/trip-albums',
          builder: (_, __) => const TripAlbumsScreen(),
        ),
        GoRoute(
          path: '/profile',
          builder: (_, __) => const ProfileScreen(),
        ),
        GoRoute(
          path: '/quick-action',
          builder: (_, __) => const QuickActionScreen(),
        ),
        GoRoute(
          path: '/anti-scam',
          redirect: (_, __) => '/scan',
        ),
        GoRoute(
          path: '/anti-scam/scan',
          redirect: (_, __) => '/scan',
        ),
        GoRoute(
          path: '/forum',
          redirect: (_, __) => '/home',
        ),
        GoRoute(
          path: '/find-travelers',
          redirect: (_, __) => '/home',
        ),
        GoRoute(
          path: '/traveler-chat',
          redirect: (_, __) => '/home',
        ),
        GoRoute(
          path: '/traveler-chat/:id',
          redirect: (_, __) => '/home',
        ),
      ],
    ),
  ],
);

class _RouteFallback extends StatelessWidget {
  const _RouteFallback();

  @override
  Widget build(BuildContext context) {
    Future.microtask(() {
      if (!context.mounted) return;

      context.go(ApiAuth.instance.isLoggedIn ? '/home' : '/');
    });

    return const SizedBox.shrink();
  }
}
