import 'package:days/core/constants/dimensions.dart';
import 'package:days/core/extensions/dimensions_extensions.dart';
import 'package:days/core/extensions/string_extensions.dart';
import 'package:days/features/home/domain/entity/settings_entity.dart';
import 'package:days/features/home/presentation/bloc/settings/settings_bloc.dart';
import 'package:days/shared/ui/layout/card_container.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GridTypeControlBar extends StatelessWidget {
  const GridTypeControlBar({super.key});

  @override
  Widget build(BuildContext context) {
    return CardContainer(
      margin: Dimensions.large.paddingHorizontal,
      child: BlocBuilder<SettingsBloc, SettingsModelState>(
        builder: (context, state) {
          return CupertinoSlidingSegmentedControl(
            backgroundColor: Colors.transparent,
            groupValue: state.entity.gridType.index,
            children: {
              ...GridType.values.asMap().map((index, type) {
                return MapEntry(
                  index,
                  Text(
                    type.name.capitalize,
                  ),
                );
              }),
            },
            onValueChanged: (value) {
              if (value == null || value == state.entity.gridType.index) {
                return;
              }
              context.read<SettingsBloc>().add(
                SetSettings(
                  state.entity.copyWith(
                    gridType: GridType.values[value],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
