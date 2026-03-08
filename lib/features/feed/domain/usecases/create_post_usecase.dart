import 'package:aspira/core/type_def/type_def.dart';
import 'package:aspira/features/feed/domain/repositories/post_repository.dart';

class CreatePostUseCase {
  final PostRepository repository;

  CreatePostUseCase(this.repository);

  Result<String> call({required Map<String, dynamic> payload}) {
    return repository.createPost(payload: payload);
  }
}
