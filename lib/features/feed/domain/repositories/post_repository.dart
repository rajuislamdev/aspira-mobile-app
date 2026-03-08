import 'package:aspira/core/type_def/type_def.dart';
import 'package:aspira/features/feed/domain/entities/post_entity.dart';
import 'package:aspira/features/feed/domain/entities/thread_entity.dart';

abstract class PostRepository {
  Result<String> createPost({required Map<String, dynamic> payload});
  Result<List<PostEntity>> fetchPosts({required String? interestId});
  Result<List<PostEntity>> fetchBookmarkedPosts();
  Result<String> reactPost({required String postId});
  Result<String> bookmarkPost({required String postId});
  Result<List<ThreadEntity>> fetchPostsThread({required String postId});
  Result<String> addComment({
    required String postId,
    required Map<String, dynamic> payload,
  });
}
