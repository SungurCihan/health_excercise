import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:easy_logger/easy_logger.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:health_excercise/product/init/cache/general_data.dart';
import 'package:health_excercise/product/init/config/app_enviroment.dart';
import 'package:health_excercise/product/navigation/app_router.dart';
import 'package:health_excercise/product/state/container/product_state_container.dart';
import 'package:kartal/kartal.dart';
import 'package:logger/logger.dart';

@immutable

/// When app init, this class will be called
final class AppInit {
  /// This method will be called when app init
  Future<void> make() async {
    WidgetsFlutterBinding.ensureInitialized();
    await runZonedGuarded(
      _init,
      (error, stack) {
        Logger().e(error.toString());
      },
    );
  }

  /// This method will be called when app init
  Future<void> _init() async {
    await EasyLocalization.ensureInitialized();
    EasyLocalization.logger.enableLevels = [LevelMessages.error];
    await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    await DeviceUtility.instance.initPackageInfo(); // Kartal paketi kullanımı

    FlutterError.onError = (details) {
      Logger().e(details.exceptionAsString());
    };

    final appRouter = AppRouter();
    await appRouter.getDataUsage();

    AppEnviorment.general();

    await GeneralData().getDataUsage();

    // it must be called after AppEnviorment.general();
    ProductContainer.setup();
  }
}
