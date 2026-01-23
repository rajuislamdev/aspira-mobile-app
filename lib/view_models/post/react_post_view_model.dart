import 'package:aspira/repositories/post/post_repo_impl.dart';
import 'package:aspira/view_models/post/fetch_posts_view_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

final reactPostViewModelProvider = StateNotifierProvider<ReactPostViewModel, AsyncValue<String?>>(
  (ref) => ReactPostViewModel(ref),
);

class ReactPostViewModel extends StateNotifier<AsyncValue<String?>> {
  final Ref ref;

  ReactPostViewModel(this.ref) : super(const AsyncValue.data(null));

  Future<void> reactPost({required String postId}) async {
    state = const AsyncValue.loading();
    ref.read(fetchPostsViewModelProvider.notifier).reactPost(postId: postId);
    final result = await ref.read(postRepoProvider).reactPost(postId: postId);
    result.fold((ifLeft) {
      ref.read(fetchPostsViewModelProvider.notifier).reactPost(postId: postId);
      state = AsyncValue.error(ifLeft, StackTrace.current);
    }, (ifRight) => state = AsyncValue.data(ifRight));
  }
}
