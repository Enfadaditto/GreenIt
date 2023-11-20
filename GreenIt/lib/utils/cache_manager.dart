import 'package:shared_preferences/shared_preferences.dart';

class CacheManager {
  static const String usernameKey = 'username';
  static const String darkModeKey = 'darkMode';
  static const String emailKey = 'email';
  static const String userIdKey = 'userId';

  // Odczytuje preferencje użytkownika: nazwę użytkownika
  static Future<String?> getUsername() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(usernameKey);
  }

  // Zapisuje preferencje użytkownika: nazwę użytkownika
  static Future<void> setUsername(String username) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(usernameKey, username);
  }

  // Odczytuje preferencje użytkownika: adres e-mail
  static Future<String?> getEmail() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(emailKey);
  }

  // Zapisuje preferencje użytkownika: adres e-mail
  static Future<void> setEmail(String email) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(emailKey, email);
  }

  // Zapisz ID użytkownika w pamięci podręcznej
  static Future<void> setUserId(int userId) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(userIdKey, userId);
  }

  // Pobierz ID użytkownika z pamięci podręcznej
  static Future<int?> getUserId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(userIdKey);
  }

  // Odczytuje preferencje użytkownika: tryb ciemny
  static Future<bool> getDarkMode() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(darkModeKey) ?? false;
  }

  // Zapisuje preferencje użytkownika: tryb ciemny
  static Future<void> setDarkMode(bool darkMode) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(darkModeKey, darkMode);
  }
}
