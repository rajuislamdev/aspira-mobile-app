import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:aspira/core/errors/failure.dart';
import 'package:aspira/features/auth/presentation/providers/auth_providers.dart';
import 'package:aspira/models/profile_model/profile_model.dart';
import 'package:aspira/features/auth/domain/entities/user_entity.dart';
import 'package:aspira/repositories/profile/profile_repo_impl.dart';
import 'package:aspira/services/local_store_service.dart';

sealed class LoginWithGoogleState {}

class Initial extends LoginWithGoogleState {}

class Loading extends LoginWithGoogleState {}

class Success extends LoginWithGoogleState {
  final UserEntity user;
  Success(this.user);
}

class ProfileComplete extends LoginWithGoogleState {
  final ProfileModel user;
  ProfileComplete(this.user);
}

class Error extends LoginWithGoogleState {
  final Failure failure;
  Error(this.failure);
}

class LoginWithGoogleViewModel extends StateNotifier<LoginWithGoogleState> {
  final Ref ref;

  LoginWithGoogleViewModel(this.ref) : super(Initial());

  Future<void> loginWithGoogle() async {
    state = Loading();
    final getGoogleIdTokenUseCase = ref.read(getGoogleIdTokenUseCaseProvider);
    final idTokenResult = await getGoogleIdTokenUseCase();

    final token = idTokenResult.fold<String?>((ifLeft) {
      state = Error(ifLeft);
      return null;
    }, (token) => token);

    if (token == null) {
      return;
    }

    final loginWithGoogleUseCase = ref.read(loginWithGoogleUseCaseProvider);
    final result = await loginWithGoogleUseCase(idToken: token);

    result.fold(
      (ifLeft) {
        state = Error(ifLeft);
      },
      (profile) async {
        LocalStorageService().saveToken(profile.value1);
        final profileResult = await ref
            .read(profileRepoProvider)
            .fetchUserProfile();
        profileResult.fold(
          (ifLeft) {
            state = Error(ifLeft);
          },
          (ifRight) {
            if (ifRight.interests != null && ifRight.interests!.isNotEmpty) {
              state = ProfileComplete(ifRight);
            } else {
              state = Success(profile.value2);
            }
          },
        );
      },
    );
  }
}

final loginWithGoogleViewModelProvider =
    StateNotifierProvider<LoginWithGoogleViewModel, LoginWithGoogleState>(
      (ref) => LoginWithGoogleViewModel(ref),
    );
