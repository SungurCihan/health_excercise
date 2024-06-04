import 'dart:io';

import 'package:flutter/widgets.dart';

/// Manage your network error with screen
final class ProductNetworkErrorManager {
  /// Manage your network error with screen
  ProductNetworkErrorManager(this.context);

  /// BuildContext
  final BuildContext context;

  /// Error Handling
  void handleError(int value) {
    if (value == HttpStatus.unauthorized) {
      //
    }
  }
}
