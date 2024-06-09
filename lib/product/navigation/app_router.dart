import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:health_excercise/feature/auth/view/login_view.dart';
import 'package:health_excercise/feature/auth/view/regitser_view.dart';
import 'package:health_excercise/feature/bottom_navigation_bar/view/bottom_navigation_bar_view.dart';
import 'package:health_excercise/feature/exercise/view/exercise_view.dart';
import 'package:health_excercise/feature/exercise/view/sunny_day_view.dart';
import 'package:health_excercise/feature/exercise/view/survey_after_excercise_view.dart';
import 'package:health_excercise/feature/exercise/view/test_excercise_view.dart';
import 'package:health_excercise/feature/home/view/data_usage_view.dart';
import 'package:health_excercise/feature/home/view/home2_view.dart';
import 'package:health_excercise/feature/profile/view/personal_info_view.dart';
import 'package:health_excercise/product/init/cache/general_data.dart';
import 'package:health_excercise/product/init/cache/shared_manager.dart';

part 'app_router.gr.dart';

/// App router
@AutoRouterConfig(replaceInRouteName: 'View,Route')
class AppRouter extends _$AppRouter {
  /// Did Data Usage accepted
  late bool dataUsage;

  /// Get Data Usage Info
  Future<void> getDataUsage() async {
    dataUsage = await SharedManager.getDataUsage();
  }

  @override
  List<AutoRoute> get routes => [
        AutoRoute(
          page: RegisterRoute.page,
        ),
        AutoRoute(
          page: BottomNavigationBarRoute.page,
          initial: GeneralData.isLogged,
        ),
        AutoRoute(
          page: ExerciseRoute.page,
        ),
        AutoRoute(
          page: DataUsageRoute.page,
        ),
        AutoRoute(
          page: SunnyDayRoute.page,
        ),
        AutoRoute(
          page: SurveyAfterExcerciseRoute.page,
        ),
        AutoRoute(
          page: LoginRoute.page,
          initial: !GeneralData.isLogged,
        ),
        AutoRoute(
          page: PersonalInfoRoute.page,
        ),
      ];
}
