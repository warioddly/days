import 'dart:developer' as developer;

enum Level {
  all(0),
  trace(1000),
  debug(2000),
  info(3000),
  warning(4000),
  error(5000),
  fatal(6000);

  final int value;

  const Level(this.value);
}

abstract final class Logger {
  static void d(
    dynamic message, {
    DateTime? time,
    Object? error,
    StackTrace? stackTrace,
  }) => log(
    message,
    time: time,
    error: error,
    stackTrace: stackTrace,
    level: Level.debug,
  );

  static void e(
    dynamic message, {
    DateTime? time,
    Object? error,
    StackTrace? stackTrace,
  }) => log(
    message,
    time: time,
    error: error,
    stackTrace: stackTrace,
    level: Level.error,
  );

  static void i(
    dynamic message, {
    DateTime? time,
    Object? error,
    StackTrace? stackTrace,
  }) => log(
    message,
    time: time,
    error: error,
    stackTrace: stackTrace,
    level: Level.info,
  );

  static void t(
    dynamic message, {
    DateTime? time,
    Object? error,
    StackTrace? stackTrace,
  }) => log(
    message,
    time: time,
    error: error,
    stackTrace: stackTrace,
    level: Level.trace,
  );

  static void w(
    dynamic message, {
    DateTime? time,
    Object? error,
    StackTrace? stackTrace,
  }) => log(
    message,
    time: time,
    error: error,
    stackTrace: stackTrace,
    level: Level.warning,
  );

  static void log(
    dynamic message, {
    Level level = Level.info,
    DateTime? time,
    Object? error,
    StackTrace? stackTrace,
    String? name,
  }) {
    developer.log(
      message.toString(),
      time: time,
      error: error,
      stackTrace: stackTrace,
      name: name ?? level.name.toUpperCase(),
    );
  }
}
