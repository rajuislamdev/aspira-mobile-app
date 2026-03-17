import 'package:aspira/core/errors/exceptions.dart';
import 'package:aspira/core/errors/failure.dart';
import 'package:aspira/core/type_def/type_def.dart';
import 'package:aspira/features/feed/data/datasources/post_remote_data_source.dart';
import 'package:aspira/features/feed/data/models/post_model.dart';
import 'package:aspira/features/feed/data/models/thread_model.dart';
import 'package:aspira/features/feed/domain/entities/post_entity.dart';
import 'package:aspira/features/feed/domain/entities/thread_entity.dart';
import 'package:aspira/features/feed/domain/repositories/post_repository.dart';
import 'package:dartz/dartz.dart';

class PostRepositoryImpl implements PostRepository {
  final PostRemoteDataSource remoteDataSource;

  PostRepositoryImpl({required this.remoteDataSource});

  @override
  Result<String> createPost({required Map<String, dynamic> payload}) async {
    try {
      await remoteDataSource.createPost(payload: payload);
      return const Right("Post created successfully");
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Result<List<PostEntity>> fetchPosts({
    required String? interestId,
    required int page,
  }) async {
    try {
      final response = await remoteDataSource.fetchPosts(
        interestId: interestId,
        page: page,
      );
      final data = response.data['payload'];
      final posts = (data as List).map((e) => PostModel.fromJson(e)).toList();
      return Right(posts);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Result<List<PostEntity>> fetchBookmarkedPosts() async {
    try {
      final response = await remoteDataSource.fetchBookmarkedPosts();
      final data = response.data['payload'];
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
      await remoteDataSource.reactPost(postId: postId);
      return const Right("Post reacted successfully");
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Result<String> bookmarkPost({required String postId}) async {
    try {
      await remoteDataSource.bookmarkPost(postId: postId);
      return const Right("Post bookmarked successfully");
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Result<List<ThreadEntity>> fetchPostsThread({required String postId}) async {
    try {
      final response = await remoteDataSource.fetchPostsThread(postId: postId);
      final data = response.data['payload'];
      final threads = (data as List)
          .map((e) => ThreadModel.fromJson(e))
          .toList();
      return Right(threads);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Result<String> addComment({
    required String postId,
    required Map<String, dynamic> payload,
  }) async {
    try {
      await remoteDataSource.addComment(postId: postId, payload: payload);
      return const Right("Comment added successfully");
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
