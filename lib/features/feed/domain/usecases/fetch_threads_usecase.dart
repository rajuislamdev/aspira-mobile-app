import 'package:aspira/core/type_def/type_def.dart';
import 'package:aspira/features/feed/domain/entities/thread_entity.dart';
import 'package:aspira/features/feed/domain/repositories/post_repository.dart';

class FetchThreadsUseCase {
  final PostRepository repository;

  FetchThreadsUseCase(this.repository);

  Result<List<ThreadEntity>> call({required String postId}) {
    return repository.fetchPostsThread(postId: postId);
  }
}
