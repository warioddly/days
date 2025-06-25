import 'package:days/core/constants/dimensions.dart';
import 'package:days/core/extensions/theme_extensions.dart';
import 'package:days/features/home/domain/entity/settings_entity.dart';
import 'package:days/features/home/presentation/bloc/settings/settings_bloc.dart';
import 'package:days/shared/ui/animations/fade_slide_animation.dart';
import 'package:days/shared/ui/widgets/custom_segmented_control.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ControlBar extends StatefulWidget {
  const ControlBar({super.key});

  @override
  State<ControlBar> createState() => _ControlBarState();
}

class _ControlBarState extends State<ControlBar> {
  @override
  Widget build(BuildContext context) {
    return FadeSlideAnimation(
      beginOffset: const Offset(0, 0.8),
      child: Padding(
        padding: Insets.largeHorizontal,
        child: Center(
          child: BlocBuilder<SettingsBloc, SettingsState>(
            builder: (context, state) {
              final selectedIndex = state.entity.gridType.index;
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
                  context.read<SettingsBloc>().add(
                    SetSettings(
                      state.entity.copyWith(gridType: GridType.values[index]),
                    ),
                  );
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
