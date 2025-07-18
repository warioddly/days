import 'package:days/core/constants/dimensions.dart';
import 'package:days/shared/ui/animations/blurred_switcher.dart';
import 'package:flutter/material.dart';

class TooltipOverlayEntry extends StatelessWidget {
  const TooltipOverlayEntry({
    required this.content,
    required this.position,
    super.key,
  });

  final String content;
  final Offset position;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final position = this.position - const Offset(70, 53);
    return AnimatedPositioned(
      duration: const Duration(milliseconds: 50),
      curve: Curves.linear,
      left: position.dx,
      top: position.dy,
      child: RepaintBoundary(
        child: IgnorePointer(
          child: Container(
            padding: Insets.sHorizontal + Insets.xsVertical,
            decoration: BoxDecoration(
              color: theme.primaryColor,
              borderRadius: Borders.s,
              border: Border.all(color: theme.colorScheme.onPrimary, width: 0.3),
              boxShadow: [
                BoxShadow(
                  color: theme.colorScheme.onPrimary.withAlpha(70),
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: BlurredSwitcher(
              child: Text(
                content,
                key: ValueKey(content),
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.colorScheme.onPrimary,
                  fontWeight: FontWeight.w600
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
