import 'package:aspira/core/utils/app_constants.dart';
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
  int _page = 1;
  bool _isFetching = false;
  bool _hasMore = true;

  bool get isFetching => _isFetching;
  bool get hasMore => _hasMore;

  FetchPostsViewModel(this.ref) : super(const AsyncValue.loading()) {
    fetchPosts(interestId: null);
  }

  Future<void> fetchPosts({
    required String? interestId,
    bool isReset = false,
  }) async {
    if (_isFetching || (!_hasMore && !isReset)) return;

    _isFetching = true;

    if (isReset) {
      _page = 1;
      _hasMore = true;
      state = const AsyncValue.loading();
    }

    state = const AsyncValue.loading();
    final result = await ref
        .read(fetchPostsUseCaseProvider)
        .call(interestId: interestId, page: _page);
    result.fold(
      (ifLeft) {
        _isFetching = false;
        state = AsyncValue.error(ifLeft, StackTrace.current);
      },
      (ifRight) {
        _isFetching = false;
        final hasFullPage = ifRight.length >= AppConstants.perPage;
        _hasMore = hasFullPage;

        if (hasFullPage) {
          _page++;
        }
        state = AsyncValue.data(
          isReset ? ifRight : [...?state.value, ...ifRight],
        );
      },
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
