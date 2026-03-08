import 'package:aspira/features/feed/domain/entities/thread_entity.dart';
import 'package:aspira/features/feed/presentation/providers/post_providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

final fetchThreadsViewModelProvider = StateNotifierProvider.autoDispose
    .family<FetchThreadsViewModel, AsyncValue<List<ThreadEntity>>, String>(
      (ref, postId) => FetchThreadsViewModel(ref, postId),
    );

class FetchThreadsViewModel
    extends StateNotifier<AsyncValue<List<ThreadEntity>>> {
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
        .read(fetchThreadsUseCaseProvider)
        .call(postId: postId);
    state = result.fold(
      (failure) => AsyncValue.error(failure.message, StackTrace.current),
      (success) => AsyncValue.data(success),
    );
  }
}
