import 'package:days/features/home/presentation/widgets/tooltip/orbit_tooltip.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


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

  late final DotController controller;

  late final tooltip = context.read<OrbitTooltipNotifier>();

  bool get isActive => controller.isActive;

  @override
  void initState() {
    super.initState();
    controller = DotController(widget.isActive);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void enable();
  void disable([bool shouldDisableActive = false]);
}
