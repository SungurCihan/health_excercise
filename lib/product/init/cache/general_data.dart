import 'package:health_excercise/product/init/cache/shared_manager.dart';

/// General Data
class GeneralData {
  /// Did Data Usage accepted
  static bool dataUsage = false;

  /// Is Logged
  static bool isLogged = false;

  /// Get Data Usage Info
  Future<void> getDataUsage() async {
    dataUsage = await SharedManager.getDataUsage();
  }

  /// Get Is Logged
  Future<void> getIsLogged() async {
    final token = await SharedManager.getJwtToken();

    if (token != null) {
      isLogged = true;
    }
  }

  /// Logout
  Future<void> logout() async {
    isLogged = false;
  }
}
