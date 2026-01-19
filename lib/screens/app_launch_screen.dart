import 'package:aspira/core/router/route_location_name.dart';
import 'package:aspira/core/utils/ui_support.dart';
import 'package:aspira/screens/widgets/loading/aspira_loading_view.dart';
import 'package:aspira/view_models/app/app_launch_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class AppLaunchScreen extends ConsumerWidget {
  const AppLaunchScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen<AppLaunchState>(appLaunchViewModelProvider, (prev, next) {
      if (next is Authenticated) {
        context.goNamed(RouteLocationName.feed);
      } else if (next is NotAuthenticated) {
        context.goNamed(RouteLocationName.login);
      } else if (next is ProfileIncomplete) {
        context.goNamed(RouteLocationName.onboarding);
      }

      if (next is ErrorState) {
        final failure = next.message;
        Ui.showErrorSnackBar(context, message: failure.message);
      }
    });

    final viewModel = ref.watch(appLaunchViewModelProvider);

    return switch (viewModel) {
      Loading() => AspiraLoadingView(),
      ErrorState(message: final failure) => AspiraLoadingView(),
      _ => const SizedBox.shrink(),
    };
  }
}
