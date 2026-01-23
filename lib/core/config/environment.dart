import 'package:flutter/material.dart';

class EnvironmentConfig {
  static const String environment = String.fromEnvironment('ENV', defaultValue: 'DEV');
  static const String apiBaseUrl = String.fromEnvironment(
    'API_BASE_URL',
    defaultValue: 'http://192.168.0.170:5001/api',
  );

  static const String clientId = String.fromEnvironment('CLIENT_ID');
  static const String serverClientId = String.fromEnvironment('SERVER_CLIENT_ID');

  static bool get isDev => environment == 'DEV';

  static bool get isProduction => environment == 'PROD';

  static Color get bannerColor => isDev ? Colors.red : Colors.green;
}
