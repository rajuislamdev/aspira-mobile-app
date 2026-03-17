import 'package:aspira/features/profile/presentation/viewmodels/fetch_profile_view_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:aspira/features/auth/domain/entities/user_entity.dart';
import 'package:aspira/features/auth/presentation/providers/auth_providers.dart';
import 'package:aspira/services/local_store_service.dart';

final loginViewModelProvider =
    StateNotifierProvider<LoginViewModel, AsyncValue<UserEntity?>>(
      (ref) => LoginViewModel(ref),
    );

class LoginViewModel extends StateNotifier<AsyncValue<UserEntity?>> {
  final Ref ref;

  LoginViewModel(this.ref) : super(const AsyncValue.data(null));

  Future<void> login({required Map<String, dynamic> payload}) async {
    state = const AsyncValue.loading();
    final loginUseCase = ref.read(loginUseCaseProvider);
    final result = await loginUseCase(payload: payload);

    result.fold(
      (ifLeft) => state = AsyncValue.error(ifLeft, StackTrace.current),
      (ifRight) async {
        LocalStorageService().saveToken(ifRight.value1);
        await ref.read(fetchProfileViewModelProvider.notifier).fetchProfile();
        state = AsyncValue.data(ifRight.value2);
      },
    );
  }
}
