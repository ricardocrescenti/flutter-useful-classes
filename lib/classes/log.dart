import 'package:flutter/foundation.dart';

/// Utilitaries to use inside the module_provider package
class Log {
  final String local;

  Log(this.local);

  /// Indicates if the app is running in debug mode
  static bool inDebugMode = !kReleaseMode;

  /// Print a log message if the application is in debug mode
  info(String log) {
    if (inDebugMode) {
      print(local + ' >>> ' + log);
    }
  }
}

