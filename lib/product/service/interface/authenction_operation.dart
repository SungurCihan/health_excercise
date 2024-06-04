import 'package:gen/gen.dart';

/// The operation for the authentication.
abstract class AuthenticationOperation {
  /// Get the users.
  Future<List<User>> users();
}
