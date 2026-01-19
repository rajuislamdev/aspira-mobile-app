import 'package:aspira/core/network/api_endpoints.dart';
import 'package:aspira/core/network/dio_client.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final profileOptionServiceProvider = Provider(
  (ref) => ProfileOptionService(dioClient: ref.read(dioClientProvider)),
);

class ProfileOptionService {
  final DioClient dioClient;

  ProfileOptionService({required this.dioClient});

  Future<Response> fetchProfileOptions() async {
    return await dioClient.get(ApiEndpoints.fetchProfileOptions);
  }
}
