import 'dart:io';

import 'package:dio/dio.dart';

import '../errors/exceptions.dart';

class DioErrorHandler {
  static Exception handleError(dynamic error) {
    if (error is Exception) {
      try {
        if (error is DioException) {
          switch (error.type) {
            case DioExceptionType.connectionTimeout:
              return ServerException('Connection timeout. Please try again.');
            case DioExceptionType.sendTimeout:
              return ServerException('Send timeout. Please try again.');
            case DioExceptionType.receiveTimeout:
              return ServerException('Receive timeout. Please try again.');
            case DioExceptionType.cancel:
              return ServerException('Request was cancelled.');
            case DioExceptionType.badResponse:
              final statusCode = error.response?.statusCode;
              final message = _handleStatusCode(statusCode, error.response);
              return ServerException(message);
            default:
              return ServerException('Unexpected network error occurred.');
          }
        } else if (error is SocketException) {
          return ServerException(
            'No Internet connection. Please check your network.',
          );
        } else {
          return ServerException('Unexpected error occurred.');
        }
      } catch (e) {
        return ServerException('Error parsing server response.');
      }
    } else {
      return ServerException('Unknown error occurred.');
    }
  }

  static String _handleStatusCode(int? statusCode, Response? response) {
    final serverMessage = response?.data is Map<String, dynamic>
        ? response?.data['error']?.toString()
        : null;

    switch (statusCode) {
      case 400:
        return serverMessage ?? 'Bad Request';
      case 401:
        return serverMessage ?? 'Unauthorized request. Please log in again.';
      case 403:
        return serverMessage ?? 'Access denied.';
      case 404:
        return serverMessage ?? 'Resource not found.';
      case 500:
        return serverMessage ?? 'Internal server error.';
      default:
        return serverMessage ?? 'Something went wrong. Please try again.';
    }
  }
}
