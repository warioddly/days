import 'package:days/core/constants/dimensions.dart';
import 'package:days/core/utils/extensions/theme_extensions.dart';
import 'package:days/features/home/domain/entity/settings_entity.dart';
import 'package:days/features/home/presentation/bloc/grid_type_notifier.dart';
import 'package:days/shared/ui/animations/fade_slide_animation.dart';
import 'package:days/shared/ui/widgets/custom_segmented_control.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

class ControlBar extends StatelessWidget {
  const ControlBar({super.key});

  @override
  Widget build(BuildContext context) {
    return FadeSlideAnimation(
      beginOffset: const Offset(0, 0.8),
      child: Padding(
        padding: Insets.mHorizontal,
        child: Center(
          child: ListenableBuilder(
            listenable: GridTypeNotifier.of(context),
            builder: (context, state) {
              final selectedIndex = GridTypeNotifier.value(context).index;
              return CustomSegmentedControl(
                initialIndex: selectedIndex,
                segments: [
                  Icon(
                      CupertinoIcons.circle_grid_hex,
                    color: selectedIndex == GridType.illustrated.index
                        ? context.colorScheme.onPrimary
                        : CupertinoColors.systemFill,
                  ),
                  Icon(
                      CupertinoIcons.circle_grid_3x3,
                    color: selectedIndex == GridType.doted.index
                        ? context.colorScheme.onPrimary
                        : CupertinoColors.systemFill,
                  ),
                ],
                onValueChanged: (index) {
                  if (selectedIndex == index) {
                    return;
                  }
                  GridTypeNotifier.of(context).setGridType = GridType.values[index];
                  HapticFeedback.selectionClick();
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
