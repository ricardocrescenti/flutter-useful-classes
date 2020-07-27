import 'package:flutter/foundation.dart';

/// Utilitaries to use inside the module_provider package
class Logger {
  ///
  final String prefix;

  ///
  Logger({ this.prefix });

  /// Indicates if the app is running in debug mode
  final bool inDebugMode = !kReleaseMode;

  /// Print a log message if the application is in debug mode
  log(String message) {
    _print(message);
  }

  info(String message) {
    _print('💡 ' + message);
  }

  warning(String message) {
    _print('⚠️ ' + message);
  }

  error(String message) {
    _print('⛔ ' + message);
  }

  _print(String message) {
    if (inDebugMode) {
      print((this.prefix != null ? this.prefix + ' ' : '') + message);
    }
  }
}

