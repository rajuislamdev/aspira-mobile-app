import 'package:aspira/features/profile/data/models/profile_option_model/profile_option_model.dart';
import 'package:aspira/features/profile/presentation/providers/profile_providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

final fetchInterestViewModelProvider =
    StateNotifierProvider<
      FetchInterestViewModel,
      AsyncValue<ProfileOptionModel?>
    >((ref) => FetchInterestViewModel(ref: ref));

final fetchProfileOptionViewModel = fetchInterestViewModelProvider;

class FetchInterestViewModel
    extends StateNotifier<AsyncValue<ProfileOptionModel?>> {
  final Ref ref;

  FetchInterestViewModel({required this.ref})
    : super(const AsyncValue.loading()) {
    fetchInterest();
  }

  Future<void> fetchInterest() async {
    state = const AsyncValue.loading();
    final result = await ref.read(fetchInterestUseCaseProvider)();
    result.fold(
      (failure) => state = AsyncValue.error(failure, StackTrace.current),
      (profileOption) => state = AsyncValue.data(profileOption),
    );
  }
}
