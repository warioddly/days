import 'package:days/core/base/view_model.dart';
import 'package:days/features/home/dots_view_model.dart';
import 'package:days/features/home/home_view_model.dart';
import 'package:days/shared/ui/animations/ui_fade_slide.dart';
import 'package:days/shared/ui/dimensions/dimensions.dart';
import 'package:days/shared/ui/tabs/ui_segmented_control.dart';
import 'package:flutter/cupertino.dart';

class ControlBar extends StatelessWidget {
  const ControlBar({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = ViewModel.of<HomeViewModel>(context);
    final selectedIndex = viewModel.gridType.index;
    return UIFadeSlide(
      beginOffset: const Offset(0, 0.8),
      child: Padding(
        padding: Insets.mHorizontal,
        child: Center(
          child: SizedBox(
            width: 110,
            child: UISegmentedControl<GridType>(
              initialIndex: selectedIndex,
              segments: const {
                GridType.illustrated: Icon(CupertinoIcons.circle_grid_hex),
                GridType.doted: Icon(CupertinoIcons.circle_grid_3x3),
              },
              onValueChanged: (gridType) {
                viewModel.setGridType(gridType);
                ViewModel.of<DotsViewModel>(context).reset();
              },
            ),
          ),
        ),
      ),
    );
  }
}
