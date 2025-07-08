import 'package:days/features/home/presentation/pages/widgets/dot_grid/dots/dot.dart';
import 'package:days/features/home/presentation/pages/widgets/dot_grid/grid_animations/dot_animation.dart';
import 'package:flutter/cupertino.dart';

final class DotHoverAnimation extends DotAnimation {
  DotHoverAnimation({
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
    for (final key in keys) {
      final box = keyRenderBox(key);
      if (box != null && isInside(box, position)) {
        onOverlapping?.call(key, position);
        enableKey(key);
        onComplete?.call();
        break;
      }
    }
  }
}
