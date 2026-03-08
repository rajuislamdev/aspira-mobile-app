import 'package:aspira/core/errors/failure.dart';
import 'package:aspira/features/app/presentation/providers/app_providers.dart';
import 'package:aspira/features/profile/presentation/providers/profile_providers.dart';
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
      final localStorageService = ref.read(localStorageServiceProvider);
      final String? token = await localStorageService.getToken();
      final bool? isOnBoardingCompleted = await localStorageService
          .getIsOnboardingComplete();

      if (token != null &&
          isOnBoardingCompleted != null &&
          isOnBoardingCompleted) {
        final result = await ref.read(fetchProfileUseCaseProvider)();
        result.fold((ifLeft) => state = ErrorState(ifLeft), (ifRight) {
          if (ifRight.interests != null && ifRight.interests!.isNotEmpty) {
            state = Authenticated();
          } else {
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
        final result = await ref.read(fetchInterestUseCaseProvider)();
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

final appLaunchViewModelProvider =
    StateNotifierProvider<AppLaunchViewModel, AppLaunchState>(
      (ref) => AppLaunchViewModel(ref: ref),
    );
