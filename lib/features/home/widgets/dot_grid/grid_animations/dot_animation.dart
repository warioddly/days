import 'package:days/features/home/widgets/dot_grid/dots/dot.dart';
import 'package:flutter/cupertino.dart';

typedef OnOverlapping = void Function(GlobalKey<DotState> key, Offset position);

abstract class DotAnimation {
  DotAnimation({
    required List<GlobalKey<DotState>> keys,
    required Offset position,
    VoidCallback? onComplete,
    OnOverlapping? onOverlapping,
  }) {
    animate(
      keys,
      position,
      onComplete: onComplete,
      onOverlapping: onOverlapping,
    );
  }

  void animate(
    List<GlobalKey<DotState>> keys,
    Offset position, {
      VoidCallback? onComplete,
      OnOverlapping? onOverlapping,
    }
  );

  RenderBox? keyRenderBox(GlobalKey<DotState> key) {
    return key.currentContext?.findRenderObject() as RenderBox?;
  }

  void enableKey(GlobalKey<DotState> key) {
    key.currentState?.enable();
  }

  void disableKey(GlobalKey<DotState> key) {
    key.currentState?.disable();
  }

  void disableOldDaysKey(GlobalKey<DotState> key) {
    key.currentState?.disable(true);
  }

  bool isInside(RenderBox box, Offset position) {
    final local = box.globalToLocal(position);
    return box.paintBounds.contains(local);
  }

}
