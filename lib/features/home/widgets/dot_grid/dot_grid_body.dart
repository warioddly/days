import 'package:days/core/constants/breakpoints.dart';
import 'package:days/features/home/home_view_model.dart';
import 'package:days/features/home/widgets/dot_grid/dots/dot_.dart';
import 'package:days/features/home/widgets/dot_grid/dots/doted_dot_render_object_widget.dart';
import 'package:days/features/home/widgets/dot_grid/dots/illustrated_dot_render_object_widget.dart';
import 'package:days/shared/package/vm/view_model.dart';
import 'package:days/shared/ui/dimensions/dimensions.dart';
import 'package:days/shared/ui/layouts/layout_breakpoint.dart';
import 'package:flutter/material.dart';

class DotGridBody extends StatefulWidget {
  const DotGridBody({super.key});

  @override
  State<DotGridBody> createState() => _DotGridBodyState();
}

class _DotGridBodyState extends State<DotGridBody> {
  final illustrated = IllustratedDotBuilderRenderObjectWidget();
  final doted = DotedDotBuilderRenderObjectWidget();

  @override
  Widget build(BuildContext context) {
    final viewModel = ViewModel.of<HomeViewModel>(context);

    final screenSize = MediaQuery.sizeOf(context);
    final viewSize =
        (screenSize.width > Breakpoints.maxViewWidthSize
            ? Breakpoints.maxViewWidthSize
            : screenSize.width) -
        (Dimensions.xl * 2);

    return VsyncProvider(
      child: LayoutBreakpoint(
        child: SizedBox(
          key: ValueKey(viewModel.gridType),
          width: viewSize,
          height: viewSize / (viewSize / (screenSize.height / 1.8)),
          child: DotGridRenderObjectWidget(
            child: switch (viewModel.gridType) {
              GridType.doted => DotedDotBuilderRenderObjectWidget(),
              GridType.illustrated => IllustratedDotBuilderRenderObjectWidget(),
            },
          ),
        ),
      ),
    );
  }
}
