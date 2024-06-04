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
}
