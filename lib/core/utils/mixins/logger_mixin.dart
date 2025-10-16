import 'dart:developer' as developer;

mixin class LoggerMixin {
  String get loggerName => '';

  void log(String? message, {Object? error, StackTrace? stackTrace}) =>
      developer.log(
        message ?? '',
        error: error,
        stackTrace: stackTrace,
        name: loggerName,
      );
}
