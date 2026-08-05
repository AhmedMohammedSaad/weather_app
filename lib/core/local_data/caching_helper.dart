import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:nb_utils/nb_utils.dart';

/// Helper class for managing local cached data (secure storage & shared preferences).
class AppCacheHelper {
  static final FlutterSecureStorage _storage = const FlutterSecureStorage(
    aOptions: AndroidOptions(
      encryptedSharedPreferences: true,
    ),
    iOptions: IOSOptions(
      accessibility: KeychainAccessibility.first_unlock,
    ),
  );

  // Keys for secure storage (sensitive data)
  static const String accessTokenKey = 'accessToken';
  static const String refreshTokenKey = 'refreshToken';
  static const String resetTokenKey = 'resetToken';
  static const String userKey = 'localUser';
  static const String userUuid = 'userUuid';
  static const String restaurantUuid = 'restaurantUuid';

  // Keys for regular storage (non-sensitive data)
  static const String onBoardingKey = 'onBoardingShow';
  static const String isDark = 'isDark';
  static const String userRoleKey = 'userRole';
  static const String userPhoneKey = 'userPhone';
  static const String hasCompletedProfileKey = 'hasCompletedProfile';
  static const String currentProfileInfoStepKey = 'currentProfileInfoStep';
  static const String guestKey = 'guest';
  static const String resurantKey = 'resurantKey';
  static const String restaurantDomain = 'restaurantDomain';
  static const String fcmToken = 'fcmToken';
  
  // Weather Caching Keys
  static const String lastWeatherDataKey = 'lastWeatherData';

  /// Saves registration user data into local storage.
  static Future<void> saveRegistrationData({
    required String token,
    required String refreshToken,
    required String userRole,
    required String userPhone,
    required String userUuid,
  }) async {
    try {
      await cacheSecureString(key: accessTokenKey, value: token);
      await cacheSecureString(key: refreshTokenKey, value: refreshToken);
      await cacheSecureString(key: userUuid, value: userUuid);

      cacheString(key: userRoleKey, value: userRole);
      cacheString(key: userPhoneKey, value: userPhone);
      cacheString(key: hasCompletedProfileKey, value: false);
    } catch (e) {
      rethrow;
    }
  }

  /// Marks profile completion in local cache.
  static Future<void> markProfileCompleted() async {
    try {
      cacheString(key: hasCompletedProfileKey, value: true);
    } catch (e) {
      rethrow;
    }
  }

  // --- Weather Caching Methods ---

  /// Caches the last fetched weather data for a city specifically as well as overall last search.
  static void cacheLastWeather(String cityName, Map<String, dynamic> json) {
    final jsonString = jsonEncode(json);
    cacheString(key: '${lastWeatherDataKey}_${cityName.trim().toLowerCase()}', value: jsonString);
    cacheString(key: lastWeatherDataKey, value: jsonString);
  }

  /// Retrieves cached weather JSON string specifically for [cityName].
  static String getCachedWeatherForCity(String cityName) {
    if (cityName.trim().isEmpty) return '';
    return getCacheString(key: '${lastWeatherDataKey}_${cityName.trim().toLowerCase()}');
  }

  /// Retrieves overall last searched weather.
  static String getLastWeather([String? cityName]) {
    if (cityName != null && cityName.trim().isNotEmpty) {
      final cityCache = getCachedWeatherForCity(cityName);
      if (cityCache.isNotEmpty) return cityCache;
    }
    return getCacheString(key: lastWeatherDataKey);
  }

  // --- Secure Storage Methods ---

  static Future<void> cacheSecureString({required String key, required String value}) async {
    try {
      await _storage.write(key: key, value: value);
    } catch (e) {
      cacheString(key: key, value: value);
    }
  }

  static Future<String> getSecureString({required String key}) async {
    try {
      final token = await _storage.read(key: key) ?? '';
      return token;
    } catch (e) {
      return '';
    }
  }

  static Future<void> deleteSecureCache({required String key}) async {
    try {
      await _storage.delete(key: key);
    } catch (e) {
      deleteCache(key: key);
    }
  }

  // --- Regular Storage Methods (SharedPreferences via nb_utils) ---

  static void cacheString({required String key, required dynamic value}) {
    setValue(key, value);
  }

  static String getCacheString({required String key}) {
    return getStringAsync(key);
  }

  static int getCacheInt({required String key}) {
    return getIntAsync(key);
  }

  static void deleteCache({required String key}) {
    removeKey(key);
  }

  static bool getCachedBool({required String key}) {
    return getBoolAsync(key);
  }

  // --- Helper Methods ---

  static Future<void> clearAuthData() async {
    try {
      await deleteSecureCache(key: accessTokenKey);
      await deleteSecureCache(key: refreshTokenKey);
      await deleteSecureCache(key: userUuid);
      await deleteSecureCache(key: restaurantUuid);

      deleteCache(key: userRoleKey);
      deleteCache(key: userPhoneKey);
      deleteCache(key: hasCompletedProfileKey);
    } catch (e) {
      deleteCache(key: accessTokenKey);
      deleteCache(key: restaurantUuid);
      deleteCache(key: userUuid);
      deleteCache(key: refreshTokenKey);
      deleteCache(key: userRoleKey);
      deleteCache(key: userPhoneKey);
      deleteCache(key: hasCompletedProfileKey);
    }
  }

  static Future<bool> isLoggedIn() async {
    try {
      final token = await getSecureString(key: accessTokenKey);
      final refresh = await getSecureString(key: refreshTokenKey);
      return token.isNotEmpty && refresh.isNotEmpty;
    } catch (e) {
      final token = getCacheString(key: accessTokenKey);
      final refresh = getCacheString(key: refreshTokenKey);
      return token.isNotEmpty && refresh.isNotEmpty;
    }
  }

  static Future<void> signOut() async {
    try {
      await deleteSecureCache(key: accessTokenKey);
      await deleteSecureCache(key: userUuid);
      await deleteSecureCache(key: refreshTokenKey);
      await deleteSecureCache(key: restaurantUuid);
      await deleteSecureCache(key: userKey);
      await deleteSecureCache(key: resurantKey);
      await deleteSecureCache(key: fcmToken);

      deleteCache(key: userRoleKey);
      deleteCache(key: userPhoneKey);
      deleteCache(key: guestKey);
      deleteCache(key: userKey);
      deleteCache(key: resurantKey);
      deleteCache(key: restaurantUuid);
      deleteCache(key: hasCompletedProfileKey);
      deleteCache(key: accessTokenKey);
      deleteCache(key: refreshTokenKey);
      deleteCache(key: userUuid);
      deleteCache(key: fcmToken);
    } catch (e) {
      deleteCache(key: userRoleKey);
      deleteCache(key: userPhoneKey);
      deleteCache(key: guestKey);
      deleteCache(key: userKey);
      deleteCache(key: resurantKey);
      deleteCache(key: restaurantUuid);
      deleteCache(key: hasCompletedProfileKey);
      deleteCache(key: accessTokenKey);
      deleteCache(key: refreshTokenKey);
      deleteCache(key: userUuid);
      deleteCache(key: fcmToken);
    }
  }
}
