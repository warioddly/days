import 'package:days/core/services/locator_service.dart';
import 'package:days/features/home/presentation/bloc/dots_manager/dots_manager_bloc.dart';
import 'package:days/features/home/presentation/bloc/settings/settings_bloc.dart';
import 'package:days/features/home/presentation/widgets/controlbar/grid_type_status_bar.dart';
import 'package:days/features/home/presentation/widgets/controlbar/controlbar.dart';
import 'package:days/features/home/presentation/widgets/dot/dot_list_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final settingsBloc = getIt<SettingsBloc>();
  final dotsManagerBloc = getIt<DotsManagerBloc>();
  final scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    settingsBloc.add(GetSettings());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => settingsBloc,
          ),
          BlocProvider(
            create: (context) => dotsManagerBloc,
          ),
        ],
        child: ChangeNotifierProvider.value(
          value: scrollController,
          child: GestureDetector(
            onLongPress: () {
              FocusScope.of(context).unfocus();
              dotsManagerBloc.add(DotsManagerUserOutsideClickEvent());
            },
            child: const Column(
              children: [
                GridTypeStatusBar(),
                GridListBody(),
                ControlBar(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    settingsBloc.close();
    scrollController.dispose();
    super.dispose();
  }

}
