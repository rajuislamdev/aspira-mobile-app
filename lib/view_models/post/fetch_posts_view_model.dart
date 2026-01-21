import 'package:aspira/models/post_model/post_model.dart';
import 'package:aspira/repositories/post/post_repo_impl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

final fetchPostsViewModelProvider =
    StateNotifierProvider<FetchPostsViewModel, AsyncValue<List<PostModel>>>(
      (ref) => FetchPostsViewModel(ref),
    );

class FetchPostsViewModel extends StateNotifier<AsyncValue<List<PostModel>>> {
  final Ref ref;

  FetchPostsViewModel(this.ref) : super(const AsyncValue.loading()) {
    fetchPosts(interestId: null);
  }

  Future<void> fetchPosts({required String? interestId}) async {
    state = const AsyncValue.loading();
    final result = await ref.read(postRepoProvider).fetchPosts(interestId: interestId);
    result.fold(
      (ifLeft) => state = AsyncValue.error(ifLeft, StackTrace.current),
      (ifRight) => state = AsyncValue.data(ifRight),
    );
  }
}
