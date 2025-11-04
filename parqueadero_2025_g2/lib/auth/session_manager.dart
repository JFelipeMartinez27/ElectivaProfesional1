import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SessionManager {
  static const _secure = FlutterSecureStorage();

  static const String keyAccessToken = 'access_token';
  static const String keyRefreshToken = 'refresh_token';

  static const String keyUserName = 'user_name';
  static const String keyUserEmail = 'user_email';

  // Tokens (secure)
  static Future<void> saveTokens({required String accessToken, String? refreshToken}) async {
    await _secure.write(key: keyAccessToken, value: accessToken);
    if (refreshToken != null) {
      await _secure.write(key: keyRefreshToken, value: refreshToken);
    }
  }

  static Future<String?> getAccessToken() => _secure.read(key: keyAccessToken);

  static Future<void> clearTokens() async {
    await _secure.delete(key: keyAccessToken);
    await _secure.delete(key: keyRefreshToken);
  }

  // User data (non-sensitive)
  static Future<void> saveUser({required String name, required String email}) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(keyUserName, name);
    await prefs.setString(keyUserEmail, email);
  }

  static Future<Map<String, String?>> getUser() async {
    final prefs = await SharedPreferences.getInstance();
    return {
      'name': prefs.getString(keyUserName),
      'email': prefs.getString(keyUserEmail),
    };
  }

  static Future<void> clearUser() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(keyUserName);
    await prefs.remove(keyUserEmail);
  }

  static Future<void> clearAll() async {
    await clearTokens();
    await clearUser();
  }
}
