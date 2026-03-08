import 'package:aspira/core/network/api_endpoints.dart';
import 'package:aspira/core/network/dio_client.dart';
import 'package:dio/dio.dart';

abstract class ProfileRemoteDataSource {
  Future<Response> fetchProfile();
  Future<Response> updateProfile({
    required String userId,
    required Map<String, dynamic> payload,
  });

  Future<Response> fetchInterest();
}

class ProfileRemoteDataSourceImpl implements ProfileRemoteDataSource {
  final DioClient dioClient;

  ProfileRemoteDataSourceImpl({required this.dioClient});

  @override
  Future<Response> fetchProfile() async {
    return await dioClient.get(ApiEndpoints.user);
  }

  @override
  Future<Response> updateProfile({
    required String userId,
    required Map<String, dynamic> payload,
  }) async {
    return await dioClient.patch(ApiEndpoints.user, data: payload);
  }

  @override
  Future<Response> fetchInterest() async {
    return await dioClient.get(ApiEndpoints.fetchProfileOptions);
  }
}
