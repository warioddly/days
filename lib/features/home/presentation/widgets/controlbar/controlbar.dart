import 'package:days/core/constants/dimensions.dart';
import 'package:days/core/extensions/dimensions_extensions.dart';
import 'package:days/features/home/domain/entity/settings_entity.dart';
import 'package:days/features/home/presentation/bloc/settings/settings_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ControlBar extends StatefulWidget {
  const ControlBar({super.key});

  @override
  State<ControlBar> createState() => _ControlBarState();
}

class _ControlBarState extends State<ControlBar> {

  final Map<GridType, Color> skyColors = const <GridType, Color>{
    GridType.illustrated: Color(0xFF2C3E50),
    GridType.doted: Color(0xFF2C3E50),
  };

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: Dimensions.doubledNormal.padding,
      child: Center(
        child: BlocBuilder<SettingsBloc, SettingsModelState>(
          builder: (context, state) {
            return CupertinoSlidingSegmentedControl<GridType>(
              padding: Dimensions.small.padding,
              backgroundColor: Colors.white10,
              thumbColor: Colors.black,
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
                  padding: EdgeInsets.all(8),
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
