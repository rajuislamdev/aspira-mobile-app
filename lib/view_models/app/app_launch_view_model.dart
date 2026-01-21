import 'package:aspira/core/errors/failure.dart';
import 'package:aspira/repositories/profile_option_repo/profile_option_impl.dart';
import 'package:aspira/services/local_store_service.dart';
import 'package:aspira/view_models/profile/fetch_profile_view_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

sealed class AppLaunchState {}

class Loading extends AppLaunchState {}

class NotAuthenticated extends AppLaunchState {}

class Authenticated extends AppLaunchState {}

class ProfileIncomplete extends AppLaunchState {}

class ErrorState extends AppLaunchState {
  final Failure message;
  ErrorState(this.message);
}

class AppLaunchViewModel extends StateNotifier<AppLaunchState> {
  final Ref ref;

  AppLaunchViewModel({required this.ref}) : super(Loading()) {
    _launchApp();
  }

  Future<void> _launchApp() async {
    try {
      state = Loading();
      final String? token = await LocalStorageService().getToken();
      final bool? isOnBoardingCompleted = await LocalStorageService().getIsOnboardingComplete();

      if (token != null && isOnBoardingCompleted != null && isOnBoardingCompleted) {
        await ref.read(fetchProfileViewModelProvider.notifier).fetchProfile();
        state = Authenticated();
        return;
      }

      if (token == null) {
        state = NotAuthenticated();
        return;
      }

      if (isOnBoardingCompleted == null) {
        final result = await ref.read(profileOptionProvider).fetchInterest();
        result.fold(
          (ifLeft) => state = ErrorState(ifLeft),
          (ifRight) => state = ProfileIncomplete(),
        );
        return;
      }
    } catch (e) {
      state = ErrorState(ServerFailure(e.toString()));
    }
  }
}

final appLaunchViewModelProvider = StateNotifierProvider<AppLaunchViewModel, AppLaunchState>(
  (ref) => AppLaunchViewModel(ref: ref),
);
