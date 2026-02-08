import 'package:aspira/repositories/post/post_repo_impl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

final bookmarkPostViewModelProvider =
    StateNotifierProvider<BookmarkPostViewModel, AsyncValue<String?>>(
      (ref) => BookmarkPostViewModel(ref),
    );

class BookmarkPostViewModel extends StateNotifier<AsyncValue<String?>> {
  final Ref ref;

  BookmarkPostViewModel(this.ref) : super(const AsyncValue.data(null));

  Future<void> bookmarkPost({required String postId}) async {
    state = const AsyncValue.loading();
    final result = await ref
        .read(postRepoProvider)
        .bookmarkPost(postId: postId);
    state = result.fold(
      (failure) => AsyncValue.error(failure.message, StackTrace.current),
      (success) => AsyncValue.data(success),
    );
  }
}
