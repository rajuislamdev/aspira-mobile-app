import 'package:aspira/core/config/environment.dart';
import 'package:aspira/core/network/dio_interceptors.dart';
import 'package:aspira/core/utils/app_constants.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'dio_error_handler.dart';

final dioClientProvider = Provider((ref) => DioClient());

class DioClient {
  final Dio _dio;

  DioClient()
    : _dio =
          Dio(
              BaseOptions(
                sendTimeout: AppConstants.sendTimeOut,
                receiveTimeout: AppConstants.receiveTimeOut,
                connectTimeout: AppConstants.connectTimeOut,
                baseUrl: EnvironmentConfig.apiBaseUrl,
                responseType: ResponseType.json,
              ),
            )
            ..interceptors.add(LogInterceptor(responseBody: true, requestBody: true))
            ..interceptors.add(DioInterceptors());

  Future<Response> get(String endpoint, {Map<String, dynamic>? params}) async {
    try {
      return await _dio.get(endpoint, queryParameters: params);
    } catch (error) {
      throw DioErrorHandler.handleError(error);
    }
  }

  Future<Response> post(String endpoint, {dynamic data}) async {
    try {
      return await _dio.post(endpoint, data: data);
    } catch (error) {
      throw DioErrorHandler.handleError(error);
    }
  }

  Future<Response> put(String endpoint, {dynamic data}) async {
    try {
      return await _dio.put(endpoint, data: data);
    } catch (error) {
      throw DioErrorHandler.handleError(error);
    }
  }

  Future<Response> delete(String endpoint, {dynamic data}) async {
    try {
      return await _dio.delete(endpoint, data: data);
    } catch (error) {
      throw DioErrorHandler.handleError(error);
    }
  }

  Future<Response> patch(String endpoint, {dynamic data}) async {
    try {
      return await _dio.patch(endpoint, data: data);
    } catch (error) {
      throw DioErrorHandler.handleError(error);
    }
  }
}
