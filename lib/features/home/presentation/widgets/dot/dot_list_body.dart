import 'package:days/core/constants/dimensions.dart';
import 'package:days/core/extensions/dimensions_extensions.dart';
import 'package:days/features/home/domain/entity/settings_entity.dart';
import 'package:days/features/home/presentation/bloc/settings/settings_bloc.dart';
import 'package:days/features/home/presentation/utils/extensions/grid_type_extension.dart';
import 'package:days/shared/models/vector2.dart';
import 'package:days/features/home/presentation/widgets/dot/dot.dart';
import 'package:days/shared/package/day_grid_builder/day_grid_builder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DotListBody extends StatefulWidget {
  const DotListBody({required this.scrollController, super.key});

  final ScrollController scrollController;

  @override
  State<DotListBody> createState() => _DotListBodyState();
}

class _DotListBodyState extends State<DotListBody> {
  var now = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: CustomScrollView(
            controller: widget.scrollController,
            slivers: [
              BlocBuilder<SettingsBloc, SettingsModelState>(
                builder: (context, state) {
                  final eventState = state.state;

                  if (eventState is SettingsLoaded) {
                    final settings = state.entity;
                    now = DateTime.now();
                    final safeAreaPaddingTop =
                        MediaQuery.paddingOf(context).top;
                    return DayGridBuilder(
                      now: now,
                      from: settings.birthday,
                      to: settings.endDateTime,
                      lengthCalculate: settings.gridType.calculation,
                      dayCalculate: settings.gridType.calculationDay,
                      padding: Dimensions.large.padding.copyWith(
                        top: (Dimensions.dotContainerSize * 3) -
                            (Dimensions.dotSize * 3) +
                            safeAreaPaddingTop,
                      ),
                      blockSize: const Size.square(Dimensions.dotContainerSize),
                      itemBuilder:
                          (int index, DateTime date, Vector2 position) {
                        return _itemBuilder(
                            index, date, position, settings.gridType);
                      },
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
              )
            ],
          ),
        ),
      ],
    );
  }

  Widget _itemBuilder(
      int index, DateTime date, Vector2 position, GridType type) {
    if (type.sameWith(now, date)) {
      return Dot.current(
        key: UniqueKey(),
        position,
        date: date,
      );
    }

    if (date.isBefore(now)) {
      return Dot.before(
        key: UniqueKey(),
        position,
        date: date,
      );
    }

    return Dot.after(
      key: UniqueKey(),
      position,
      date: date,
    );
  }
}
