import 'package:aspira/core/type_def/type_def.dart';
import 'package:aspira/features/feed/domain/repositories/post_repository.dart';

class AddCommentUseCase {
  final PostRepository repository;

  AddCommentUseCase(this.repository);

  Result<String> call({
    required String postId,
    required Map<String, dynamic> payload,
  }) {
    return repository.addComment(postId: postId, payload: payload);
  }
}
