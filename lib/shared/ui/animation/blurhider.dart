import 'dart:ui';

import 'package:flutter/material.dart';

class BlurHider extends StatelessWidget {
  const BlurHider({
    required this.controller,
    required this.child,
    super.key,
    this.sigma = 18,
  });

  final AnimationController controller;
  final Widget child;
  final double sigma;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) {
        final value = controller.value;
        final blurValue = value * sigma;
        return ImageFiltered(
          imageFilter: ImageFilter.blur(
            sigmaX: blurValue,
            sigmaY: blurValue,
          ),
          child: value < .8 ? child : null,
        );
      },
      child: child,
    );
  }
}
