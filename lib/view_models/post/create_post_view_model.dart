import 'package:aspira/repositories/post/post_repo_impl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

final createPostViewModelProvider = StateNotifierProvider<CreatePostViewModel, AsyncValue<String?>>(
  (ref) => CreatePostViewModel(ref),
);

class CreatePostViewModel extends StateNotifier<AsyncValue<String?>> {
  final Ref ref;
  CreatePostViewModel(this.ref) : super(const AsyncValue.data(null));

  Future<void> createPost({required Map<String, dynamic> payload}) async {
    state = const AsyncValue.loading();
    final result = await ref.read(postRepoProvider).createPost(payload: payload);

    result.fold(
      (ifLeft) => state = AsyncValue.error(ifLeft, StackTrace.current),
      (ifRight) => state = AsyncValue.data(ifRight),
    );
  }
}
