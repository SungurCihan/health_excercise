import 'package:device_preview/device_preview.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:health_excercise/product/init/app_init.dart';
import 'package:health_excercise/product/init/localization/product_localization.dart';
import 'package:health_excercise/product/init/theme/custom_dark_theme.dart';
import 'package:health_excercise/product/init/theme/custom_light_theme.dart';
import 'package:health_excercise/product/navigation/app_router.dart';
import 'package:widgets/widgets.dart';

Future<void> main() async {
  await AppInit().make();

  runApp(
    DevicePreview(
      builder: (context) => ProductLocalization(child: const MyApp()),
    ),
  );
}

/// MyApp
final class MyApp extends StatelessWidget {
  /// MyApp constructor
  const MyApp({super.key});

  static final _appRoute = AppRouter();

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: _appRoute.config(),
      theme: CustomLightTheme().themeData,
      darkTheme: CustomDarkTheme().themeData,
      builder: CustomResponsive.build,
      themeMode: ThemeMode.light,
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
    );
  }
}
