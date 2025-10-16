import 'package:days/core/base/view_model.dart';
import 'package:days/features/home/home_view_model.dart';
import 'package:days/features/home/widgets/dot_grid/builders/doted_grid_builder.dart';
import 'package:days/features/home/widgets/dot_grid/builders/illustrated_grid_builder.dart';
import 'package:days/shared/ui/animations/ui_blur_switcher.dart';
import 'package:days/shared/ui/layouts/layout_breakpoint.dart';
import 'package:flutter/material.dart';

class DotGridBody extends StatelessWidget {
  const DotGridBody({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = ViewModel.of<HomeViewModel>(context);
    return LayoutBreakpoint(
      child: UIBlurSwitcher(
        duration: Durations.medium1,
        child: switch (viewModel.gridType) {
          GridType.doted => const DotedGridBuilder(),
          GridType.illustrated => const IllustratedGridBuilder(),
        },
      ),
    );
  }
}
