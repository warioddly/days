import 'dart:async';

import 'package:days/core/services/db_service.dart';
import 'package:days/core/services/di_service.dart';
import 'package:days/core/utils/on_error.dart';
import 'package:days/core/utils/setup_system_ui.dart';
import 'package:days/features/app/presentation/page/app_wrapper.dart';
import 'package:days/shared/package/logger/_logger.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';

void main() => runZonedGuarded(runner, onErrorLog);

Future<void> runner() async {

  Logger.i('Days app started');

  WidgetsFlutterBinding.ensureInitialized();

  Logger.i('Days app initializing');

  await Future.wait([
    LocalStorage.instance.init(),
    if (!kIsWeb) $setupSystemUI(),
    $setupAppModules(),
  ]);

  Logger.i('Days app initialized');

  runApp(const DaysApp());
}

