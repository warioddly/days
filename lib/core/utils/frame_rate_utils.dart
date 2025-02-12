import 'package:flutter/scheduler.dart';

final class Framer {

  final _fps = const Duration(milliseconds: 1000 ~/ 60);
  var _lastUpdateTime = Duration.zero;

  void throttle(VoidCallback callback) {
    final currentTime = SchedulerBinding.instance.currentSystemFrameTimeStamp;
    if (currentTime - _lastUpdateTime < _fps) {
      return;
    }
    _lastUpdateTime = currentTime;
    callback();
  }

}
