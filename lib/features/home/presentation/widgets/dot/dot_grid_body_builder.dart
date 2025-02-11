import 'package:days/core/constants/dimensions.dart';
import 'package:days/core/extensions/dimensions_extensions.dart';
import 'package:days/features/home/presentation/bloc/settings/settings_bloc.dart';
import 'package:days/features/home/presentation/utils/extensions/grid_type_extension.dart';
import 'package:days/shared/package/grid_builder/grid_builder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DotGridBodyBuilder extends StatelessWidget {
  const DotGridBodyBuilder({
    required this.now,
    required this.throttlePanUpdate,
    required this.onPanUpdate,
    required this.itemBuilder,
    super.key,
  });

  final DateTime now;
  final Function(Offset) throttlePanUpdate;
  final Function(Offset) onPanUpdate;
  final GridItemBuilder itemBuilder;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingsBloc, SettingsModelState>(
      builder: (context, state) {
        final eventState = state.state;

        if (eventState is SettingsLoaded) {
          final settings = state.entity;

          final mediaQuerySize = MediaQuery.sizeOf(context);
          const padding = Dimensions.doubledNormal;
          final viewSize = (mediaQuerySize.width > Dimensions.maxViewWidthSize
                  ? Dimensions.maxViewWidthSize
                  : mediaQuerySize.width) -
              (padding * 2);

          return Padding(
            padding: padding.paddingHorizontal,
            child: GestureDetector(
              behavior: HitTestBehavior.translucent,
              onPanStart: (details) => throttlePanUpdate(
                details.globalPosition,
              ),
              onPanUpdate: (details) => onPanUpdate(
                details.globalPosition,
              ),
              child: GridBuilder(
                now: now,
                from: DateTime(now.year),
                to: DateTime(now.year).add(const Duration(days: 365)),
                lengthCalculate: settings.gridType.calculation,
                dayCalculate: settings.gridType.calculationDay,
                blockSize: const Size.square(Dimensions.dotContainerSize),
                viewSize: Size(viewSize, mediaQuerySize.height),
                itemBuilder: itemBuilder,
              ),
            ),
          );
        }

        if (eventState is SettingsError) {
          return Text(
            eventState.message.toString(),
            style: Theme.of(context).textTheme.bodySmall,
          );
        }

        return const Center(
          child: CupertinoActivityIndicator(),
        );

      },
    );
  }
}
