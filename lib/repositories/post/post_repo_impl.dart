import 'package:aspira/core/errors/exceptions.dart';
import 'package:aspira/core/errors/failure.dart';
import 'package:aspira/core/type_def/type_def.dart';
import 'package:aspira/models/post_model/post_model.dart';
import 'package:aspira/repositories/post/i_post_repo.dart';
import 'package:aspira/services/post_service.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final postRepoProvider = Provider(
  (ref) => PostRepoImpl(postService: ref.read(postServiceProvider)),
);

class PostRepoImpl extends IPostRepo {
  final PostService postService;
  PostRepoImpl({required this.postService});
  @override
  Result<String> createPost({required Map<String, dynamic> payload}) async {
    try {
      await postService.createPost(payload: payload);
      return Right("Post created successfully");
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Result<List<PostModel>> fetchPosts({required String? interestId}) async {
    try {
      final response = await postService.fetchPosts(interestId: interestId);
      final data = response.data;
      final posts = (data as List).map((e) => PostModel.fromJson(e)).toList();
      return Right(posts);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Result<String> reactPost({required String postId}) async {
    try {
      await postService.reactPost(postId: postId);
      return Right("Post reacted successfully");
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
