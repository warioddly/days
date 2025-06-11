import 'package:days/core/constants/dimensions.dart';
import 'package:days/features/home/domain/entity/settings_entity.dart';
import 'package:days/features/home/presentation/bloc/settings/settings_bloc.dart';
import 'package:days/shared/ui/widgets/sliding_segment_control.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ControlBar extends StatelessWidget {
  const ControlBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: Insets.large,
      child: Center(
        child: BlocBuilder<SettingsBloc, SettingsModelState>(
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
    );
  }
}
