import 'package:flutter/material.dart';

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
  void enable();
  void disable([bool shouldDisableActive = false]);
}
