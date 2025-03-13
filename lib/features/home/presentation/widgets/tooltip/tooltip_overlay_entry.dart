import 'package:days/core/constants/dimensions.dart';
import 'package:days/core/extensions/dimensions_extensions.dart';
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
    final position = this.position - const Offset(40, 53);
    return AnimatedPositioned(
      duration: const Duration(milliseconds: 50),
      curve: Curves.linear,
      left: position.dx,
      top: position.dy,
      child: RepaintBoundary(
        child: IgnorePointer(
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: Dimensions.half,
              vertical: Dimensions.quarter,
            ),
            decoration: BoxDecoration(
              color: theme.primaryColor,
              borderRadius: Dimensions.half.allBorder,
              border: Border.all(color: theme.colorScheme.onPrimary, width: 1),
              boxShadow: [
                BoxShadow(
                  color: theme.colorScheme.onPrimary.withAlpha(70),
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Text(
              content,
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.onPrimary,
              ),
            ),
          ),
        ),
      ),
    );
  }

}
