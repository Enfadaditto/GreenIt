import 'package:shared_preferences/shared_preferences.dart';

class CacheManager {
  static const String usernameKey = 'username';
  static const String darkModeKey = 'darkMode';
  static const String emailKey = 'email';
  static const String userIdKey = 'userId';

  // Read user preferences: username
  static Future<String> getUsername() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(usernameKey) ?? "";
  }

  // Save user preferences: username
  static Future<void> setUsername(String username) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(usernameKey, username);
  }

  // Read user preferences: email address
  static Future<String?> getEmail() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(emailKey);
  }

  // Save user preferences: email address
  static Future<void> setEmail(String email) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(emailKey, email);
  }

  // Save user ID in cache
  static Future<void> setUserId(int userId) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setInt(userIdKey, userId);
  }

  // Get user ID from cache
  static Future<int?> getUserId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(userIdKey);
  }

  // Read user preferences: dark mode
  static Future<bool> getDarkMode() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(darkModeKey) ?? false;
  }

  // Save user preferences: dark mode
  static Future<void> setDarkMode(bool darkMode) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool(darkModeKey, darkMode);
  }
}
