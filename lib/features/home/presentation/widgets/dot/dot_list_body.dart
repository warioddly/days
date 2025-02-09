import 'package:days/core/constants/dimensions.dart';
import 'package:days/core/extensions/dimensions_extensions.dart';
import 'package:days/features/home/domain/entity/settings_entity.dart';
import 'package:days/features/home/presentation/bloc/settings/settings_bloc.dart';
import 'package:days/features/home/presentation/utils/extensions/grid_type_extension.dart';
import 'package:days/features/home/presentation/widgets/dot/illustrated_dot.dart';
import 'package:days/shared/models/vector2.dart';
import 'package:days/shared/package/grid_builder/grid_builder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

class GridListBody extends StatefulWidget {
  const GridListBody({super.key});

  @override
  State<GridListBody> createState() => _GridListBodyState();
}

class _GridListBodyState extends State<GridListBody> {

  var now = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Stack(
        fit: StackFit.expand,
        children: [
          Positioned.fill(
            child: CustomScrollView(
              controller: Provider.of<ScrollController>(context, listen: false),
              slivers: [
                BlocBuilder<SettingsBloc, SettingsModelState>(
                  builder: (context, state) {
                    final eventState = state.state;

                    if (eventState is SettingsLoaded) {
                      final settings = state.entity;

                      now = DateTime.now();
                      final safeAreaPaddingTop = MediaQuery.paddingOf(context).top;

                      return GridBuilder(
                        now: now,
                        from: settings.birthday,
                        to: settings.endDateTime,
                        lengthCalculate: settings.gridType.calculation,
                        dayCalculate: settings.gridType.calculationDay,
                        padding: Dimensions.doubleNormal.padding.copyWith(
                          top: (Dimensions.dotContainerSize * 2) -
                              (Dimensions.dotSize * 2) + safeAreaPaddingTop,
                        ),
                        blockSize: const Size.square(Dimensions.dotContainerSize),
                        itemBuilder: (int index, DateTime date, Vector2 position) {
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
                        ),
                      );
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
          Align(
            alignment: Alignment.topCenter,
            child: Container(
              height: 30,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.black,
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 30,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    Colors.black,
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _itemBuilder(
      int index, DateTime date, Vector2 position, GridType type) {
    if (type.sameWith(now, date)) {

      return IllustratedDot.current(
        key: UniqueKey(),
        position,
        date: date,
      );
    }

    if (date.isBefore(now)) {
      return RepaintBoundary(
        child: IllustratedDot(
          key: UniqueKey(),
          position,
          date: date,
          isActive: false,
          color: Colors.white,
        ),
      );
    }

    return RepaintBoundary(
      child: IllustratedDot.after(
        key: UniqueKey(),
        position,
        date: date,
        isActive: false,
      ),
    );
  }
}
