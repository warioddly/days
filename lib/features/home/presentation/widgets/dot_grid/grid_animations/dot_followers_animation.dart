import 'package:days/features/home/presentation/widgets/dot_grid/dots/dot.dart';
import 'package:days/features/home/presentation/widgets/dot_grid/grid_animations/dot_animation.dart';
import 'package:flutter/cupertino.dart';

final class DotFollowersAnimation extends DotAnimation {
  DotFollowersAnimation({
    required super.keys,
    required super.globalPosition,
    super.onComplete,
  });

  @override
  void animate(
    List<GlobalKey<DotState<Dot>>> keys,
    Offset globalPosition,
    [VoidCallback? onComplete]
  ) {
    for (int i = 0; i < keys.length; i++) {
      if (keyRenderBox(keys[i]) != null) {
        disableKey(keys[i]);
      }
    }

    for (int i = 0; i < keys.length; i++) {
      final box = keyRenderBox(keys[i]);
      if (box != null && isInside(box, globalPosition)) {
        for (int j = 0; j <= i; j++) {
          enableKey(keys[j]);
        }

        onComplete?.call();
        break;
      }
    }
  }
}
