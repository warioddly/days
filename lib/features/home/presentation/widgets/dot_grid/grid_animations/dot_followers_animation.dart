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
    List<GlobalKey<DotState>> keys,
    Offset globalPosition, {
    VoidCallback? onComplete,
    VoidCallback? onEnable,
    VoidCallback? onDisable,
  }) {



    for (int i = 0; i < keys.length; i++) {
      final box = keyRenderBox(keys[i]);
      if (box != null && isInside(box, globalPosition)) {

        final reversedKeys = keys.reversed.toList();
        for (int j = 0; j < reversedKeys.length; j++) {

          if (reversedKeys[j] == keys[i]) {
            break;
          }

          if (keyRenderBox(reversedKeys[j]) != null) {
            disableKey(reversedKeys[j]);
            onDisable?.call();
          }
        }

        for (int j = 0; j <= i; j++) {
          enableKey(keys[j]);
          onEnable?.call();
        }
        onComplete?.call();
        break;
      }
    }
  }
}
