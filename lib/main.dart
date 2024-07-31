import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_excercise/product/init/app_init.dart';
import 'package:health_excercise/product/init/localization/product_localization.dart';
import 'package:health_excercise/product/init/state_init.dart';
import 'package:health_excercise/product/init/theme/custom_dark_theme.dart';
import 'package:health_excercise/product/init/theme/custom_light_theme.dart';
import 'package:health_excercise/product/navigation/app_router.dart';
import 'package:health_excercise/product/state/view_model/product_view_model.dart';
import 'package:widgets/widgets.dart';

Future<void> main() async {
  HttpOverrides.global = MyHttpOverrides();
  await AppInit().make();

  runApp(ProductLocalization(child: const StateInit(child: MyApp())));
}

/// s
class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
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
      themeMode: context.watch<ProductViewModel>().state.themeMode,
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      debugShowCheckedModeBanner: false,
    );
  }
}
