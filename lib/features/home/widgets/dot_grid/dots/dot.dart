import 'package:days/shared/ui/ui_curves.dart';
import 'package:flutter/material.dart';

final class DotController extends ChangeNotifier {

  DotController(bool isActive) : _isActive = isActive;

  bool _isActive = false;

  bool get isActive => _isActive;

  void setActive(bool active) {
    _isActive = active;
    notifyListeners();
  }

}


abstract class Dot extends StatefulWidget {
  const Dot({
    this.isActive = false,
    super.key,
    this.date,
    this.color,
    this.onEnable,
    this.onDisable,
  });

  final DateTime? date;
  final Color? color;
  final bool isActive;
  final VoidCallback? onEnable;
  final VoidCallback? onDisable;
}

abstract class DotState<T extends Dot> extends State<T> {

  final controller = DotController(false);

  bool get isActive => controller.isActive;

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  /// Enables the dot if it's not already active and the widget is mounted.
  void enable() {
    if (isActive || !mounted) {
      return;
    }
    controller.setActive(true);
    widget.onEnable?.call();
  }

  /// Disables the dot if it's active and the widget is mounted.
  /// [shouldDisableActive] when true, prevents disabling dots that are marked as initially active.
  void disable([bool shouldDisableActive = false]) {
    if (!isActive || (shouldDisableActive && widget.isActive)) {
      return;
    }
    controller.setActive(false);
    widget.onDisable?.call();
  }

  /// Creates an AnimatedSwitcher with common configuration for dot transitions.
  Widget buildDotSwitcher({
    required Duration duration,
    required Duration reverseDuration,
    required Widget child,
  }) {
    return AnimatedSwitcher(
      duration: duration,
      reverseDuration: reverseDuration,
      switchInCurve: UICurves.bounceSwitchAnimation,
      switchOutCurve: Curves.fastEaseInToSlowEaseOut,
      transitionBuilder: (child, animation) =>
          ScaleTransition(scale: animation, child: child),
      child: child,
    );
  }
}
