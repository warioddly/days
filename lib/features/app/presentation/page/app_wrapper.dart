import 'package:days/core/services/di_service.dart';
import 'package:days/core/theme/theme.dart' show AppTheme;
import 'package:days/features/app/presentation/bloc/theme_notifier.dart';
import 'package:days/features/home/presentation/pages/home_page.dart';
import 'package:days/features/l10n/_locale.dart' show l10n;
import 'package:days/features/l10n/generated/day_localizations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DaysApp extends StatelessWidget {
  const DaysApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ListenableProvider(
      create: (_) => GetIt.I.get<ThemeNotifier>()..getTheme(),
      child: Builder(
        builder: (context) => ListenableBuilder(
          listenable: ThemeNotifier.of(context),
          builder: (context, _) {
            return MaterialApp(
              title: l10n.app_name,
              restorationScopeId: 'app',
              debugShowCheckedModeBanner: false,
              theme: AppTheme.resolveTheme(ThemeNotifier.value(context)),
              scrollBehavior: const CupertinoScrollBehavior(),
              localizationsDelegates: DayLocalizations.localizationsDelegates,
              supportedLocales: DayLocalizations.supportedLocales,
              home: MediaQuery(
                data: MediaQuery.of(
                  context,
                ).copyWith(textScaler: TextScaler.noScaling),
                child: const HomePage(),
              ),
            );
          },
        ),
      ),
    );
  }
}
