import 'package:days/core/constants/dimensions.dart';
import 'package:days/features/home/domain/entity/settings_entity.dart';
import 'package:days/features/home/presentation/bloc/settings/settings_bloc.dart';
import 'package:days/shared/ui/animations/fade_slide_animation.dart';
import 'package:days/shared/ui/widgets/sliding_segment_control.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
      beginOffset: const Offset(0, 0.6),
      child: Padding(
        padding: Insets.largeHorizontal,
        child: Center(
          child: BlocBuilder<SettingsBloc, SettingsState>(
            builder: (context, state) {
              return SlidingSegmentControl<GridType>(
                groupValue: state.entity.gridType,
                onValueChanged: (GridType? value) {
                  if (value == null || value == state.entity.gridType) {
                    return;
                  }
                  context.read<SettingsBloc>().add(
                    SetSettings(
                      state.entity.copyWith(gridType: value),
                    ),
                  );
                  HapticFeedback.selectionClick();
                },
                children: const {
                  GridType.illustrated: Padding(
                    padding: Insets.half,
                    child: Icon(
                      CupertinoIcons.circle_grid_hex,
                    ),
                  ),
                  GridType.doted: Icon(
                    CupertinoIcons.circle_grid_3x3,
                  ),
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
