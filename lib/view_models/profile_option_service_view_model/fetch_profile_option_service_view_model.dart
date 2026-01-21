import 'package:aspira/models/profile_option_model/profile_option_model.dart';
import 'package:aspira/repositories/profile_option_repo/profile_option_impl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

final fetchProfileOptionViewModel =
    StateNotifierProvider<
      FetchProfileOptionServiceViewModel,
      AsyncValue<ProfileOptionModel?>
    >((ref) => FetchProfileOptionServiceViewModel(ref: ref));

class FetchProfileOptionServiceViewModel
    extends StateNotifier<AsyncValue<ProfileOptionModel?>> {
  final Ref ref;

  FetchProfileOptionServiceViewModel({required this.ref})
    : super(const AsyncValue.loading()) {
    fetchInterest();
  }

  Future<void> fetchInterest() async {
    state = const AsyncValue.loading();
    final result = await ref.read(profileOptionProvider).fetchInterest();
    result.fold(
      (ifLeft) => state = AsyncValue.error(ifLeft, StackTrace.current),
      (ifRight) => state = AsyncValue.data(ifRight),
    );
  }
}
