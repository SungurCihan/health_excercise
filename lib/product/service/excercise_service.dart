import 'package:dio/dio.dart';
import 'package:health_excercise/feature/auth/model/excercise.dart';
import 'package:health_excercise/product/init/cache/shared_manager.dart';
import 'package:health_excercise/product/service/dio.dart';

/// Excercise service
class ExcerciseService {
  /// Save excercise
  static Future<bool> saveExcercise(DateTime date) async {
    try {
      final response = await dio().post(
        'https://45.147.46.202/api/exercise/save',
        options: Options(
          headers: {
            'Authorization': 'Bearer ${await SharedManager.getJwtToken()}',
          },
        ),
        data: {
          'calories': 'string',
          'exerciseName': 'string',
          'exerciseDate': date.toIso8601String(),
          'doneExercise': false,
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
        'https://45.147.46.202/api/exercise/getAll',
        options: Options(
          headers: {
            'Authorization': 'Bearer ${await SharedManager.getJwtToken()}',
          },
        ),
      );

      if (response.statusCode == 200) {
        final exercises = (response.data as List).map((element) {
          return Excercise(
            id: element['id'] as int,
            excerciseDate: element['exerciseDate'] == null
                ? DateTime.now()
                : DateTime.parse(element['exerciseDate'].toString()),
            doneExercise: element['doneExercise'] as bool,
            calories: element['calories'].toString(),
            testResult: element['testResult'].toString(),
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

  /// Update excercise
  static Future<bool> updateExcerciseDate(int id, DateTime newDate) async {
    try {
      final resposne = await dio().put<void>(
        'https://45.147.46.202/api/exercise/update/$id',
        options: Options(
          headers: {
            'Authorization': 'Bearer ${await SharedManager.getJwtToken()}',
          },
        ),
        data: {
          'exerciseDate': newDate.toIso8601String(),
        },
      );

      if (resposne.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
      // print(e);
    }
  }

  /// Update excercise
  static Future<bool> updateExcerciseIsDone(
    int id,
    bool isDone,
  ) async {
    try {
      final resposne = await dio().put<void>(
        'https://45.147.46.202/api/exercise/update/$id',
        options: Options(
          headers: {
            'Authorization': 'Bearer ${await SharedManager.getJwtToken()}',
          },
        ),
        data: {
          'doneExercise': isDone,
        },
      );

      if (resposne.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
      // print(e);
    }
  }

  /// Update excercise
  static Future<bool> updateExcerciseCalory(
    int id,
    String calory,
    DateTime date,
    String testResult,
  ) async {
    try {
      final resposne = await dio().put<void>(
        'https://45.147.46.202/api/exercise/update/$id',
        options: Options(
          headers: {
            'Authorization': 'Bearer ${await SharedManager.getJwtToken()}',
          },
        ),
        data: {
          'calories': calory,
          'doneExercise': true,
          'exerciseDate': date.toIso8601String(),
          'testResult': testResult,
        },
      );

      if (resposne.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
      // print(e);
    }
  }
}
