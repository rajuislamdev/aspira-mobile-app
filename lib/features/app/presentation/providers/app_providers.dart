import 'package:aspira/services/local_store_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Provider for the local storage service instance
final localStorageServiceProvider = Provider<LocalStorageService>((ref) {
  return LocalStorageService();
});
