import 'dart:math';

import 'package:days/features/home/presentation/widgets/dot_grid/builders/dot_grid_builder.dart';
import 'package:days/features/home/presentation/widgets/dot_grid/dots/illustrated_dot.dart';
import 'package:days/features/home/presentation/widgets/dot_grid/grid_animations/dot_hover_animation.dart';
import 'package:flutter/material.dart';

class IllustratedGridBuilder extends DotGridBuilder {
  const IllustratedGridBuilder({super.key});

  @override
  State<IllustratedGridBuilder> createState() => _IllustratedGridBuilderState();
}

class _IllustratedGridBuilderState
    extends DotGridState<IllustratedGridBuilder> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      for (final key in dotKeyManager.keys) {
        if (key.currentState?.widget.isActive ?? false) {
          Future.delayed(
            Duration(milliseconds: Random().nextInt(1301) + 100),
            key.currentState?.enable,
          );
        }
      }
    });
  }

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
        position: position,
        onComplete: () => onAnimationComplete(context),
        onOverlapping: onOverlapping,
      ),
    );
  }
}
