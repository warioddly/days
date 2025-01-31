import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class ScrollUtils {

  static void onScroll(
    ScrollController controller, {
    VoidCallback? onScrollUp,
    VoidCallback? onScrollDown,
  }) {
    if (!controller.hasClients) {
      return;
    }
    final scrollDirection = controller.position.userScrollDirection;

    if (scrollDirection == ScrollDirection.forward) {
      onScrollUp?.call();
    } else if (scrollDirection == ScrollDirection.reverse) {
      onScrollDown?.call();
    }
  }

}
