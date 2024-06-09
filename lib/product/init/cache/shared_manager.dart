import 'package:shared_preferences/shared_preferences.dart';

/// Shared Preferences
class SharedManager {
  /// Sets 'data_usage' key with the given answer
  static Future<void> setDataUsage({required bool answer}) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('data_usage', answer);
  }

  /// Gets 'data_usage' key
  static Future<bool> getDataUsage() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('data_usage') ?? false;
  }

  /// Sets 'jwt_token' key with the given token
  static Future<void> setJwtToken({required String token}) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('jwt_token', token);
  }

  /// Gets 'jwt_token' key
  static Future<String?> getJwtToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('jwt_token');
  }

  /// Removes 'jwt_token' key
  static Future<void> removeToken() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('jwt_token');
  }
}
