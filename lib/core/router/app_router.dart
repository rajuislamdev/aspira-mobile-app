import 'package:aspira/core/router/route_location_name.dart';
import 'package:aspira/screens/core_screen.dart';
import 'package:aspira/screens/feed_screen.dart';
import 'package:aspira/screens/login_with_email_screen.dart';
import 'package:aspira/screens/onboarding/onboarding_screen.dart';
import 'package:aspira/screens/splash_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  static final router = GoRouter(
    initialLocation: '/splash',
    routes: [
      GoRoute(
        path: '/splash',
        name: RouteLocationName.splash,
        builder: (context, state) => SplashScreen(),
      ),

      GoRoute(
        path: '/onboarding',
        name: RouteLocationName.onboarding,
        builder: (context, state) => OnboardingScreen(),
      ),

      ShellRoute(
        builder: (context, state, child) => CoreScreen(),
        routes: [
          // Feed Tab
          GoRoute(
            path: '/feed',
            name: RouteLocationName.feed,
            builder: (context, state) => FeedScreen(),
          ),
          // Profile Tab
          GoRoute(
            path: '/profile',
            name: RouteLocationName.profile,
            builder: (context, state) => SizedBox(),
          ),
        ],
      ),
      // Login Screen
      GoRoute(
        path: '/login',
        name: RouteLocationName.login,
        builder: (context, state) => LoginWithEmailScreen(),
      ),
      // Login With Email
      GoRoute(
        path: '/login_with_email',
        name: RouteLocationName.loginWithEmail,
        builder: (context, state) => LoginWithEmailScreen(),
      ),
    ],
  );
}
