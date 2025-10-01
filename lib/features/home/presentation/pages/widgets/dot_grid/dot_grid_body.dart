import 'package:days/features/home/domain/entity/grid_type.dart';
import 'package:days/features/home/presentation/bloc/grid_type_notifier.dart';
import 'package:days/features/home/presentation/pages/widgets/dot_grid/builders/doted_grid_builder.dart';
import 'package:days/features/home/presentation/pages/widgets/dot_grid/builders/illustrated_grid_builder.dart';
import 'package:days/shared/ui/animations/ui_blur_switcher.dart';
import 'package:days/shared/ui/layouts/layout_breakpoint.dart';
import 'package:flutter/material.dart';

class DotGridBody extends StatelessWidget {
  const DotGridBody({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBreakpoint(
      child: RepaintBoundary(
        child: ListenableBuilder(
          listenable: GridTypeNotifier.of(context),
          builder: (context, _) {
            return UIBlurSwitcher(
              duration: Durations.medium1,
              child: switch (GridTypeNotifier.value(context)) {
                GridType.doted => const DotedGridBuilder(),
                GridType.illustrated => const IllustratedGridBuilder(),
              },
            );
          },
        ),
      ),
    );
  }
}
