import 'package:days/core/base/view_model.dart';
import 'package:days/core/constants/constants.dart';
import 'package:days/features/app/app_view_model.dart';
import 'package:days/features/home/home_view.dart';
import 'package:days/shared/l10n/generated/day_localizations.dart';
import 'package:days/shared/ui/theme/_theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppView extends StatefulWidget {
  const AppView({super.key});

  @override
  State<AppView> createState() => _AppViewState();
}

class _AppViewState extends State<AppView> {
  final viewModel = AppViewModel();

  @override
  void dispose() {
    viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelProvider(
      viewModel: viewModel,
      child: Builder(
        builder: (context) => ListenableBuilder(
          listenable: viewModel,
          builder: (context, _) {
            return MaterialApp(
              title: kAppName,
              themeMode: viewModel.themeMode,
              debugShowCheckedModeBanner: false,
              theme: UITheme.lightTheme(),
              darkTheme: UITheme.darkTheme(),
              scrollBehavior: const CupertinoScrollBehavior(),
              localizationsDelegates: DayLocalizations.localizationsDelegates,
              supportedLocales: DayLocalizations.supportedLocales,
              home: MediaQuery(
                data: MediaQuery.of(context).copyWith(textScaler: TextScaler.noScaling),
                child: const HomeView(),
              ),
            );
          },
        ),
      ),
    );
  }
}
