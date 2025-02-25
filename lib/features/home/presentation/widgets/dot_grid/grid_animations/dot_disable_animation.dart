import 'package:days/features/home/presentation/widgets/dot_grid/dots/dot.dart';
import 'package:days/features/home/presentation/widgets/dot_grid/grid_animations/dot_animation.dart';
import 'package:flutter/cupertino.dart';

final class DotDisableAnimation extends DotAnimation {
  DotDisableAnimation({
    required super.keys,
    required super.position,
    super.onComplete,
    super.onOverlapping,
  });

  @override
  void animate(
    List<GlobalKey<DotState>> keys,
    Offset position, {
    VoidCallback? onComplete,
    OnOverlapping? onOverlapping,
  }) {
    for (int i = 0; i < keys.length; i++) {
      if (keyRenderBox(keys[i]) != null) {
        disableOldDaysKey(keys[i]);
      }
    }
  }
}
