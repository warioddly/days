import 'dart:math';

import 'package:days/core/assets/illustration_assets.dart';
import 'package:days/core/constants/dimensions.dart';
import 'package:days/features/home/presentation/widgets/dot_grid/dots/default_dot.dart';
import 'package:days/features/home/presentation/widgets/dot_grid/dots/dot.dart';
import 'package:days/shared/ui/animation/utils/curves.dart';
import 'package:flutter/material.dart';


class IllustratedDot extends Dot {

  final bool showBoxShadow;

  const IllustratedDot({
    super.key,
    super.date,
    super.color,
    this.showBoxShadow = false,
    super.isActive = true,
  });

  const IllustratedDot.before(Offset position, {
    Key? key,
    DateTime? date,
    bool showBoxShadow = false,
    bool isActive = false,
  }) : this(
    date: date,
    color: Colors.white,
    showBoxShadow: showBoxShadow,
    isActive: isActive,
    key: key,
  );

  const IllustratedDot.after({
    Key? key,
    DateTime? date,
    bool showBoxShadow = true,
    bool isActive = true,
  }) : this(
    date: date,
    color: Colors.white12,
    showBoxShadow: showBoxShadow,
    isActive: isActive,
    key: key,
  );

  const IllustratedDot.current({
    Key? key,
    DateTime? date,
    bool showBoxShadow = true,
    bool isActive = true,
  }) : this(
    date: date,
    color: Colors.tealAccent,
    showBoxShadow: showBoxShadow,
    key: key,
    isActive: isActive,
  );

  @override
  State<Dot> createState() => IllustratedDotState();

}

class IllustratedDotState extends DotState<IllustratedDot> {

  bool isActive = false;
  Color color = Colors.white;

  late final dot = Padding(
    padding: _randomPadding(),
    child: const DefaultDot(
      size: 1.5,
    ),
  );
  late final activeDot = Image.asset(
    IllustrationAssets.getRandomIllustration(),
    color: color,
  );

  @override
  void initState() {
    super.initState();
    isActive = widget.isActive;
    color = widget.color ?? Colors.white;
  }

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: SizedBox.square(
        dimension: Dimensions.dotContainerSize,
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 450),
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
    color = Colors.white;

    setState(() {});
  }

  @override
  void disable([bool shouldDisableActive = false]) {
    if (!isActive || (shouldDisableActive && widget.isActive)) {
      return;
    }
    isActive = false;
    color = widget.color ?? Colors.white;
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
