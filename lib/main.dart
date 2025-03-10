import 'package:days/core/configs/routes.dart';
import 'package:days/core/services/locator_service.dart';
import 'package:days/core/theme/theme.dart';
import 'package:days/features/app/presentation/bloc/theme/theme_bloc.dart';
import 'package:days/features/app/presentation/page/main_wrapper.dart';
import 'package:days/features/l10n/_locale.dart' show l10n;
import 'package:days/features/l10n/generated/day_localizations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown
  ]);

  await setupDependencyInjection();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [

        BlocProvider(create: (_) => getIt<ThemeBloc>()..add(GetTheme()))

      ],
      child: BlocBuilder<ThemeBloc, Brightness>(
        builder: (context, theme) {
          return MainWrapper(
            child: MaterialApp.router(
              title: l10n.app_name,
              restorationScopeId: 'app',
              debugShowCheckedModeBanner: false,
              theme: AppTheme.getTheme(context, theme),
              scrollBehavior: const CupertinoScrollBehavior(),
              backButtonDispatcher: RootBackButtonDispatcher(),
              routerDelegate: AppRouter.router.routerDelegate,
              routeInformationParser: AppRouter.router.routeInformationParser,
              routeInformationProvider: AppRouter.router.routeInformationProvider,
              localizationsDelegates: DayLocalizations.localizationsDelegates,
              supportedLocales: DayLocalizations.supportedLocales,
            ),
          );
        },
      ),
    );
  }
}
