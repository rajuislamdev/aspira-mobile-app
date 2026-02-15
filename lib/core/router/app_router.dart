import 'package:aspira/core/router/route_location_name.dart';
import 'package:aspira/models/post_model/post_model.dart';
import 'package:aspira/screens/app_launch_screen.dart';
import 'package:aspira/screens/core_screen.dart';
import 'package:aspira/screens/feed_screen.dart';
import 'package:aspira/screens/login_screen.dart';
import 'package:aspira/screens/login_with_email_screen.dart';
import 'package:aspira/screens/notifications/notifications_screen.dart';
import 'package:aspira/screens/onboarding/onboarding_screen.dart';
import 'package:aspira/screens/profile/bookmarked_posts_screen.dart';
import 'package:aspira/screens/profile/profile_information_screen.dart';
import 'package:aspira/screens/support/help_center_screen.dart';
import 'package:aspira/screens/support/terms_of_service_screen.dart';
import 'package:aspira/screens/thread/discoussion_thread_screen.dart';
import 'package:aspira/screens/widgets/full_screen_image_viewer.dart';
import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  static final router = GoRouter(
    initialLocation: '/splash',
    routes: [
      GoRoute(
        path: '/splash',
        name: RouteLocationName.splash,
        pageBuilder: (context, state) =>
            NoTransitionPage(child: AppLaunchScreen()),
      ),

      GoRoute(
        path: '/onboarding',
        name: RouteLocationName.onboarding,
        pageBuilder: (context, state) =>
            NoTransitionPage(child: OnboardingScreen()),
      ),

      ShellRoute(
        builder: (context, state, child) => CoreScreen(),
        routes: [
          // Feed Tab
          GoRoute(
            path: '/feed',
            name: RouteLocationName.feed,
            pageBuilder: (context, state) =>
                NoTransitionPage(child: FeedScreen()),
          ),
          // Profile Tab
          GoRoute(
            path: '/profile',
            name: RouteLocationName.profile,
            pageBuilder: (context, state) =>
                NoTransitionPage(child: SizedBox()),
          ),
        ],
      ),
      // Login Screen
      GoRoute(
        path: '/login',
        name: RouteLocationName.login,
        pageBuilder: (context, state) => NoTransitionPage(child: LoginScreen()),
      ),
      // Login With Email
      GoRoute(
        path: '/login_with_email',
        name: RouteLocationName.loginWithEmail,
        pageBuilder: (context, state) =>
            NoTransitionPage(child: LoginWithEmailScreen()),
      ),
      // Thread Discussion
      GoRoute(
        path: '/thread_discussion',
        name: RouteLocationName.threadDiscussion,
        pageBuilder: (context, state) => NoTransitionPage(
          child: DiscussionThreadScreen(post: state.extra as PostModel),
        ),
      ),
      GoRoute(
        path: '/profile-information',
        name: RouteLocationName.profileInformation,
        pageBuilder: (context, state) =>
            NoTransitionPage(child: ProfileInformationScreen()),
      ),
      GoRoute(
        path: '/help-center-screen',
        name: RouteLocationName.helpCenterScreen,
        pageBuilder: (context, state) =>
            NoTransitionPage(child: HelpCenterScreen()),
      ),
      GoRoute(
        path: '/terms-of-service-scree',
        name: RouteLocationName.termsOfServiceScreen,
        pageBuilder: (context, state) =>
            NoTransitionPage(child: TermsOfServiceScreen()),
      ),
      GoRoute(
        path: '/bookmarked-posts',
        name: RouteLocationName.bookmarkedPosts,
        pageBuilder: (context, state) =>
            const NoTransitionPage(child: BookmarkedPostsScreen()),
      ),
      GoRoute(
        path: '/notifications',
        name: RouteLocationName.notifications,
        pageBuilder: (context, state) =>
            const NoTransitionPage(child: NotificationsScreen()),
      ),
      GoRoute(
        path: '/image-viewer',
        name: RouteLocationName.imageViewer,
        pageBuilder: (context, state) => NoTransitionPage(
          child: FullScreenImageViewer(data: state.extra as ImageViewerData),
        ),
      ),
    ],
  );
}
