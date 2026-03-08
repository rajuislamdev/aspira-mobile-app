import 'package:aspira/features/profile/data/models/profile_model/profile_model.dart';
import 'package:aspira/features/profile/presentation/providers/profile_providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

final fetchProfileViewModelProvider =
    StateNotifierProvider<FetchProfileViewModel, AsyncValue<ProfileModel?>>(
      (ref) => FetchProfileViewModel(ref: ref),
    );

class FetchProfileViewModel extends StateNotifier<AsyncValue<ProfileModel?>> {
  final Ref ref;

  FetchProfileViewModel({required this.ref})
    : super(const AsyncValue.loading()) {
    fetchProfile();
  }

  Future<void> fetchProfile() async {
    final result = await ref.read(fetchProfileUseCaseProvider)();
    result.fold(
      (failure) {
        state = AsyncValue.error(failure, StackTrace.current);
      },
      (profile) {
        state = AsyncValue.data(profile);
      },
    );
  }
}
