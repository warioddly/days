import 'package:days/shared/package/logger/_logger.dart';

void onErrorLog(Object? error, StackTrace stackTrace) {
  Logger.e('', error: error, stackTrace: stackTrace);
}