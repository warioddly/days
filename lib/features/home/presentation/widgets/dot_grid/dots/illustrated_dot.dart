import 'dart:math';

import 'package:days/core/assets/illustration_assets.dart';
import 'package:days/core/constants/dimensions.dart';
import 'package:days/features/app/presentation/bloc/theme_bloc.dart';
import 'package:days/features/home/presentation/widgets/dot_grid/dots/default_dot.dart';
import 'package:days/features/home/presentation/widgets/dot_grid/dots/dot.dart';
import 'package:days/shared/ui/animation/utils/curves.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


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

  late final DotController _controller;

  final image = IllustrationAssets.getRandomIllustration();
  late final padding = _randomPadding();
  late final colorScheme = Theme.of(context).colorScheme;

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
                duration: const Duration(milliseconds: 400),
                reverseDuration: const Duration(milliseconds: 500),
                switchInCurve: SharedCurves.bounceAnimation,
                switchOutCurve: Curves.fastEaseInToSlowEaseOut,
                transitionBuilder: (child, animation) => ScaleTransition(
                  scale: animation,
                  child: child,
                ),
                child: _controller.isActive ? Image.asset(
                  image,
                  color: Theme.of(context).colorScheme.onPrimary,
                ) : Padding(
                  key: UniqueKey(),
                  padding: padding,
                  child: DefaultDot(
                    size: 1.5,
                    color: Theme.of(context).colorScheme.onPrimary,
                  ),
                ),
              );
            }
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
