import 'package:aspira/core/network/api_endpoints.dart';
import 'package:aspira/core/network/dio_client.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final postServiceProvider = Provider(
  (ref) => PostService(dioClient: ref.read(dioClientProvider)),
);

class PostService {
  final DioClient dioClient;
  PostService({required this.dioClient});

  Future<Response> createPost({required Map<String, dynamic> payload}) async {
    return await dioClient.post(ApiEndpoints.posts, data: payload);
  }

  Future<Response> fetchPosts({required String? interestId}) async {
    return await dioClient.get(
      ApiEndpoints.posts,
      params: {"interestId": interestId},
    );
  }

  Future<Response> fetchBookmarkedPosts() async {
    return await dioClient.get(ApiEndpoints.fetchBookmarkedPosts);
  }

  Future<Response> reactPost({required String postId}) async {
    return await dioClient.post(
      ApiEndpoints.reactPost.replaceFirst(':postId', postId),
      data: {'type': 'LOVE'},
    );
  }

  Future<Response> bookmarkPost({required String postId}) async {
    return await dioClient.post(
      ApiEndpoints.bookmarkPost.replaceFirst(':postId', postId),
    );
  }

  Future<Response> fetchPostsThread({required String postId}) async {
    return await dioClient.get(
      ApiEndpoints.fetchPostsThread.replaceFirst(':postId', postId),
    );
  }

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
