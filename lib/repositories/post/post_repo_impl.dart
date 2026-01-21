import 'package:aspira/core/errors/exceptions.dart';
import 'package:aspira/core/errors/failure.dart';
import 'package:aspira/core/type_def/type_def.dart';
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
}
