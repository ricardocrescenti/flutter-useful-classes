import 'package:flutter/foundation.dart';

/// The `Logger` class is a simple class for printing information on the terminal only when the application is in debug mode.
///
/// Below is an example of implementing the logger.
///
/// ```dart
/// final Logger logger = Logger();
///
/// logger.log('simple log');
/// /// output: simple log
///
/// logger.info('information log');
/// /// output: 💡 information log
///
/// logger.warning('warning log');
/// /// output: ⚠️ warning log
///
/// logger.error('error log');
/// /// output: ⛔ error log
/// ```
///
/// If it is necessary to add a prefix when printing all logs, use the [prefix]
/// parameter in the class's constructor.
class Logger {
  /// Logger [prefix].
  ///
  /// This prefix will be printed at the beginning of any printed log.
  final String? prefix;

  /// Standard constructor of the Logger class
  Logger({this.prefix});

  /// Indicates if the app is running in debug mode
  final bool inDebugMode = !kReleaseMode;

  /// Print a log message if the application is in debug mode
  void log(String message) {
    _print(message);
  }

  void info(String message) {
    _print('💡 $message');
  }

  void warning(String message) {
    _print('⚠️ $message');
  }

  void error(String message) {
    _print('⛔ $message');
  }

  void _print(String message) {
    if (inDebugMode) {
      debugPrint((prefix != null ? '$prefix ' : '') + message);
    }
  }
}
