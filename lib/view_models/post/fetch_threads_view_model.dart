import 'package:aspira/models/thread_model/thread_model.dart';
import 'package:aspira/repositories/post/post_repo_impl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

final fetchThreadsViewModelProvider = StateNotifierProvider.autoDispose
    .family<FetchThreadsViewModel, AsyncValue<List<ThreadModel>>, String>(
      (ref, postId) => FetchThreadsViewModel(ref, postId),
    );

class FetchThreadsViewModel
    extends StateNotifier<AsyncValue<List<ThreadModel>>> {
  final String postId;
  final Ref ref;
  FetchThreadsViewModel(this.ref, this.postId)
    : super(const AsyncValue.data([])) {
    if (postId.isNotEmpty) {
      fetchThreads(postId: postId);
    }
  }

  Future<void> fetchThreads({required String postId}) async {
    if (postId.isEmpty) return;
    state = const AsyncValue.loading();
    final result = await ref
        .read(postRepoProvider)
        .fetchPostsThread(postId: postId);
    state = result.fold(
      (failure) => AsyncValue.error(failure.message, StackTrace.current),
      (success) => AsyncValue.data(success),
    );
  }
}
