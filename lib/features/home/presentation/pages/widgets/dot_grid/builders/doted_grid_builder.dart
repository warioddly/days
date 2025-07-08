import 'package:days/features/home/presentation/pages/widgets/dot_grid/builders/dot_grid_builder.dart';
import 'package:days/features/home/presentation/pages/widgets/dot_grid/dots/doted_dot.dart';
import 'package:days/features/home/presentation/pages/widgets/dot_grid/grid_animations/dot_followers_animation.dart';
import 'package:flutter/material.dart';

class DotedGridBuilder extends DotGridBuilder {

  const DotedGridBuilder({super.key});

  @override
  State<DotedGridBuilder> createState() => _DotedGridBuilderState();
}

class _DotedGridBuilderState extends DotGridState<DotedGridBuilder> {

  @override
  Widget itemBuilder(int index, DateTime date, DateTime now) {
    return DotedDot(
      key: createAndStoreDotKey(),
      date: date,
      isActive: DateUtils.isSameDay(now, date) || date.isBefore(now),
      onEnable: onDotEnable,
      onDisable: onDotDisable,
    );
  }

  @override
  void onPanUpdate(Offset position) {
    framer.throttle(
      () => DotFollowersAnimation(
        keys: keys,
        position: position,
        onComplete: () => onAnimationComplete(context),
        onOverlapping: onOverlapping
      ),
    );
  }

}
