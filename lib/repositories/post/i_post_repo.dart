import 'package:aspira/core/type_def/type_def.dart';
import 'package:aspira/models/post_model/post_model.dart';

abstract class IPostRepo {
  Result<String> createPost({required Map<String, dynamic> payload});
  Result<List<PostModel>> fetchPosts({required String? interestId});
  Result<String> reactPost({required String postId});
}
