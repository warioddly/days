
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

Future<void> $setupSystemUI() async {

  log('Setup system ui', name: 'System Overlay');

  await [
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]),
    SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.manual,
      overlays: [SystemUiOverlay.top],
    ),
    Future(() => SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarColor: Colors.transparent),
    ))
  ].wait;

  log('Done setup system ui', name: 'System Overlay');

}
