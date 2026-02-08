import 'package:aspira/core/type_def/type_def.dart';
import 'package:aspira/models/post_model/post_model.dart';
import 'package:aspira/models/thread_model/thread_model.dart';

abstract class IPostRepo {
  Result<String> createPost({required Map<String, dynamic> payload});
  Result<List<PostModel>> fetchPosts({required String? interestId});
  Result<List<PostModel>> fetchBookmarkedPosts();
  Result<String> reactPost({required String postId});
  Result<String> bookmarkPost({required String postId});
  Result<List<ThreadModel>> fetchPostsThread({required String postId});
  Result<String> addComment({
    required String postId,
    required Map<String, dynamic> payload,
  });
}
