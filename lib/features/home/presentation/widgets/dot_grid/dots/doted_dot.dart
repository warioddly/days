import 'package:days/core/constants/dimensions.dart';
import 'package:days/features/home/presentation/widgets/dot_grid/dots/default_dot.dart';
import 'package:days/features/home/presentation/widgets/dot_grid/dots/dot.dart';
import 'package:days/shared/ui/animation/utils/curves.dart';
import 'package:flutter/material.dart';

const _dotSize = 5.0;

class DotedDot extends Dot {

  final bool showBoxShadow;

  const DotedDot({
    super.key,
    super.date,
    super.color,
    this.showBoxShadow = false,
    super.isActive = true,
  });

  const DotedDot.before(Offset position, {
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

  const DotedDot.after({
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

  const DotedDot.current({
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
  State<DotedDot> createState() => IllustratedDotState();

}

class IllustratedDotState extends DotState<DotedDot> {

  bool isActive = false;
  Color color = Colors.white;

  final dot = const DefaultDot(
    color: Colors.white12,
    size: _dotSize,
  );
  late final activeDot = DefaultDot(
    key: ObjectKey(widget.date?.toIso8601String() ?? ''),
    color: Colors.white,
    size: _dotSize,
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
          reverseDuration: const Duration(milliseconds: 300),
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
    color = widget.color ?? Colors.white;

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

}
