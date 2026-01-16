import 'package:hive_flutter/hive_flutter.dart';

class LocalStorageService {
  static final LocalStorageService _instance = LocalStorageService.internal();
  factory LocalStorageService() => _instance;
  LocalStorageService.internal();

  // Box

  static const String authBoxName = 'auth_box';
  static const String settingsBoxName = 'settings_box';

  late Box _authBox;
  late Box _settingsBox;

  // Getters for boxes
  Box get authBox => _authBox;
  Box get settingsBox => _settingsBox;

  // Initialize Hive and open boxes
  Future<void> init() async {
    await Hive.initFlutter();

    try {
      _authBox = await Hive.openBox(authBoxName);
    } catch (e) {
      await Hive.deleteBoxFromDisk(authBoxName);
      _authBox = await Hive.openBox(authBoxName);
    }

    try {
      _settingsBox = await Hive.openBox(settingsBoxName);
    } catch (e) {
      await Hive.deleteBoxFromDisk(settingsBoxName);
      _settingsBox = await Hive.openBox(settingsBoxName);
    }
  }

  Future<void> saveToken(String token) async {
    await _authBox.put('auth_token', token);
  }

  Future<String?> getToken() async {
    return _authBox.get('auth_token');
  }

  Future<void> saveIsOnboardingComplete(bool isOnboardingComplete) async {
    await _settingsBox.put('is_onboarding_complete', isOnboardingComplete);
  }

  Future<bool?> getIsOnboardingComplete() async {
    return _settingsBox.get('is_onboarding_complete');
  }

  // Clear all data from boxes
  Future<void> clearAllData() async {
    await _authBox.clear();
    await _settingsBox.clear();
  }

  // Close boxes
  Future<void> close() async {
    await _authBox.close();
    await _settingsBox.close();
  }

  // Delete boxes from disk
  Future<void> deleteBoxesFromDisk() async {
    await Hive.deleteBoxFromDisk(authBoxName);
    await Hive.deleteBoxFromDisk(settingsBoxName);
  }
}
