import 'package:days/core/utils/frame_rate_utils.dart';
import 'package:days/features/app/presentation/bloc/theme_bloc.dart';
import 'package:days/features/home/domain/entity/settings_entity.dart';
import 'package:days/features/home/presentation/bloc/dots_manager/dots_manager_bloc.dart';
import 'package:days/features/home/presentation/bloc/settings/settings_bloc.dart';
import 'package:days/features/home/presentation/widgets/dot_grid/dot_grid_body_builder.dart';
import 'package:days/features/home/presentation/widgets/dot_grid/dots/doted_dot.dart';
import 'package:days/features/home/presentation/widgets/dot_grid/dots/dot.dart';
import 'package:days/features/home/presentation/widgets/dot_grid/dots/illustrated_dot.dart';
import 'package:days/features/home/presentation/widgets/dot_grid/grid_animations/dot_disable_animation.dart';
import 'package:days/features/home/presentation/widgets/dot_grid/grid_animations/dot_followers_animation.dart';
import 'package:days/features/home/presentation/widgets/dot_grid/grid_animations/dot_hover_animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


typedef ItemBuilder = Widget Function(int index, DateTime date, DateTime now);

class DotGridBody extends StatefulWidget {
  const DotGridBody({super.key});

  @override
  State<DotGridBody> createState() => _DotGridBodyState();
}

class _DotGridBodyState extends State<DotGridBody> {

  final keys = <GlobalKey<DotState>>[];
  final framer = Framer();

  @override
  Widget build(BuildContext context) {
    return BlocListener<DotsManagerBloc, DotsManagerModelState>(
      listener: _dotsManagerListener,
      child: BlocConsumer<SettingsBloc, SettingsModelState>(
        listener: _settingsListener,
        builder: (context, state) {
          final eventState = state.state;

          if (eventState is SettingsLoaded) {
            final gridType = state.entity.gridType;
            return DotGridBodyBuilder(
              now: DateTime.now(),
              onPanUpdate: onPanUpdate(gridType),
              itemBuilder: itemBuilder(gridType),
            );
          }

          if (eventState is SettingsLoading) {
            return const Center(
              child: CupertinoActivityIndicator(),
            );
          }

          return const SizedBox();
        },
      ),
    );
  }

  ItemBuilder itemBuilder(GridType gridType) {
    return switch(gridType) {
      GridType.doted => _dotedItemBuilder,
      GridType.illustrated => _illustratedItemBuilder,
    };
  }

  void Function(Offset globalPosition) onPanUpdate(GridType gridType) {

    void onAnimationComplete() {
      context.read<DotsManagerBloc>().add(DotsManagerUserHoveredEvent());
    }

    return switch(gridType) {
      GridType.doted => (Offset globalPosition) => framer.throttle(
        () => DotFollowersAnimation(
          keys: keys,
          globalPosition: globalPosition,
          onComplete: onAnimationComplete,
        ),
      ),
      GridType.illustrated => (Offset globalPosition) => framer.throttle(
        () => DotHoverAnimation(
          keys: keys,
          globalPosition: globalPosition,
          onComplete: onAnimationComplete,
        ),
      ),
    };
  }

  void _dotsManagerListener(BuildContext context, DotsManagerModelState state) {
    final eventState = state.state;

    if (eventState is DotsManagerUserOutsideClicked) {
      DotDisableAnimation(keys: keys, globalPosition: Offset.zero);
    }
  }

  void _settingsListener(BuildContext context, SettingsModelState state) {
    if (state.state is SettingsLoading) {
      keys.clear();
      context.read<DotsManagerBloc>().add(DotsManagerActiveDotsCountResetEvent());
    }
  }

  Widget _dotedItemBuilder(int index, DateTime date, DateTime now) {
    return DotedDot(
      key: createAndStoreDotKey(),
      date: date,
      isActive: DateUtils.isSameDay(now, date) || date.isBefore(now),
      onEnable: onDotEnable,
      onDisable: onDotDisable,
    );
  }

  Widget _illustratedItemBuilder(int index, DateTime date, DateTime now) {
    return IllustratedDot(
      key: createAndStoreDotKey(),
      date: date,
      isActive: DateUtils.isSameDay(now, date) || date.isBefore(now),
      onEnable: onDotEnable,
      onDisable: onDotDisable,
    );
  }

  GlobalKey<DotState> createAndStoreDotKey() {
    final key = GlobalKey<DotState>();
    keys.add(key);
    return key;
  }

  void onDotEnable() {
    context.read<DotsManagerBloc>().add(DotsManagerActiveDotsIncrementEvent());
  }

  void onDotDisable() {
    context.read<DotsManagerBloc>().add(DotsManagerActiveDotsDecrementEvent());
  }

}