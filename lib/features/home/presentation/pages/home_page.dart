import 'package:days/core/constants/dimensions.dart';
import 'package:days/core/services/locator_service.dart';
import 'package:days/features/home/presentation/bloc/dots_manager/dots_manager_bloc.dart';
import 'package:days/features/home/presentation/bloc/settings/settings_bloc.dart';
import 'package:days/features/home/presentation/widgets/controlbar/controlbar.dart';
import 'package:days/features/home/presentation/widgets/controlbar/days_left_status.dart';
import 'package:days/features/home/presentation/widgets/dot_grid/dot_grid_body.dart';
import 'package:days/features/home/presentation/widgets/footer/footer.dart';
import 'package:flutter/material.dart' hide Tooltip;
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final settingsBloc = getIt<SettingsBloc>();
  final dotsManagerBloc = getIt<DotsManagerBloc>();

  @override
  void initState() {
    super.initState();
    settingsBloc.add(GetSettings());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => settingsBloc,
            ),
            BlocProvider(
              create: (context) => dotsManagerBloc,
            ),
          ],
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(
                maxWidth: Dimensions.maxViewWidthSize,
              ),
              child: const Column(
                children: [
                  DaysLeftStatus(),
                  Spacer(),
                  DotGridBody(),
                  Spacer(),
                  ControlBar(),
                  Footer(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    settingsBloc.close();
    dotsManagerBloc.close();
    super.dispose();
  }

}
