import 'package:aspira/core/network/api_endpoints.dart';
import 'package:aspira/core/network/dio_client.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final authServiceProvider = Provider((ref) => AuthService(dioClient: ref.read(dioClientProvider)));

class AuthService {
  final DioClient dioClient;
  AuthService({required this.dioClient});

  Future<Response> register({required Map<String, dynamic> payload}) async {
    return await dioClient.post(ApiEndpoints.register, data: payload);
  }

  Future<Response> login({required Map<String, dynamic> payload}) async {
    return await dioClient.post(ApiEndpoints.login, data: payload);
  }
}
