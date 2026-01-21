import 'package:aspira/core/network/api_endpoints.dart';
import 'package:aspira/core/network/dio_client.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final profileServiceProvider = Provider(
  (ref) => ProfileService(dioClient: ref.read(dioClientProvider)),
);

class ProfileService {
  final DioClient dioClient;
  ProfileService({required this.dioClient});

  Future<Response> fetchProfile() async {
    return await dioClient.get(ApiEndpoints.user);
  }
}
