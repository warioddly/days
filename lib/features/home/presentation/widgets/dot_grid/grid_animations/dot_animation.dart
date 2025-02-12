import 'package:days/features/home/presentation/widgets/dot_grid/dots/dot.dart';
import 'package:flutter/cupertino.dart';

abstract class DotAnimation {
  DotAnimation({
    required List<GlobalKey<DotState>> keys,
    required Offset globalPosition,
    VoidCallback? onComplete,
  }) {
    animate(keys, globalPosition, onComplete);
  }

  void animate(
    List<GlobalKey<DotState>> keys,
    Offset globalPosition,
    [VoidCallback? onComplete]
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

  bool isInside(RenderBox box, Offset globalPosition) {
    final local = box.globalToLocal(globalPosition);
    return box.paintBounds.contains(local);
  }

}
