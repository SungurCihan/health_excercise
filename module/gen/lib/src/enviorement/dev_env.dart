import 'package:envied/envied.dart';
import 'package:gen/src/enviorement/app_configuration.dart';

part 'dev_env.g.dart';

@Envied(
  obfuscate: true,
  path: 'assets/env/.dev.env',
)

/// This class is used to store the environment variables for the development environment.
final class DevEnv implements AppConfiguration {
  @EnviedField(varName: 'BASE_URL')

  /// The base URL for the API.
  static final String _baseUrl = _DevEnv._baseUrl;

  /// The API key.
  @EnviedField(varName: 'API_KEY')
  static final String _apiKey = _DevEnv._apiKey;

  @override
  String get baseUrl => _baseUrl;

  @override
  String get apiKey => _apiKey;
}
