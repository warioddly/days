import 'package:days/core/constants/breakpoints.dart';
import 'package:flutter/material.dart';

class LayoutBreakpoint extends StatelessWidget {
  const LayoutBreakpoint({required this.child, super.key});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(
        maxWidth: Breakpoints.maxViewWidthSize,
      ),
      child: child,
    );
  }
}
