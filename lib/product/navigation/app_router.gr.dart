// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

part of 'app_router.dart';

abstract class _$AppRouter extends RootStackRouter {
  // ignore: unused_element
  _$AppRouter({super.navigatorKey});

  @override
  final Map<String, PageFactory> pagesMap = {
    BottomNavigationBarRoute.name: (routeData) {
      final args = routeData.argsAs<BottomNavigationBarRouteArgs>(
          orElse: () => const BottomNavigationBarRouteArgs());
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: BottomNavigationBarView(key: args.key),
      );
    },
    DataUsageRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const DataUsageView(),
      );
    },
    ExerciseRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const ExerciseView(),
      );
    },
    HomeRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const HomeView(),
      );
    },
    SunnyDayRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const SunnyDayView(),
      );
    },
    SurveyAfterExcerciseRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const SurveyAfterExcerciseView(),
      );
    },
  };
}

/// generated route for
/// [BottomNavigationBarView]
class BottomNavigationBarRoute
    extends PageRouteInfo<BottomNavigationBarRouteArgs> {
  BottomNavigationBarRoute({
    Key? key,
    List<PageRouteInfo>? children,
  }) : super(
          BottomNavigationBarRoute.name,
          args: BottomNavigationBarRouteArgs(key: key),
          initialChildren: children,
        );

  static const String name = 'BottomNavigationBarRoute';

  static const PageInfo<BottomNavigationBarRouteArgs> page =
      PageInfo<BottomNavigationBarRouteArgs>(name);
}

class BottomNavigationBarRouteArgs {
  const BottomNavigationBarRouteArgs({this.key});

  final Key? key;

  @override
  String toString() {
    return 'BottomNavigationBarRouteArgs{key: $key}';
  }
}

/// generated route for
/// [DataUsageView]
class DataUsageRoute extends PageRouteInfo<void> {
  const DataUsageRoute({List<PageRouteInfo>? children})
      : super(
          DataUsageRoute.name,
          initialChildren: children,
        );

  static const String name = 'DataUsageRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [ExerciseView]
class ExerciseRoute extends PageRouteInfo<void> {
  const ExerciseRoute({List<PageRouteInfo>? children})
      : super(
          ExerciseRoute.name,
          initialChildren: children,
        );

  static const String name = 'ExerciseRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [HomeView]
class HomeRoute extends PageRouteInfo<void> {
  const HomeRoute({List<PageRouteInfo>? children})
      : super(
          HomeRoute.name,
          initialChildren: children,
        );

  static const String name = 'HomeRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [SunnyDayView]
class SunnyDayRoute extends PageRouteInfo<void> {
  const SunnyDayRoute({List<PageRouteInfo>? children})
      : super(
          SunnyDayRoute.name,
          initialChildren: children,
        );

  static const String name = 'SunnyDayRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [SurveyAfterExcerciseView]
class SurveyAfterExcerciseRoute extends PageRouteInfo<void> {
  const SurveyAfterExcerciseRoute({List<PageRouteInfo>? children})
      : super(
          SurveyAfterExcerciseRoute.name,
          initialChildren: children,
        );

  static const String name = 'SurveyAfterExcerciseRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}
