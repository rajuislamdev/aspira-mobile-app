import 'package:flutter/foundation.dart';

class AppLogger {
  static void debug(String message) {
    if (kDebugMode) print('[DEBUG] $message');
  }

  static void error(String message) {
    if (kDebugMode) print('[ERROR] $message');
  }
}
