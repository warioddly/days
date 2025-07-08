import 'package:days/features/home/presentation/pages/widgets/dot_grid/dots/dot.dart';
import 'package:days/features/home/presentation/pages/widgets/dot_grid/grid_animations/dot_animation.dart';
import 'package:flutter/cupertino.dart';

final class DotOneeeAnimation extends DotAnimation {
  DotOneeeAnimation({
    required super.keys,
    required super.position,
    super.onComplete,
  });

  @override
  void animate(
    List<GlobalKey<DotState>> keys,
    Offset position, {
    VoidCallback? onComplete,
    OnOverlapping? onOverlapping,
  }) {
    for (var i = 0; i < keys.length; i++) {
      if (keyRenderBox(keys[i]) != null) {
        disableOldDaysKey(keys[i]);
      }
    }

    for (final key in keys) {
      final box = keyRenderBox(key);
      if (box != null && isInside(box, position)) {
        enableKey(key);
        onComplete?.call();
        break;
      }
    }
  }
}
