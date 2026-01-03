import 'package:days/features/home/widgets/tooltip/tooltip_overlay.dart';
import 'package:flutter/material.dart';

class TooltipProvider extends StatefulWidget {
  const TooltipProvider({required this.child, super.key});
  final Widget child;

  static TooltipOverlay of(BuildContext context) {
    final provider = context.dependOnInheritedWidgetOfExactType<_InheritedTooltipProvider>();
    assert(
      provider != null,
      'No TooltipProvider found in context. Make sure to wrap your widget tree with TooltipProvider.',
    );
    return provider!.tooltip;
  }

  @override
  State<TooltipProvider> createState() => _TooltipProviderState();
}

class _TooltipProviderState extends State<TooltipProvider> {
  late final tooltipOverlay = TooltipOverlay(context);

  @override
  Widget build(BuildContext context) {
    return _InheritedTooltipProvider(
      tooltip: tooltipOverlay,
      child: widget.child,
    );
  }

  @override
  void dispose() {
    tooltipOverlay.dispose();
    super.dispose();
  }
}

class _InheritedTooltipProvider extends InheritedWidget {
  const _InheritedTooltipProvider({
    required this.tooltip,
    required super.child,
  });

  final TooltipOverlay tooltip;

  @override
  bool updateShouldNotify(_InheritedTooltipProvider oldWidget) {
    return tooltip != oldWidget.tooltip;
  }
}
