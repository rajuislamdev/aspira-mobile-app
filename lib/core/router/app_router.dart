import 'package:aspira/core/router/route_location_name.dart';
import 'package:aspira/models/post_model/post_model.dart';
import 'package:aspira/screens/app_launch_screen.dart';
import 'package:aspira/screens/core_screen.dart';
import 'package:aspira/screens/feed_screen.dart';
import 'package:aspira/screens/login_screen.dart';
import 'package:aspira/screens/login_with_email_screen.dart';
import 'package:aspira/screens/onboarding/onboarding_screen.dart';
import 'package:aspira/screens/profile/bookmarked_posts_screen.dart';
import 'package:aspira/screens/profile/profile_information_screen.dart';
import 'package:aspira/screens/support/help_center_screen.dart';
import 'package:aspira/screens/support/terms_of_service_screen.dart';
import 'package:aspira/screens/thread/discoussion_thread_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  static final router = GoRouter(
    initialLocation: '/splash',
    routes: [
      GoRoute(
        path: '/splash',
        name: RouteLocationName.splash,
        builder: (context, state) => AppLaunchScreen(),
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
        builder: (context, state) => LoginScreen(),
      ),
      // Login With Email
      GoRoute(
        path: '/login_with_email',
        name: RouteLocationName.loginWithEmail,
        builder: (context, state) => LoginWithEmailScreen(),
      ),
      // Thread Discussion
      GoRoute(
        path: '/thread_discussion',
        name: RouteLocationName.threadDiscussion,
        builder: (context, state) =>
            DiscussionThreadScreen(post: state.extra as PostModel),
      ),
      GoRoute(
        path: '/profile-information',
        name: RouteLocationName.profileInformation,
        builder: (context, state) => ProfileInformationScreen(),
      ),
      GoRoute(
        path: '/help-center-screen',
        name: RouteLocationName.helpCenterScreen,
        builder: (context, state) => HelpCenterScreen(),
      ),
      GoRoute(
        path: '/terms-of-service-scree',
        name: RouteLocationName.termsOfServiceScreen,
        builder: (context, state) => TermsOfServiceScreen(),
      ),
      GoRoute(
        path: '/bookmarked-posts',
        name: RouteLocationName.bookmarkedPosts,
        builder: (context, state) => const BookmarkedPostsScreen(),
      ),
    ],
  );
}
