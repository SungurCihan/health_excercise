import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_excercise/feature/auth/model/user.dart';
import 'package:health_excercise/feature/auth/viewmodel/user_cubit.dart';
import 'package:health_excercise/product/init/cache/shared_manager.dart';
import 'package:health_excercise/product/service/dio.dart';

/// Auth service
class AuthService {
  /// register
  static Future<bool> register(String username, String password) async {
    try {
      final response = await dio().post(
        'https://45.147.46.202/auth/saveuser',
        data: {
          'username': username,
          'password': password,
          'name': 'string',
          'surname': 'string',
          'email': 'string',
          'generalAnlysisRegion': 'string',
          'age': 'string',
          'weight': 0,
          'height': 0,
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

  /// login
  static Future<bool> login(
    BuildContext context,
    String username,
    String password,
  ) async {
    try {
      final response = await dio().post(
        'https://45.147.46.202/api/user/login',
        data: {
          'username': username,
          'password': password,
        },
      );

      if (response.statusCode == 200) {
        final data = response.data as Map<String, dynamic>;
        await SharedManager.setJwtToken(
          token: data['jwtToken'].toString(),
        );

        final result = await getUser();

        if (result != null && context.mounted) {
          context.read<UserCubit>().setUser(result);
        }

        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  /// get user
  static Future<User?> getUser() async {
    try {
      final response = await dio().get(
        'https://45.147.46.202/api/user/get',
        options: Options(
          headers: {
            'Authorization': 'Bearer ${await SharedManager.getJwtToken()}',
          },
        ),
      );

      if (response.statusCode == 200) {
        return User(
          name: response.data['name'].toString(),
          surname: response.data['surname'].toString(),
          password: response.data['password'].toString(),
          email: response.data['email'].toString(),
          generalAnlysisRegion:
              response.data['generalAnalysisRegion'].toString(),
          age: response.data['age'].toString(),
          weight: response.data['weight'] as int,
          height: response.data['height'] as int,
        );
      }
    } catch (e) {
      print(e);
    }
    return null;
  }

  /// update user
  static Future<User?> updateUser(User user) async {
    try {
      final response = await dio().put(
        'https://45.147.46.202/api/user/update',
        data: user.toJson(),
        options: Options(
          headers: {
            'Authorization': 'Bearer ${await SharedManager.getJwtToken()}',
          },
        ),
      );

      if (response.statusCode == 200) {
        // return User.fromJson(response.data);
      }
    } catch (e) {
      print(e);
    }
    return null;
  }
}
