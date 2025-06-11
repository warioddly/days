import 'dart:ui';

import 'package:days/core/services/router.dart';
import 'package:days/core/theme/theme.dart' show AppTheme;
import 'package:days/features/app/presentation/bloc/locale/locale_bloc.dart';
import 'package:days/features/app/presentation/bloc/theme/theme_bloc.dart';
import 'package:days/features/l10n/_locale.dart' show l10n;
import 'package:days/features/l10n/generated/day_localizations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppWrapper extends StatefulWidget {
  const AppWrapper({super.key});

  @override
  State<AppWrapper> createState() => _AppWrapperState();
}

class _AppWrapperState extends State<AppWrapper> with WidgetsBindingObserver {

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didChangePlatformBrightness() {
    super.didChangePlatformBrightness();
    final brightness = PlatformDispatcher.instance.platformBrightness;
    context.read<ThemeBloc>().add(SetTheme(brightness));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, Brightness>(
      builder: (context, theme) {
        return BlocBuilder<LocaleBloc, LocaleState>(
          builder: (context, locale) {
            l10n = lookupDayLocalizations(locale.locale);
            return MaterialApp.router(
              title: l10n.app_name,
              restorationScopeId: 'app',
              debugShowCheckedModeBanner: false,
              theme: AppTheme.resolve(theme),
              locale: locale.locale,
              scrollBehavior: const CupertinoScrollBehavior(),
              backButtonDispatcher: RootBackButtonDispatcher(),
              routerDelegate: AppRouter.router.routerDelegate,
              routeInformationParser: AppRouter.router.routeInformationParser,
              routeInformationProvider: AppRouter.router.routeInformationProvider,
              localizationsDelegates: DayLocalizations.localizationsDelegates,
              supportedLocales: DayLocalizations.supportedLocales,
            );
          },
        );
      },
    );
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

}
