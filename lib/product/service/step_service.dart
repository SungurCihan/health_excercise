import 'package:dio/dio.dart';
import 'package:health_excercise/product/init/cache/shared_manager.dart';
import 'package:health_excercise/product/service/dio.dart';

/// Step Service
class StepService {
  /// Save step
  static Future<bool> saveStep(
    int excerciseId,
    int stepCount,
    DateTime date,
  ) async {
    try {
      final response = await dio().post(
        'https://45.147.46.202/api/step/save/$excerciseId',
        options: Options(
          headers: {
            'Authorization': 'Bearer ${await SharedManager.getJwtToken()}',
          },
        ),
        data: {
          'stepName': stepCount,
          'stepDate': date.toIso8601String(),
        },
      );

      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  /// Get step
  static Future<int> getStep(
    DateTime date,
  ) async {
    try {
      final response = await dio().post(
        'https://45.147.46.202/api/step/get',
        options: Options(
          headers: {
            'Authorization': 'Bearer ${await SharedManager.getJwtToken()}',
          },
        ),
        data: {
          'startDate': date.toIso8601String(),
          'endDate': date.toIso8601String(),
        },
      );

      if (response.statusCode == 200) {
        return response.data[0]['steps'] as int;
      } else {
        return 0;
      }
    } catch (e) {
      return 0;
    }
  }
}
