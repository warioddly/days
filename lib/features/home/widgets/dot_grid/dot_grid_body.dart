import 'package:days/core/constants/breakpoints.dart';
import 'package:days/features/home/home_view_model.dart';
import 'package:days/features/home/widgets/dot_grid/dot_grid_builder.dart';
import 'package:days/features/home/widgets/dot_grid/doted_dot_render_object_widget.dart';
import 'package:days/features/home/widgets/dot_grid/illustrated_dot_render_object_widget.dart';
import 'package:days/shared/package/vm/view_model.dart';
import 'package:days/shared/ui/animations/ui_blur_switcher.dart';
import 'package:days/shared/ui/animations/ui_vsync_provider.dart';
import 'package:days/shared/ui/dimensions/dimensions.dart';
import 'package:days/shared/ui/layouts/layout_breakpoint.dart';
import 'package:flutter/material.dart';

class DotGridBody extends StatelessWidget {
  const DotGridBody({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = ViewModel.of<HomeViewModel>(context);

    final screenSize = MediaQuery.sizeOf(context);
    final viewSize =
        (screenSize.width > Breakpoints.maxViewWidthSize
            ? Breakpoints.maxViewWidthSize
            : screenSize.width) -
        (Dimensions.xl * 2);

    return LayoutBreakpoint(
      child: UIBlurSwitcher(
        child: SizedBox(
          key: ValueKey(viewModel.gridType),
          width: viewSize,
          height: viewSize / (viewSize / (screenSize.height / 1.8)),
          child: UIVsyncProvider(
            child: DotGridRenderObjectWidget(
              child: switch (viewModel.gridType) {
                GridType.doted => DotedDotBuilderRenderObjectWidget(),
                GridType.illustrated => IllustratedDotBuilderRenderObjectWidget(),
              },
            ),
          ),
        ),
      ),
    );
  }
}
