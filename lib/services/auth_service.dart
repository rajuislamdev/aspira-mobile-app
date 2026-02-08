import 'package:aspira/core/config/environment.dart';
import 'package:aspira/core/network/api_endpoints.dart';
import 'package:aspira/core/network/dio_client.dart';
import 'package:aspira/core/utils/app_logger.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';

final authServiceProvider = Provider(
  (ref) => AuthService(dioClient: ref.read(dioClientProvider)),
);

class AuthService {
  final DioClient dioClient;

  AuthService({required this.dioClient}) {
    GoogleSignIn.instance.initialize(
      clientId: EnvironmentConfig.clientId,
      serverClientId: EnvironmentConfig.serverClientId,
    );
  }

  Future<Response> register({required Map<String, dynamic> payload}) async {
    return await dioClient.post(ApiEndpoints.register, data: payload);
  }

  Future<Response> login({required Map<String, dynamic> payload}) async {
    return await dioClient.post(ApiEndpoints.login, data: payload);
  }

  Future<Response> updateProfile({
    required Map<String, dynamic> payload,
  }) async {
    return await dioClient.patch(ApiEndpoints.user, data: payload);
  }

  Future<String?> getGoogleIdToken() async {
    final google = GoogleSignIn.instance;
    try {
      final account = await google.authenticate();
      final auth = account.authentication;
      AppLogger.printWrapped('Google ID Token: ${auth.idToken}');
      return auth.idToken;
    } catch (e) {
      print('Google Sign In Error: $e');
      AppLogger.printWrapped(e.toString());
      rethrow;
    }
  }

  Future<Response> loginWithGoogle({required String idToken}) async {
    return await dioClient.post(
      ApiEndpoints.loginWithGoogle,
      data: {"idToken": idToken},
    );
  }
}
