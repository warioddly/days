import 'package:days/features/home/presentation/widgets/dot_grid/builders/dot_grid_builder.dart';
import 'package:days/features/home/presentation/widgets/dot_grid/dots/illustrated_dot.dart';
import 'package:days/features/home/presentation/widgets/dot_grid/grid_animations/dot_hover_animation.dart';
import 'package:flutter/material.dart';


class IllustratedGridBuilder extends DotGridBuilder {

  const IllustratedGridBuilder({super.key});

  @override
  State<IllustratedGridBuilder> createState() => _DotedGridBuilderState();
}

class _DotedGridBuilderState extends DotGridState<IllustratedGridBuilder> {

  @override
  Widget itemBuilder(int index, DateTime date, DateTime now) {
    return IllustratedDot(
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
      () => DotHoverAnimation(
        keys: keys,
        globalPosition: position,
        onComplete: () => onAnimationComplete(context),
      ),
    );
  }
}
