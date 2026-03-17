import 'package:aspira/core/type_def/type_def.dart';
import 'package:aspira/features/feed/domain/entities/post_entity.dart';
import 'package:aspira/features/feed/domain/repositories/post_repository.dart';

class FetchPostsUseCase {
  final PostRepository repository;

  FetchPostsUseCase(this.repository);

  Result<List<PostEntity>> call({
    required String? interestId,
    required int page,
  }) {
    return repository.fetchPosts(interestId: interestId, page: page);
  }
}
