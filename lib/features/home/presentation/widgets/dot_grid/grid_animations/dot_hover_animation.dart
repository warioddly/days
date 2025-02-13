import 'package:days/features/home/presentation/widgets/dot_grid/dots/dot.dart';
import 'package:days/features/home/presentation/widgets/dot_grid/grid_animations/dot_animation.dart';
import 'package:flutter/cupertino.dart';

final class DotHoverAnimation extends DotAnimation {
  DotHoverAnimation({
    required super.keys,
    required super.globalPosition,
    super.onComplete,
  });

  @override
  void animate(
    List<GlobalKey<DotState>> keys,
    Offset globalPosition, {
    VoidCallback? onComplete,
  }) {
    for (final key in keys) {
      final box = keyRenderBox(key);
      if (box != null && isInside(box, globalPosition)) {
        enableKey(key);
        onComplete?.call();
        break;
      }
    }
  }
}
