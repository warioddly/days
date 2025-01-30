import 'package:days/core/services/locator_service.dart';
import 'package:days/features/home/presentation/bloc/settings/settings_bloc.dart';
import 'package:days/features/home/presentation/widgets/grid_type_status_bar.dart';
import 'package:days/features/home/presentation/widgets/controlbar/controlbar.dart';
import 'package:days/features/home/presentation/widgets/dot_list_body.dart';
import 'package:days/shared/ui/widgets/background_blur.dart';
import 'package:days/shared/ui/widgets/background_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var left = 0;
  var todayScrollOffset = 0.0;

  final settingsBloc = getIt<SettingsBloc>();
  final scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    settingsBloc.add(GetSettings());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Background(
        child: BlocProvider(
          create: (context) => settingsBloc,
          child: Stack(
            children: [
              const BackgroundBlur(),
              SafeArea(
                top: false,
                child: Column(
                  children: [
                    Expanded(
                      child: CustomScrollView(
                        controller: scrollController,
                        slivers: const [
                          DotListBody(),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              GridTypeStatusBar(
                scrollController: scrollController,
              ),
              ControlBar(
                scrollController: scrollController,
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }
}
