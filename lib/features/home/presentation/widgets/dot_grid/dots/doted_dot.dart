import 'package:days/core/constants/dimensions.dart';
import 'package:days/features/app/presentation/bloc/theme_bloc.dart';
import 'package:days/features/home/presentation/widgets/dot_grid/dots/default_dot.dart';
import 'package:days/features/home/presentation/widgets/dot_grid/dots/dot.dart';
import 'package:days/shared/ui/animation/utils/curves.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

const _dotSize = 5.0;

class DotedDot extends Dot {
  const DotedDot({
    super.key,
    super.date,
    super.color,
    super.isActive = true,
    super.onEnable,
    super.onDisable,
  });

  @override
  State<DotedDot> createState() => IllustratedDotState();
}

class IllustratedDotState extends DotState<DotedDot> {
  late final DotController _controller;

  final dot = DefaultDot(
    color: CupertinoColors.tertiarySystemFill.darkHighContrastColor,
    size: _dotSize,
  );

  @override
  void initState() {
    super.initState();
    _controller = DotController(widget.isActive);
    if (widget.isActive) {
      widget.onEnable?.call();
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox.square(
      dimension: Dimensions.dotContainerSize,
      child: BlocBuilder<ThemeBloc, Brightness>(
        builder: (context, state) {
          return ListenableBuilder(
            listenable: _controller,
            builder: (context, _) {
              return AnimatedSwitcher(
                duration: const Duration(milliseconds: 250),
                reverseDuration: const Duration(milliseconds: 250),
                switchInCurve: SharedCurves.bounceAnimation,
                switchOutCurve: Curves.fastEaseInToSlowEaseOut,
                transitionBuilder: (child, animation) =>
                        ScaleTransition(scale: animation, child: child),
                child: _controller.isActive
                        ? DefaultDot(
                          key: ObjectKey(widget.date?.toIso8601String() ?? ''),
                          color: Theme.of(context).colorScheme.onPrimary,
                          size: _dotSize,
                        ) : dot,
              );
            },
          );
        },
      ),
    );
  }

  @override
  void enable() {
    if (_controller.isActive) {
      return;
    }
    _controller.setActive(true);
    widget.onEnable?.call();
  }

  @override
  void disable([bool shouldDisableActive = false]) {
    if (!_controller.isActive || (shouldDisableActive && widget.isActive)) {
      return;
    }
    _controller.setActive(false);
    widget.onDisable?.call();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
