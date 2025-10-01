import 'package:days/features/home/domain/entity/grid_type.dart';
import 'package:days/features/home/presentation/bloc/dots_manager_notifier.dart';
import 'package:days/features/home/presentation/bloc/grid_type_notifier.dart';
import 'package:days/shared/ui/animations/ui_fade_slide.dart';
import 'package:days/shared/ui/dimensions/dimensions.dart';
import 'package:days/shared/ui/tabs/ui_segmented_control.dart';
import 'package:flutter/cupertino.dart';

class ControlBar extends StatelessWidget {
  const ControlBar({super.key});

  @override
  Widget build(BuildContext context) {
    final gridTypeNotifier = GridTypeNotifier.of(context);
    return UIFadeSlide(
      beginOffset: const Offset(0, 0.8),
      child: Padding(
        padding: Insets.mHorizontal,
        child: Center(
          child: ListenableBuilder(
            listenable: gridTypeNotifier,
            builder: (context, _) {
              final selectedIndex = gridTypeNotifier.gridType.index;
              return SizedBox(
                width: 110,
                child: UISegmentedControl<GridType>(
                  initialIndex: selectedIndex,
                  segments: const {
                    GridType.illustrated: Icon(CupertinoIcons.circle_grid_hex),
                    GridType.doted: Icon(CupertinoIcons.circle_grid_3x3),
                  },
                  onValueChanged: (gridType) {
                    gridTypeNotifier.setGridType(gridType);
                    DotsManagerNotifier.of(context).reset();
                  },
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
