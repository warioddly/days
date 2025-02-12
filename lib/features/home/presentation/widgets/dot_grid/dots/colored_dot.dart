import 'package:days/core/constants/dimensions.dart';
import 'package:days/features/home/presentation/widgets/dot_grid/dots/default_dot.dart';
import 'package:days/features/home/presentation/widgets/dot_grid/dots/dot.dart';
import 'package:days/shared/ui/animation/utils/curves.dart';
import 'package:flutter/material.dart';

class ColoredDot extends Dot {

  final bool showBoxShadow;

  const ColoredDot({
    super.key,
    super.date,
    super.color,
    this.showBoxShadow = false,
    super.isActive = true,
  });

  const ColoredDot.before(Offset position, {
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

  const ColoredDot.after({
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

  const ColoredDot.current({
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

class IllustratedDotState extends DotState<ColoredDot> {

  bool isActive = false;
  Color color = Colors.white;

  final dot = const DefaultDot();
  late final coloredDot = DefaultDot(
    key: UniqueKey(),
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
          duration: const Duration(milliseconds: 150),
          reverseDuration: const Duration(milliseconds: 200),
          switchInCurve: SharedCurves.bounceAnimation,
          switchOutCurve: Curves.fastEaseInToSlowEaseOut,
          transitionBuilder: (child, animation) => child,
          child: isActive ? coloredDot : dot,
        ),
      ),
    );
  }

  @override
  void enable() {

    if (widget.date != null) {
      print(widget.date?.toIso8601String() ?? '');
    }

    if (isActive) {
      return;
    }

    isActive = !isActive;
    color = widget.color ?? Colors.white;

    setState(() {});
  }

  @override
  void disable() {
    if (!isActive) {
      return;
    }
    isActive = false;
    color = widget.color ?? Colors.white;
    setState(() { });
  }

}
