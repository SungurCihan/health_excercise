import 'package:health_excercise/product/service/dio.dart';

/// Excercise service
class ExcerciseService {
  /// Get courier coordinates
  static Future<void> getCourierCoords() async {
    // ignore: inference_failure_on_function_invocation
    final response =
        await dio().get('http://165.232.75.224:8080/api/exercise/getAll');

    if (response.statusCode == 200) {}
  }
}
