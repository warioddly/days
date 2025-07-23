import 'package:days/core/constants/breakpoints.dart';
import 'package:days/features/home/domain/entity/settings_entity.dart';
import 'package:days/features/home/presentation/bloc/settings/settings_bloc.dart';
import 'package:days/features/home/presentation/pages/widgets/dot_grid/builders/doted_grid_builder.dart';
import 'package:days/features/home/presentation/pages/widgets/dot_grid/builders/illustrated_grid_builder.dart';
import 'package:days/shared/ui/animations/blurred_switcher.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DotGridBody extends StatelessWidget {
  const DotGridBody({super.key});

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: Breakpoints.maxViewWidthSize),
      child: BlocBuilder<SettingsBloc, SettingsState>(
        builder: (context, state) {
          return switch (state.state) {
            SettingsLoaded() => RepaintBoundary(
              child: BlurredSwitcher(
                duration: Durations.medium1,
                child: switch (state.entity.gridType) {
                  GridType.doted => const DotedGridBuilder(),
                  GridType.illustrated => const IllustratedGridBuilder(),
                },
              ),
            ),
            SettingsLoading() => const Center(child: CupertinoActivityIndicator()),
            _ => const SizedBox.shrink(),
          };
        },
      ),
    );
  }
}
