import 'package:flutter/foundation.dart';
import 'package:gen/gen.dart';

/// The environment for the app.
final class AppEnviorment {
  /// Sets up the environment for the app.
  AppEnviorment.setup({required AppConfiguration config}) {
    _config = config;
  }

  /// Sets up the environment for the app.
  AppEnviorment.general() {
    _config = kDebugMode ? DevEnv() : ProdEnv();
  }

  static late final AppConfiguration _config;
}

/// The items in the environment for the app.
enum AppEnviormentItem {
  /// The base URL for the API.
  baseUrl,

  /// The API key.
  apiKey;

  /// The value of the item.
  String get value {
    try {
      switch (this) {
        case AppEnviormentItem.baseUrl:
          return AppEnviorment._config.baseUrl;
        case AppEnviormentItem.apiKey:
          return AppEnviorment._config.apiKey;
      }
    } catch (e) {
      throw Exception('AppEnviormentItem is not initialized.');
    }
  }
}
