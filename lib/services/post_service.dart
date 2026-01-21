import 'package:aspira/core/network/api_endpoints.dart';
import 'package:aspira/core/network/dio_client.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final postServiceProvider = Provider((ref) => PostService(dioClient: ref.read(dioClientProvider)));

class PostService {
  final DioClient dioClient;
  PostService({required this.dioClient});

  Future<Response> createPost({required Map<String, dynamic> payload}) async {
    return await dioClient.post(ApiEndpoints.posts, data: payload);
  }
}
