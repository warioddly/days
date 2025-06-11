import 'dart:async';
import 'dart:developer';

import 'package:days/core/services/locator_service.dart';
import 'package:days/features/app/presentation/page/app.dart';
import 'package:days/shared/package/logger/_logger.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

Future<void> runner() async {

  WidgetsFlutterBinding.ensureInitialized();

  await Future.wait([
    if (!kIsWeb) setupSystemUI(),
    setupDependencyInjection(),
  ]);

  runApp(const MyApp());
}

void main() {

  Logger.i('Days app started');

  runZonedGuarded(
    runner,
    (error, stackTrace) {
      log('[ERROR]', error: error, stackTrace: stackTrace);
    },
  );

}

Future<void> setupSystemUI() async {
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  await SystemChrome.setEnabledSystemUIMode(
    SystemUiMode.manual,
    overlays: [SystemUiOverlay.top],
  );
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(statusBarColor: Colors.transparent),
  );
}
