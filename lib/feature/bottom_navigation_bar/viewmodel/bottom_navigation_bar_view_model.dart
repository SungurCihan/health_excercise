import 'package:flutter/material.dart';
import 'package:health_excercise/feature/activity/view/activity_view.dart';
import 'package:health_excercise/feature/bottom_navigation_bar/viewmodel/state/bottom_navigation_bar_state.dart';
import 'package:health_excercise/feature/calendar/view/calendar_view.dart';
import 'package:health_excercise/feature/home/view/home_view.dart';
import 'package:health_excercise/feature/profile/view/profile_view.dart';
import 'package:health_excercise/product/state/base/base_cubit.dart';

/// BottomNavigationBarViewModel
final class BottomNavigationBarViewModel
    extends BaseCubit<BottomNavigationBarState> {
  /// BottomNavigationBarViewModel constructor
  BottomNavigationBarViewModel()
      : super(const BottomNavigationBarState(currentPage: 0));

  /// Pages for bottom navigation bar
  List<Widget> get pages => [
        const HomeView(),
        const ActivityView(),
        const CalendarView(),
        const ProfileView(),
      ];

  /// Change page
  void changePage(int index) {
    emit(state.copyWith(currentPage: index));
  }
}
