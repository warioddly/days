import 'dart:async';

import 'package:days/core/services/locator_service.dart';
import 'package:days/features/app/presentation/bloc/locale/locale_bloc.dart';
import 'package:days/features/app/presentation/bloc/theme/theme_bloc.dart';
import 'package:days/features/app/presentation/page/main_wrapper.dart';
import 'package:days/shared/package/logger/_logger.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart' show PlatformDispatcher, kDebugMode, kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {

  Logger.i('Days started');

  if (kDebugMode) {
    Logger.w('Debug mode');
    runner();
    return;
  }

  runZonedGuarded(
    runner,
    (error, stackTrace) {
      Logger.e(error, stackTrace: stackTrace);
    },
  );

}

void runner() async {

  WidgetsFlutterBinding.ensureInitialized();

  if (!kIsWeb) {
    await SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }

  await setupDependencyInjection();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final systemLocale = PlatformDispatcher.instance.locale;
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => getIt<ThemeBloc>()..add(GetTheme())),
        BlocProvider(create: (_) => getIt<LocaleBloc>()..add(LocaleSetInitialEvent(systemLocale))),
      ],
      child: const AppWrapper(),
    );
  }
}
