import 'package:aspira/core/errors/failure.dart';
import 'package:aspira/repositories/profile/profile_repo_impl.dart';
import 'package:aspira/repositories/profile_option_repo/profile_option_impl.dart';
import 'package:aspira/services/local_store_service.dart';
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
      print("Token: $token isOnboarding: $isOnBoardingCompleted");

      if (token != null && isOnBoardingCompleted != null && isOnBoardingCompleted) {
        print("Token: $token isOnboarding: $isOnBoardingCompleted");
        final result = await ref.read(profileRepoProvider).fetchUserProfile();
        result.fold((ifLeft) => state = ErrorState(ifLeft), (ifRight) {
          if (ifRight.interests != null && ifRight.interests!.isNotEmpty) {
            print("Profile completed");
            state = Authenticated();
          } else {
            print("Profile incomplete");
            state = ProfileIncomplete();
          }
        });

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
