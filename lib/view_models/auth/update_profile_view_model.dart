import 'package:aspira/repositories/auth_repo/auth_repo_impl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

final updateProfileViewModelProvider =
    StateNotifierProvider.autoDispose<
      UpdateProfileViewModel,
      AsyncValue<String?>
    >((ref) => UpdateProfileViewModel(ref: ref));

class UpdateProfileViewModel extends StateNotifier<AsyncValue<String?>> {
  final Ref ref;

  UpdateProfileViewModel({required this.ref})
    : super(const AsyncValue.data(null));

  Future<void> updateProfile({required Map<String, dynamic> payload}) async {
    state = const AsyncValue.loading();
    try {
      final result = await ref
          .read(authRepoProvider)
          .updateProfile(payload: payload);
      result.fold(
        (ifLeft) => state = AsyncValue.error(ifLeft, StackTrace.current),
        (ifRight) => state = AsyncValue.data(ifRight),
      );
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }
}
