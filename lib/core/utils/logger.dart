import 'dart:developer' as developer;

import 'package:days/core/constants/constants.dart' show kAppName;

/// Global flag to enable or disable logging throughout the app.
bool kEnableLogging = false;

/// Global logger instance.
final logger = Logger();

/// Mixin that provides logging capabilities to classes.
mixin class Logger {
  /// The name used in the logger. Defaults to the app name [kAppName].
  String get loggerName => kAppName;

  void log(String? message, {Object? error, StackTrace? stackTrace, String? name}) {
    if (!kEnableLogging) return;
    return developer.log(
      message ?? '',
      error: error,
      stackTrace: stackTrace,
      name: name ?? loggerName,
    );
  }
}
