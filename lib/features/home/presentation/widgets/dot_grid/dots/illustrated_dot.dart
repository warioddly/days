import 'dart:math';

import 'package:days/core/assets/illustration_assets.dart';
import 'package:days/core/constants/dimensions.dart';
import 'package:days/features/home/presentation/widgets/dot_grid/dots/default_dot.dart';
import 'package:days/features/home/presentation/widgets/dot_grid/dots/dot.dart';
import 'package:days/shared/ui/animation/utils/curves.dart';
import 'package:flutter/material.dart';


class IllustratedDot extends Dot {

  const IllustratedDot({
    super.key,
    super.date,
    super.color,
    super.isActive = true,
    super.onEnable,
    super.onDisable,
  });

  @override
  State<Dot> createState() => IllustratedDotState();

}

class IllustratedDotState extends DotState<IllustratedDot> {

  bool isActive = false;

  late final colorScheme = Theme.of(context).colorScheme;

  late final dot = Padding(
    padding: _randomPadding(),
    child: DefaultDot(
       size: 1.5,
       color: colorScheme.onPrimary,
    ),
  );
  late final activeDot = Image.asset(
    IllustrationAssets.getRandomIllustration(),
    color: colorScheme.onPrimary,
  );

  @override
  void initState() {
    super.initState();
    isActive = widget.isActive;
    if (widget.isActive) {
      widget.onEnable?.call();
    }
  }

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: SizedBox.square(
        dimension: Dimensions.dotContainerSize,
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 400),
          reverseDuration: const Duration(milliseconds: 500),
          switchInCurve: SharedCurves.bounceAnimation,
          switchOutCurve: Curves.fastEaseInToSlowEaseOut,
          transitionBuilder: (child, animation) => ScaleTransition(
            scale: animation,
            child: child,
          ),
          child: isActive ? activeDot : dot,
        ),
      ),
    );
  }

  @override
  void enable() {
    if (isActive) {
      return;
    }
    isActive = !isActive;
    widget.onEnable?.call();
    setState(() {});
  }

  @override
  void disable([bool shouldDisableActive = false]) {
    if (!isActive || (shouldDisableActive && widget.isActive)) {
      return;
    }
    isActive = false;
    widget.onDisable?.call();
    setState(() { });
  }

  EdgeInsets _randomPadding() {
    return EdgeInsets.only(
      top: _randomSize(),
      left: _randomSize(),
      right: _randomSize(),
      bottom: _randomSize(),
    );
  }

  double _randomSize() => Random().nextDouble() * 6;

}
