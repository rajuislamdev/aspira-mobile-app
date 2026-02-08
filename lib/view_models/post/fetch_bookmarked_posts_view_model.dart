import 'package:aspira/models/post_model/post_model.dart';
import 'package:aspira/repositories/post/post_repo_impl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

final fetchBookmarkedPostsViewModelProvider =
    StateNotifierProvider.autoDispose<
      FetchBookmarkedPostsViewModel,
      AsyncValue<List<PostModel>>
    >((ref) => FetchBookmarkedPostsViewModel(ref));

class FetchBookmarkedPostsViewModel
    extends StateNotifier<AsyncValue<List<PostModel>>> {
  final Ref ref;

  FetchBookmarkedPostsViewModel(this.ref) : super(const AsyncValue.loading()) {
    fetchBookmarkedPosts();
  }

  Future<void> fetchBookmarkedPosts() async {
    state = const AsyncValue.loading();
    final result = await ref.read(postRepoProvider).fetchBookmarkedPosts();
    result.fold(
      (ifLeft) => state = AsyncValue.error(ifLeft, StackTrace.current),
      (ifRight) => state = AsyncValue.data(ifRight),
    );
  }
}
