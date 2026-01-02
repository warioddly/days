import 'dart:async';

import 'package:days/core/bootstrap/setup_system_ui.dart';
import 'package:days/core/services/image_cache_service.dart';
import 'package:days/core/services/local_storage.dart';
import 'package:days/core/utils/logger.dart';
import 'package:days/features/app/app_view.dart';
import 'package:flutter/foundation.dart' show kDebugMode, kIsWeb;
import 'package:flutter/material.dart';

void main() => runZonedGuarded(
  $runner,
  (e, s) => logger.log('Crash App', error: e, stackTrace: s),
);

Future<void> $runner() async {
  WidgetsFlutterBinding.ensureInitialized();

  logger.log('Days app started');

  kEnableLogging = kDebugMode;

  await Future.wait([
    ImageCacheService.precacheImages(),
    LocalStorage.instance.init(),
    if (!kIsWeb) $setupSystemUI(),
  ]);

  logger.log('Days app initialized');

  runApp(const AppView());
}
