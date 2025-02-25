import 'package:days/features/home/presentation/widgets/dot_grid/dots/dot.dart';
import 'package:days/features/home/presentation/widgets/dot_grid/grid_animations/dot_animation.dart';
import 'package:flutter/cupertino.dart';

final class DotFollowersAnimation extends DotAnimation {
  DotFollowersAnimation({
    required super.keys,
    required super.position,
    super.onComplete,
    super.onOverlapping
  });

  @override
  void animate(
    List<GlobalKey<DotState>> keys,
    Offset position, {
    VoidCallback? onComplete,
    OnOverlapping? onOverlapping,
  }) {

    for (int i = 0; i < keys.length; i++) {
      final box = keyRenderBox(keys[i]);
      if (box != null && isInside(box, position)) {

        final reversedKeys = keys.reversed.toList();
        for (int j = 0; j < reversedKeys.length; j++) {

          if (reversedKeys[j] == keys[i]) {
            break;
          }

          if (keyRenderBox(reversedKeys[j]) != null) {
            disableKey(reversedKeys[j]);
          }
        }

        for (int j = 0; j <= i; j++) {
          final key = keys[j];
          onOverlapping?.call(key, position);
          enableKey(key);
        }
        onComplete?.call();
        break;
      }
    }
  }
}
