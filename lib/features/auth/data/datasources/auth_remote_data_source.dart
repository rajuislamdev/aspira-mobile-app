import 'package:dio/dio.dart';
import 'package:aspira/core/network/api_endpoints.dart';
import 'package:aspira/core/network/dio_client.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:aspira/core/config/environment.dart';
import 'package:aspira/core/utils/app_logger.dart';

abstract class AuthRemoteDataSource {
  Future<Response> register({required Map<String, dynamic> payload});
  Future<Response> login({required Map<String, dynamic> payload});
  Future<Response> updateProfile({required Map<String, dynamic> payload});
  Future<String?> getGoogleIdToken();
  Future<Response> loginWithGoogle({required String idToken});
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final DioClient dioClient;
  final GoogleSignIn _googleSignIn;

  AuthRemoteDataSourceImpl({required this.dioClient})
    : _googleSignIn = GoogleSignIn.instance {
    _googleSignIn.initialize(
      clientId: EnvironmentConfig.clientId,
      serverClientId: EnvironmentConfig.serverClientId,
    );
  }

  @override
  Future<Response> register({required Map<String, dynamic> payload}) async {
    return await dioClient.post(ApiEndpoints.register, data: payload);
  }

  @override
  Future<Response> login({required Map<String, dynamic> payload}) async {
    return await dioClient.post(ApiEndpoints.login, data: payload);
  }

  @override
  Future<Response> updateProfile({
    required Map<String, dynamic> payload,
  }) async {
    return await dioClient.patch(ApiEndpoints.user, data: payload);
  }

  @override
  Future<String?> getGoogleIdToken() async {
    try {
      final account = await _googleSignIn.authenticate();
      final auth = account.authentication;
      AppLogger.printWrapped('Google ID Token: ${auth.idToken}');
      return auth.idToken;
    } catch (e) {
      AppLogger.printWrapped('Google Sign In Error: $e');
      rethrow;
    }
  }

  @override
  Future<Response> loginWithGoogle({required String idToken}) async {
    return await dioClient.post(
      ApiEndpoints.loginWithGoogle,
      data: {"idToken": idToken},
    );
  }
}
