import 'package:days/shared/ui/animations/ui_blur_switcher.dart';
import 'package:days/shared/ui/dimensions/dimensions.dart';
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
    final screenSize = MediaQuery.sizeOf(context);

    final textStyle = theme.textTheme.bodyMedium?.copyWith(
      color: theme.colorScheme.onPrimary,
      fontWeight: FontWeight.w600,
    );

    final textPainter = TextPainter(
      text: TextSpan(text: content, style: textStyle),
      textDirection: TextDirection.ltr,
      maxLines: 1,
    )..layout();

    final desiredPosition = position - const Offset(70, 53);

    var dx = desiredPosition.dx;
    if (dx < 20) dx = 20;

    if (dx + textPainter.width + 20 > screenSize.width) {
      dx = screenSize.width - textPainter.width - 20;
    }

    final safePosition = Offset(dx, desiredPosition.dy);

    return Positioned(
      left: safePosition.dx,
      top: safePosition.dy,
      child: IgnorePointer(
        child: DecoratedBox(
          decoration: ShapeDecoration(
            color: theme.primaryColor,
            shape: RoundedSuperellipseBorder(
              side: BorderSide(
                color: theme.colorScheme.onPrimary,
                width: 0.3,
              ),
              borderRadius: Borders.ms,
            ),
            shadows: [
              BoxShadow(
                color: theme.colorScheme.onPrimary.withAlpha(70),
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Padding(
            padding: Insets.sHorizontal + Insets.xsVertical,
            child: UIBlurSwitcher(
              child: Text(
                content,
                key: ValueKey(content),
                style: textStyle,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
