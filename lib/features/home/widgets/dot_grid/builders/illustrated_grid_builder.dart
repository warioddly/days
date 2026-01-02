import 'package:days/features/home/widgets/dot_grid/builders/dot_grid_builder.dart';
import 'package:days/features/home/widgets/dot_grid/dots/illustrated_dot.dart';
import 'package:days/features/home/widgets/dot_grid/grid_animations/dot_hover_animation.dart';
import 'package:flutter/material.dart';

class IllustratedGridBuilder extends DotGridBuilder {
  const IllustratedGridBuilder({super.key});

  @override
  State<IllustratedGridBuilder> createState() => _IllustratedGridBuilderState();
}

class _IllustratedGridBuilderState
    extends DotGridState<IllustratedGridBuilder> {
  final dots = <IllustratedDot>[];

  @override
  Widget itemBuilder(int index, DateTime date, DateTime now) {
    if (dots.length > index) {
      return dots[index];
    }
    dots.add(
      IllustratedDot(
        key: createAndStoreDotKey(),
        date: date,
        isActive: DateUtils.isSameDay(now, date) || date.isBefore(now),
        onEnable: onDotEnable,
        onDisable: onDotDisable,
      ),
    );

    return dots[index];
  }

  @override
  void onPanUpdate(Offset position) {
    // framer.throttle(
    //   () => DotHoverAnimation(
    //     keys: keys,
    //     position: position,
    //     onComplete: onAnimationComplete,
    //     onOverlapping: onOverlapping,
    //   ),
    // );
  }
}
