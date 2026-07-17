import 'package:hive_ce/hive.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../di/injection.dart';
import '../services/storage/secure_storage_service.dart';

/// ===============================
/// Dev Tools (DEBUG ONLY)
/// Used for resetting app state
/// ===============================
class DevTools {
  /// Reset ALL app data (full clean slate)
  /// ⚠️ DEBUG ONLY - NEVER CALL IN PRODUCTION
  static Future<void> resetAll() async {
    await _clearSharedPreferences();
    await _clearSecureStorage();
    await _clearHive();
  }

  /// Reset onboarding only
  static Future<void> resetOnboarding() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_Keys.onboardingDone);
  }

  /// Reset auth session only
  static Future<void> resetAuth() async {
    final secureStorage = sl<SecureStorageService>();

    await secureStorage.delete('access_token');
    await secureStorage.delete('refresh_token');
  }

  /// ===============================
  /// Internal helpers
  /// ===============================

  static Future<void> _clearSharedPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }

  static Future<void> _clearSecureStorage() async {
    final secureStorage = sl<SecureStorageService>();
    await secureStorage.deleteAll();
  }

  static Future<void> _clearHive() async {
    await Hive.deleteFromDisk();
  }
}

/// ===============================
/// Keys (avoid magic strings)
/// ===============================
class _Keys {
  static const String onboardingDone = 'onboarding_done';
}
