import 'package:days/core/utils/logger.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

Future<void> $setupSystemUI() async {
  logger.log('Setup system ui', name: 'System Overlay');

  await [
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]),
    SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.manual,
      overlays: [SystemUiOverlay.top],
    ),
    Future(
      () => SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(statusBarColor: Colors.transparent),
      ),
    ),
  ].wait;

  logger.log('Done setup system ui', name: 'System Overlay');
}
