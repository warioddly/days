import 'dart:async';
import 'package:days/core/services/locator_service.dart';
import 'package:days/core/utils/on_error.dart';
import 'package:days/features/app/presentation/page/app_wrapper.dart';
import 'package:days/shared/package/logger/_logger.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

Future<void> runner() async {

  WidgetsFlutterBinding.ensureInitialized();

  Logger.i('Days app initializing', time: DateTime.now());

  await Future.wait([
    if (!kIsWeb) setupSystemUI(),
    setupDependencyInjection(),
  ]);

  Logger.i('Days app initialized', time: DateTime.now());

  runApp(const DaysApp());
}

void main() {
  Logger.i('Days app started', time: DateTime.now());
  runZonedGuarded(runner, onErrorLog);
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
