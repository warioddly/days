import 'dart:math';

import 'package:days/core/assets/illustration_assets.dart';
import 'package:days/core/constants/dimensions.dart';
import 'package:days/core/extensions/theme_extensions.dart';
import 'package:days/features/app/presentation/bloc/theme/theme_bloc.dart';
import 'package:days/features/home/presentation/widgets/dot_grid/dots/default_dot.dart';
import 'package:days/features/home/presentation/widgets/dot_grid/dots/dot.dart';
import 'package:days/shared/ui/animations/utils/curves.dart';
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
  State<Dot> createState() => _IllustratedDotState();
}

class _IllustratedDotState extends DotState<IllustratedDot> {
  final _image = IllustrationAssets.getRandomIllustration();
  late final _randomOffset = Offset(_randomSize(), _randomSize());

  @override
  void initState() {
    super.initState();

    if (widget.isActive) {
      Future.delayed(
        Duration(milliseconds: Random().nextInt(901) + 100),
        enable,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox.square(
      dimension: Dimensions.dotContainerSize,
      child: Transform.translate(
        offset: _randomOffset,
        child: BlocBuilder<ThemeBloc, Brightness>(
          builder: (context, state) {
            return ListenableBuilder(
              listenable: controller,
              builder: (context, _) {
                return AnimatedSwitcher(
                  duration: Durations.medium3,
                  reverseDuration: Durations.long3,
                  switchInCurve: SharedCurves.bounceAnimation,
                  switchOutCurve: Curves.fastEaseInToSlowEaseOut,
                  transitionBuilder: (child, animation) =>
                      ScaleTransition(scale: animation, child: child),
                  child: isActive
                      ? Image.asset(
                          _image,
                          color: context.colorScheme.onPrimary,
                        )
                      : DefaultDot(
                          key: UniqueKey(),
                          size: 1.5,
                          color: widget.isActive
                              ? Colors.transparent
                              : context.colorScheme.onPrimary,
                        ),
                );
              },
            );
          },
        ),
      ),
    );
  }

  @override
  void enable() {
    if (isActive || !mounted) {
      return;
    }
    controller.setActive(true);
    widget.onEnable?.call();
  }

  @override
  void disable([bool shouldDisableActive = false]) {
    if (!isActive || (shouldDisableActive && widget.isActive)) {
      return;
    }
    controller.setActive(false);
    widget.onDisable?.call();
  }

  double _randomSize() => Random().nextDouble() * (widget.isActive ? 9 : 6);
}
