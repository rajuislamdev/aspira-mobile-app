import 'package:aspira/core/utils/app_logger.dart';
import 'package:aspira/services/local_store_service.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class DioInterceptors extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    super.onRequest(options, handler);
    AppLogger.debug('REQUEST[${options.method}] => PATH: ${options.path}');
    // pass token to request headers
    options.headers['Authorization'] =
        'Bearer ${LocalStorageService().authBox.get('auth_token')}';
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    super.onResponse(response, handler);
    AppLogger.debug(
      'RESPONSE[${response.statusCode}] => PATH: ${response.requestOptions.path}',
    );
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    super.onError(err, handler);
    AppLogger.debug(
      'ERROR LOG[${err.response?.statusCode}] => PATH: ${err.requestOptions.path}',
    );
    // Navigate to the login page if the user is not authenticated
    if (err.response?.statusCode == 401) {
      debugPrint("Unauthorized access detected. Navigating to OAuth screen.");
      // LocalStorageService().clearToken();
      // LocalStorageService().clearStorage();
      // navigatorKey.currentState?.pushNamedAndRemoveUntil('/sign-in', (v) => false);
    }
  }
}
