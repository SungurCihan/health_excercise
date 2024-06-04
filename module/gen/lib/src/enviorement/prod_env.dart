import 'package:envied/envied.dart';
import 'package:gen/src/enviorement/app_configuration.dart';

part 'prod_env.g.dart';

@Envied(
  obfuscate: true,
  path: 'assets/env/.prod.env',
)

/// This class is used to store the environment variables for the production environment.
final class ProdEnv implements AppConfiguration {
  @EnviedField(varName: 'BASE_URL')

  /// The base URL for the API.
  static final String _baseUrl = _ProdEnv._baseUrl;

  @EnviedField(varName: 'API_KEY')

  /// The API key.
  static final String _apiKey = _ProdEnv._apiKey;

  @override
  String get baseUrl => _baseUrl;

  @override
  String get apiKey => _apiKey;
}
