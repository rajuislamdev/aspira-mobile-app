import 'package:aspira/core/network/api_endpoints.dart';
import 'package:aspira/core/network/dio_client.dart';
import 'package:aspira/core/utils/app_constants.dart';
import 'package:dio/dio.dart';

abstract class PostRemoteDataSource {
  Future<Response> createPost({required Map<String, dynamic> payload});
  Future<Response> fetchPosts({required String? interestId, required int page});
  Future<Response> fetchBookmarkedPosts();
  Future<Response> reactPost({required String postId});
  Future<Response> bookmarkPost({required String postId});
  Future<Response> fetchPostsThread({required String postId});
  Future<Response> addComment({
    required String postId,
    required Map<String, dynamic> payload,
  });
}

class PostRemoteDataSourceImpl implements PostRemoteDataSource {
  final DioClient dioClient;

  PostRemoteDataSourceImpl({required this.dioClient});

  @override
  Future<Response> createPost({required Map<String, dynamic> payload}) async {
    return await dioClient.post(ApiEndpoints.posts, data: payload);
  }

  @override
  Future<Response> fetchPosts({
    required String? interestId,
    required int page,
  }) async {
    return await dioClient.get(
      ApiEndpoints.posts,
      params: {
        "interestId": interestId,
        "page": page,
        "limit": AppConstants.perPage,
      },
    );
  }

  @override
  Future<Response> fetchBookmarkedPosts() async {
    return await dioClient.get(ApiEndpoints.fetchBookmarkedPosts);
  }

  @override
  Future<Response> reactPost({required String postId}) async {
    return await dioClient.post(
      ApiEndpoints.reactPost.replaceFirst(':postId', postId),
      data: {'type': 'LOVE'},
    );
  }

  @override
  Future<Response> bookmarkPost({required String postId}) async {
    return await dioClient.post(
      ApiEndpoints.bookmarkPost.replaceFirst(':postId', postId),
    );
  }

  @override
  Future<Response> fetchPostsThread({required String postId}) async {
    return await dioClient.get(
      ApiEndpoints.fetchPostsThread.replaceFirst(':postId', postId),
    );
  }

  @override
  Future<Response> addComment({
    required String postId,
    required Map<String, dynamic> payload,
  }) async {
    return await dioClient.post(
      ApiEndpoints.commentPost.replaceFirst(':postId', postId),
      data: payload,
    );
  }
}
