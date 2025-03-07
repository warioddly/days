import 'package:days/core/configs/localizations.dart';
import 'package:days/core/configs/routes.dart';
import 'package:days/core/services/locator_service.dart';
import 'package:days/core/theme/theme.dart';
import 'package:days/features/app/presentation/bloc/theme/theme_bloc.dart';
import 'package:days/features/app/presentation/page/main_wrapper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown
  ]);

  await initDependencyInjection();

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
              theme: AppTheme.getTheme(context, theme),
              debugShowCheckedModeBanner: false,
              scrollBehavior: const CupertinoScrollBehavior(),
              routerDelegate: AppRouter.router.routerDelegate,
              routeInformationParser: AppRouter.router.routeInformationParser,
              routeInformationProvider: AppRouter.router.routeInformationProvider,
              backButtonDispatcher: RootBackButtonDispatcher(),
              localizationsDelegates: const [
                AppLocalizations.delegate, // Add this line
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              supportedLocales: supportedLocales,
            ),
          );
        },
      ),
    );
  }
}
