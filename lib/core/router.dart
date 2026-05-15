import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../features/intro/intro_screen.dart';
import '../features/auth/login_screen.dart';
import '../features/home/home_screen.dart';
import '../features/trip_planner/trip_planner_screen.dart';
import '../features/itinerary/itinerary_screen.dart';
import '../features/map/map_screen.dart';
import '../features/ai_chat/ai_chat_screen.dart';
import '../features/travelers/find_travelers_screen.dart';
import '../features/travelers/traveler_chat_screen.dart';
import '../features/forum/forum_screen.dart';
import '../features/camera/trip_camera_screen.dart';
import '../features/albums/trip_albums_screen.dart';
import '../features/profile/profile_screen.dart';
import '../features/quick_action/quick_action_screen.dart';
import '../features/purchase/purchase_screen.dart';
import '../shared/widgets/main_scaffold.dart';
import 'dart:async';

final GoRouter appRouter = GoRouter(
  initialLocation: '/',
  refreshListenable: GoRouterRefreshStream(
    Supabase.instance.client.auth.onAuthStateChange,
  ),
  redirect: (context, state) {
    final session = Supabase.instance.client.auth.currentSession;
    final isLoggedIn = session != null;

    final location = state.uri.path;
    final isPublicRoute = location == '/' || location == '/login';

    if (!isLoggedIn && !isPublicRoute) {
      return '/';
    }

    if (isLoggedIn && isPublicRoute) {
      return '/home';
    }

    return null;
  },
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
          path: '/map',
          builder: (_, __) => const MapScreen(),
        ),
        GoRoute(
          path: '/ai-chat',
          builder: (_, __) => const AiChatScreen(),
        ),
        GoRoute(
          path: '/find-travelers',
          builder: (_, __) => const FindTravelersScreen(),
        ),
        GoRoute(
          path: '/traveler-chat/:id',
          builder: (_, state) {
            final travelerId = state.pathParameters['id'] ?? '1';
            return TravelerChatScreen(travelerId: travelerId);
          },
        ),
        GoRoute(
          path: '/forum',
          builder: (_, __) => const ForumScreen(),
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
          path: '/purchase',
          builder: (_, __) => const PurchaseScreen(),
        ),
      ],
    ),
  ],
);

class GoRouterRefreshStream extends ChangeNotifier {
  GoRouterRefreshStream(Stream<dynamic> stream) {
    _subscription = stream.asBroadcastStream().listen(
          (_) => notifyListeners(),
        );
  }

  late final StreamSubscription<dynamic> _subscription;

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}
