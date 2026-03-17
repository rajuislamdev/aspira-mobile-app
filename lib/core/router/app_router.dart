import 'package:aspira/core/router/route_location_name.dart';
import 'package:aspira/features/feed/domain/entities/post_entity.dart';
import 'package:aspira/features/feed/presentation/screens/bookmarked_posts_screen.dart';
import 'package:aspira/features/feed/presentation/screens/discussion_thread_screen.dart';
import 'package:aspira/features/app/presentation/screens/app_launch_screen.dart';
import 'package:aspira/features/mainscaffold/presentation/screens/main_scaffold.dart';
import 'package:aspira/features/feed/presentation/screens/feed_screen.dart';
import 'package:aspira/features/auth/presentation/screens/login_screen.dart';
import 'package:aspira/features/auth/presentation/screens/login_with_email_screen.dart';
import 'package:aspira/features/notification/presentation/notifications/notifications_screen.dart';
import 'package:aspira/features/onboarding/presentation/onboarding_screen.dart';
import 'package:aspira/features/profile/presentation/screens/profile_information_screen.dart';
import 'package:aspira/features/support/presentation/screens/help_center_screen.dart';
import 'package:aspira/features/support/presentation/screens/terms_of_service_screen.dart';
import 'package:aspira/core/widgets/full_screen_image_viewer.dart';
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
        builder: (context, state, child) => MainScaffold(),
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
          child: DiscussionThreadScreen(post: state.extra as PostEntity),
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
