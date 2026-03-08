import 'package:aspira/core/type_def/type_def.dart';
import 'package:aspira/features/feed/domain/repositories/post_repository.dart';

class ReactPostUseCase {
  final PostRepository repository;

  ReactPostUseCase(this.repository);

  Result<String> call({required String postId}) {
    return repository.reactPost(postId: postId);
  }
}
