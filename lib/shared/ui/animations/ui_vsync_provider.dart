import 'package:flutter/material.dart';

class UIVsyncProvider extends StatefulWidget {
  const UIVsyncProvider({required this.child, super.key});
  final Widget child;

  static TickerProvider of(BuildContext context) {
    final provider = context.dependOnInheritedWidgetOfExactType<_InheritedUIVsyncProvider>();
    assert(
      provider != null,
      'No UIVsyncProvider found in context. Make sure to wrap your widget tree with UIVsyncProvider.',
    );
    return provider!.vsync;
  }

  @override
  State<UIVsyncProvider> createState() => _UIVsyncProviderState();
}

class _UIVsyncProviderState extends State<UIVsyncProvider> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return _InheritedUIVsyncProvider(
      vsync: this,
      child: widget.child,
    );
  }
}

class _InheritedUIVsyncProvider extends InheritedWidget {
  const _InheritedUIVsyncProvider({
    required this.vsync,
    required super.child,
  });

  final TickerProvider vsync;

  @override
  bool updateShouldNotify(_InheritedUIVsyncProvider oldWidget) {
    return vsync != oldWidget.vsync;
  }
}
