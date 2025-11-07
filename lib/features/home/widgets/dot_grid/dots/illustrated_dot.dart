import 'dart:math';

import 'package:days/core/assets/illustration_assets.dart';
import 'package:days/core/utils/extensions/theme_extensions.dart';
import 'package:days/features/home/widgets/dot_grid/dots/default_dot.dart';
import 'package:days/features/home/widgets/dot_grid/dots/dot.dart';
import 'package:days/shared/ui/dimensions/dimensions.dart';
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
        child:  ListenableBuilder(
          listenable: controller,
          builder: (context, _) {
            return buildDotSwitcher(
              duration: Durations.medium3,
              reverseDuration: Durations.long3,
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
        ),
      ),
    );
  }


  double _randomSize() => Random().nextDouble() * (widget.isActive ? 9 : 6);
}
