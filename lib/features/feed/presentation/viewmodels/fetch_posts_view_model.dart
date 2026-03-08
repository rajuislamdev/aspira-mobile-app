import 'package:aspira/features/feed/domain/entities/post_entity.dart';
import 'package:aspira/features/feed/presentation/providers/post_providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

final fetchPostsViewModelProvider =
    StateNotifierProvider<FetchPostsViewModel, AsyncValue<List<PostEntity>>>(
      (ref) => FetchPostsViewModel(ref),
    );

class FetchPostsViewModel extends StateNotifier<AsyncValue<List<PostEntity>>> {
  final Ref ref;

  FetchPostsViewModel(this.ref) : super(const AsyncValue.loading()) {
    fetchPosts(interestId: null);
  }

  Future<void> fetchPosts({required String? interestId}) async {
    state = const AsyncValue.loading();
    final result = await ref
        .read(fetchPostsUseCaseProvider)
        .call(interestId: interestId);
    result.fold(
      (ifLeft) => state = AsyncValue.error(ifLeft, StackTrace.current),
      (ifRight) => state = AsyncValue.data(ifRight),
    );
  }

  void reactPost({required String postId}) {
    final posts = state.value;
    if (posts == null) return;
    
    final index = posts.indexWhere((element) => element.id == postId);
    if (index == -1) return;
    
    final updatedPost = posts[index].copyWith(
      hasReacted: !posts[index].hasReacted,
      count: posts[index].count?.copyWith(
        reactions: posts[index].hasReacted
            ? (posts[index].count!.reactions ?? 0) - 1
            : (posts[index].count!.reactions ?? 0) + 1,
      ),
    );
    
    final updatedPosts = List<PostEntity>.from(posts);
    updatedPosts[index] = updatedPost;
    state = AsyncValue.data(updatedPosts);
  }
}
