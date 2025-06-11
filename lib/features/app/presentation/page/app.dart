import 'package:days/core/services/locator_service.dart';
import 'package:days/features/app/presentation/bloc/locale/locale_bloc.dart';
import 'package:days/features/app/presentation/bloc/theme/theme_bloc.dart';
import 'package:days/features/app/presentation/page/app_wrapper.dart';
import 'package:days/features/l10n/_locale.dart' show defaultLocale;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => getIt<ThemeBloc>()..add(GetTheme())),
        BlocProvider(create: (_) => getIt<LocaleBloc>()..add(LocaleSetInitialEvent(defaultLocale))),
      ],
      child: const AppWrapper(),
    );
  }
}
