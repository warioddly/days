import 'package:days/core/constants/breakpoints.dart';
import 'package:days/features/home/domain/entity/settings_entity.dart';
import 'package:days/features/home/presentation/bloc/dots_manager/dots_manager_bloc.dart';
import 'package:days/features/home/presentation/bloc/settings/settings_bloc.dart';
import 'package:days/features/home/presentation/pages/widgets/dot_grid/builders/dot_grid_builder.dart';
import 'package:days/features/home/presentation/pages/widgets/dot_grid/builders/doted_grid_builder.dart';
import 'package:days/features/home/presentation/pages/widgets/dot_grid/builders/illustrated_grid_builder.dart';
import 'package:days/features/home/presentation/pages/widgets/dot_grid/grid_animations/dot_disable_animation.dart';
import 'package:days/shared/ui/animations/blurred_switcher.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

class DotGridBody extends StatefulWidget {
  const DotGridBody({super.key});

  @override
  State<DotGridBody> createState() => _DotGridBodyState();
}

class _DotGridBodyState extends State<DotGridBody> {

  final dotKeyManager = DotKeyManager();

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<DotsManagerBloc, DotsManagerModelState>(listener: _dotsManagerListener),
        ChangeNotifierProvider.value(value: dotKeyManager),
      ],
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: Breakpoints.maxViewWidthSize),
        child: BlocConsumer<SettingsBloc, SettingsState>(
          listener: _settingsListener,
          builder: (context, state) {
            final eventState = state.state;

            if (eventState is SettingsLoaded) {
              return RepaintBoundary(
                child: BlurredSwitcher(
                  duration: Durations.medium1,
                  child: switch (state.entity.gridType) {
                    GridType.doted => const DotedGridBuilder(),
                    GridType.illustrated => const IllustratedGridBuilder(),
                  },
                ),
              );
            }

            if (eventState is SettingsLoading) {
              return const Center(child: CupertinoActivityIndicator());
            }

            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }

  void _dotsManagerListener(_, DotsManagerModelState state) {
    final eventState = state.state;

    if (eventState is DotsManagerUserOutsideClicked) {
      DotDisableAnimation(keys: dotKeyManager.keys);
    }
  }

  void _settingsListener(BuildContext context, SettingsState state) {
    if (state.state is SettingsLoading) {
      dotKeyManager.clear();
      context.read<DotsManagerBloc>().add(
        DotsManagerActiveDotsCountResetEvent(),
      );
    }
  }
}
