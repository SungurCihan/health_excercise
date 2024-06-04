import 'package:health_excercise/product/init/cache/shared_manager.dart';

/// General Data
class GeneralData {
  /// Did Data Usage accepted
  static bool dataUsage = false;

  /// Get Data Usage Info
  Future<void> getDataUsage() async {
    dataUsage = await SharedManager.getDataUsage();
  }
}
