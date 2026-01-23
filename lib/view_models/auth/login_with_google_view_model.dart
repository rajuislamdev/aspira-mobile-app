import 'package:aspira/core/errors/failure.dart';
import 'package:aspira/models/profile_model/profile_model.dart';
import 'package:aspira/models/user_model/user_model.dart';
import 'package:aspira/repositories/auth_repo/auth_repo_impl.dart';
import 'package:aspira/repositories/profile/profile_repo_impl.dart';
import 'package:aspira/services/local_store_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

sealed class LoginWithGoogleState {}

class Initial extends LoginWithGoogleState {}

class Loading extends LoginWithGoogleState {}

class Success extends LoginWithGoogleState {
  final UserModel user;
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
    final idTokenResult = await ref.read(authRepoProvider).getGoogleIdToken();
    idTokenResult.fold(
      (ifLeft) {
        return state = Error(ifLeft);
      },
      (token) async {
        if (token == null) {
          state = Error(ServerFailure('Something went wrong'));
          return;
        }
        final result = await ref.read(authRepoProvider).loginWithGoogle(idToken: token);
        result.fold(
          (ifLeft) {
            state = Error(ifLeft);
          },
          (profile) async {
            LocalStorageService().saveToken(profile.value1);
            final result = await ref.read(profileRepoProvider).fetchUserProfile();
            result.fold(
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
      },
    );
  }
}

final loginWithGoogleViewModelProvider =
    StateNotifierProvider<LoginWithGoogleViewModel, LoginWithGoogleState>(
      (ref) => LoginWithGoogleViewModel(ref),
    );
