import 'package:days/shared/ui/dot/dot.dart';
import 'package:flutter/material.dart';
import 'package:days/shared/utils/dot_builder_utils.dart';
import 'package:days/features/home/presentation/bloc/settings/settings_bloc.dart';
import 'package:days/core/constants/dimensions.dart';

class HomeWidget {
  List<List<Dot>> buildDots(BuildContext context, SettingsBloc settingsBloc) {
    final settings = settingsBloc.state.entity;
    final now = DateTime.now();
    final from = settings.birthday;
    final to = settings.endDateTime;
    final gridType = settings.gridType;
    final dotContainerSize = Dimensions.dotContainerSize;
    final size = MediaQuery.of(context).size;
    final dotsPerRow = ((size.width - (dotContainerSize / 2 + Dimensions.dotSize) * 2) ~/ dotContainerSize);
    final dotsPerColumn = size.height ~/ dotContainerSize;
    final safeAreaCompensation = MediaQuery.of(context).padding.bottom;
    

    final dots = DotBuilderUtils.buildDots(
      from: from,
      to: to,
      now: now,
      gridType: gridType,
      dotsPerRow: dotsPerRow,
      beforeOffsetCallback: (int index) {
        final todayScrollOffset = (index * dotContainerSize) + (dotsPerColumn - safeAreaCompensation);
      },
    );

    return dots;
  }
}