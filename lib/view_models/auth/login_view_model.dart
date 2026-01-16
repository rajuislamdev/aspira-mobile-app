import 'package:aspira/models/user_model/user_model.dart';
import 'package:aspira/repositories/auth_repo/auth_repo_impl.dart';
import 'package:aspira/services/local_store_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

final loginViewModelProvider = StateNotifierProvider<LoginViewModel, AsyncValue<UserModel?>>(
  (ref) => LoginViewModel(ref),
);

class LoginViewModel extends StateNotifier<AsyncValue<UserModel?>> {
  final Ref ref;

  LoginViewModel(this.ref) : super(const AsyncValue.data(null));

  Future<void> login({required Map<String, dynamic> payload}) async {
    state = const AsyncValue.loading();
    final result = await ref.read(authRepoProvider).login(payload: payload);

    result.fold((ifLeft) => state = AsyncValue.error(ifLeft, StackTrace.current), (ifRight) {
      LocalStorageService().saveToken(ifRight.value1);
      state = AsyncValue.data(ifRight.value2);
    });
  }
}
