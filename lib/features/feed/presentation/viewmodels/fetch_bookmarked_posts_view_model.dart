import 'package:aspira/features/feed/domain/entities/post_entity.dart';
import 'package:aspira/features/feed/presentation/providers/post_providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

final fetchBookmarkedPostsViewModelProvider =
    StateNotifierProvider.autoDispose<
      FetchBookmarkedPostsViewModel,
      AsyncValue<List<PostEntity>>
    >((ref) => FetchBookmarkedPostsViewModel(ref));

class FetchBookmarkedPostsViewModel
    extends StateNotifier<AsyncValue<List<PostEntity>>> {
  final Ref ref;

  FetchBookmarkedPostsViewModel(this.ref) : super(const AsyncValue.loading()) {
    fetchBookmarkedPosts();
  }

  Future<void> fetchBookmarkedPosts() async {
    state = const AsyncValue.loading();
    final result = await ref.read(fetchBookmarkedPostsUseCaseProvider).call();
    result.fold(
      (ifLeft) => state = AsyncValue.error(ifLeft, StackTrace.current),
      (ifRight) => state = AsyncValue.data(ifRight),
    );
  }
}
