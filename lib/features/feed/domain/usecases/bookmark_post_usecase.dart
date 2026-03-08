import 'package:aspira/core/type_def/type_def.dart';
import 'package:aspira/features/feed/domain/repositories/post_repository.dart';

class BookmarkPostUseCase {
  final PostRepository repository;

  BookmarkPostUseCase(this.repository);

  Result<String> call({required String postId}) {
    return repository.bookmarkPost(postId: postId);
  }
}
