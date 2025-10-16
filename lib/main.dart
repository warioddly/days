import 'dart:async';
import 'dart:developer';

import 'package:days/core/bootstrap/setup_system_ui.dart';
import 'package:days/core/constants/constants.dart' show kAppName;
import 'package:days/core/services/local_storage.dart';
import 'package:days/features/app/app_view.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';

void main() => runZonedGuarded(
  $runner,
  (e, s) => log('', name: kAppName, error: e, stackTrace: s),
);

Future<void> $runner() async {
  WidgetsFlutterBinding.ensureInitialized();

  log('Days app started', name: kAppName);

  await Future.wait([
    LocalStorage.instance.init(),
    if (!kIsWeb) $setupSystemUI(),
  ]);

  log('Days app initialized', name: kAppName);

  runApp(const AppView());
}
