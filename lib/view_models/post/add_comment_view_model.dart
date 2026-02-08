import 'package:aspira/repositories/post/post_repo_impl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

final addCommentViewModelProvider =
    StateNotifierProvider.autoDispose<AddCommentViewModel, AsyncValue<String?>>(
      (ref) => AddCommentViewModel(ref),
    );

class AddCommentViewModel extends StateNotifier<AsyncValue<String?>> {
  final Ref ref;
  AddCommentViewModel(this.ref) : super(const AsyncValue.data(null));

  Future<void> addComment({
    required String postId,
    required String? parentId,
    required String comment,
  }) async {
    state = const AsyncValue.loading();
    final result = await ref
        .read(postRepoProvider)
        .addComment(
          postId: postId,
          payload: {
            "content": comment,
            ...parentId != null ? {"parentId": parentId} : {},
          },
        );
    state = result.fold(
      (failure) => AsyncValue.error(failure.message, StackTrace.current),
      (success) => AsyncValue.data(success),
    );
  }
}
