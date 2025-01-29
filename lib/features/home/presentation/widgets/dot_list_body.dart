import 'package:days/core/constants/dimensions.dart';
import 'package:days/core/extensions/dimensions_extensions.dart';
import 'package:days/features/home/presentation/bloc/settings/settings_bloc.dart';
import 'package:days/features/home/presentation/utils/extensions/grid_type_extension.dart';
import 'package:days/shared/models/vector2.dart';
import 'package:days/features/home/presentation/widgets/dot.dart';
import 'package:days/shared/package/day_grid_builder/day_grid_builder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DotListBody extends StatefulWidget {
  const DotListBody({super.key});

  @override
  State<DotListBody> createState() => _DotListBodyState();
}

class _DotListBodyState extends State<DotListBody> {

  final now = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingsBloc, SettingsModelState>(
      builder: (context, state) {
        final eventState = state.state;

        if (eventState is SettingsLoaded) {
          final settings = state.entity;
          return DayGridBuilder(
            now: now,
            from: settings.birthday,
            to: settings.endDateTime,
            lengthCalculate: settings.gridType.calculation,
            dayCalculate: settings.gridType.calculationDay,
            padding: Dimensions.large.paddingHorizontal,
            blockSize: const Size.square(Dimensions.dotContainerSize),
            itemBuilder: _itemBuilder,
          );
        }

        if (eventState is SettingsError) {
          return SliverToBoxAdapter(
              child: Text(
            eventState.message.toString(),
            style: Theme.of(context).textTheme.bodySmall,
          ));
        }

        return SliverToBoxAdapter(
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: const Center(
              child: CupertinoActivityIndicator(),
            ),
          ),
        );
      },
    );
  }

  Widget _itemBuilder(int index, DateTime day, Vector2 position) {
    final isBefore = day.isBefore(now);
    return Dot(
      position,
      date: day,
      color: isBefore ? Colors.white : Colors.white12,
    );
  }

}
