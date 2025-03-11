import 'dart:async';

import 'package:days/core/services/router.dart';
import 'package:days/core/services/locator_service.dart';
import 'package:days/core/theme/theme.dart';
import 'package:days/features/app/presentation/bloc/theme_bloc.dart';
import 'package:days/features/app/presentation/page/main_wrapper.dart';
import 'package:days/shared/package/logger/_logger.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {

  Logger.i('Days started');

  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  await setupDependencyInjection();

  if (kIsWeb) {
    runApp(const MyApp());
  } else {
    runZonedGuarded(
      () {
        runApp(const MyApp());
      },
      (error, stackTrace) {
        Logger.e(error, stackTrace: stackTrace);
      },
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => getIt<ThemeBloc>()..add(GetTheme())),
      ],
      child: BlocBuilder<ThemeBloc, Brightness>(
        builder: (context, theme) {
          return MainWrapper(
            child: MaterialApp.router(
              title: 'Days',
              restorationScopeId: 'app',
              theme: AppTheme.getTheme(context, theme),
              debugShowCheckedModeBanner: false,
              scrollBehavior: const CupertinoScrollBehavior(),
              routerDelegate: AppRouter.router.routerDelegate,
              routeInformationParser: AppRouter.router.routeInformationParser,
              routeInformationProvider:
                  AppRouter.router.routeInformationProvider,
              backButtonDispatcher: RootBackButtonDispatcher(),
            ),
          );
        },
      ),
    );
  }
}
