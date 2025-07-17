import 'package:days/core/services/di_service.dart';
import 'package:days/core/services/router.dart';
import 'package:days/core/theme/theme.dart' show AppTheme;
import 'package:days/features/app/presentation/bloc/theme/theme_bloc.dart';
import 'package:days/features/l10n/_locale.dart' show l10n;
import 'package:days/features/l10n/generated/day_localizations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DaysApp extends StatelessWidget {
  const DaysApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => GetIt.I.get<ThemeBloc>()..add(GetTheme()),
      child: BlocBuilder<ThemeBloc, Brightness>(
        builder: (context, theme) {
          return MaterialApp.router(
            title: l10n.app_name,
            restorationScopeId: 'app',
            debugShowCheckedModeBanner: false,
            theme: AppTheme.resolveTheme(theme),
            scrollBehavior: const CupertinoScrollBehavior(),
            backButtonDispatcher: RootBackButtonDispatcher(),
            routerDelegate: AppRouter.router.routerDelegate,
            routeInformationParser: AppRouter.router.routeInformationParser,
            routeInformationProvider: AppRouter.router.routeInformationProvider,
            localizationsDelegates: DayLocalizations.localizationsDelegates,
            supportedLocales: DayLocalizations.supportedLocales,
          );
        },
      ),
    );
  }
}
