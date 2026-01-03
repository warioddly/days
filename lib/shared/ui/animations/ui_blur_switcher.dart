import 'dart:ui';

import 'package:flutter/material.dart';

class UIBlurSwitcher extends StatelessWidget {
  final Widget child;
  final Duration duration;

  const UIBlurSwitcher({
    required this.child,
    this.duration = Durations.medium3,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: AnimatedSwitcher(
        duration: duration,
        switchInCurve: Curves.easeOut,
        switchOutCurve: Curves.easeIn,
        transitionBuilder: (Widget child, Animation<double> animation) {
          return AnimatedBuilder(
            animation: animation,
            builder: (context, _) {
              final blurValue = (1.0 - animation.value) * 3.0;

              return Opacity(
                opacity: animation.value,
                child: ImageFiltered(
                  imageFilter: ImageFilter.blur(
                    sigmaX: blurValue,
                    sigmaY: blurValue,
                  ),
                  child: child,
                ),
              );
            },
          );
        },
        child: child,
      ),
    );
  }
}
