import 'package:aspira/core/type_def/type_def.dart';
import 'package:aspira/features/feed/domain/entities/post_entity.dart';
import 'package:aspira/features/feed/domain/repositories/post_repository.dart';

class FetchBookmarkedPostsUseCase {
  final PostRepository repository;

  FetchBookmarkedPostsUseCase(this.repository);

  Result<List<PostEntity>> call() {
    return repository.fetchBookmarkedPosts();
  }
}
