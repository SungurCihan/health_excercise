import 'package:dio/dio.dart';
import 'package:health_excercise/feature/auth/model/excercise.dart';
import 'package:health_excercise/product/init/cache/shared_manager.dart';
import 'package:health_excercise/product/service/dio.dart';

/// Excercise service
class ExcerciseService {
  /// Get excercise
  static Future<bool> saveExcercise(DateTime date) async {
    try {
      final response = await dio().post(
        'http://165.232.75.224:8080/api/exercise/save',
        options: Options(
          headers: {
            'Authorization': 'Bearer ${await SharedManager.getJwtToken()}',
          },
        ),
        data: {
          'calories': 'string',
          'exerciseName': 'string',
          'exerciseDate': date.toIso8601String(),
          'doneExercise': true,
        },
      );

      if (response.statusCode == 200) {
        final data = response.data as Map<String, dynamic>;
        // await SharedManager.setJwtToken(
        //   token: data['jwtToken'].toString(),
        // );

        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  /// Get excercise
  static Future<List<Excercise>?> getExcercise() async {
    try {
      final response = await dio().get(
        'http://165.232.75.224:8080/api/exercise/getAll',
        options: Options(
          headers: {
            'Authorization': 'Bearer ${await SharedManager.getJwtToken()}',
          },
        ),
      );

      if (response.statusCode == 200) {
        final exercises = (response.data as List).map((element) {
          return Excercise(
            excerciseDate:
                DateTime.parse(element['exerciseDate'].toString()).toString(),
            doneExercise: element['doneExercise'] as bool,
          );
        }).toList();

        return exercises;
      } else {
        return null;
      }
    } catch (e) {
      print(e);
    }
    return null;
  }
}
