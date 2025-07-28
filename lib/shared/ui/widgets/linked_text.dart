import 'package:days/core/utils/extensions/theme_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class LinkedText extends StatelessWidget {
  const LinkedText({
    required this.title,
    super.key,
    this.onPressed,
    this.style,
  });

  final VoidCallback? onPressed;
  final String title;
  final TextStyle? style;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        HapticFeedback.selectionClick();
        onPressed?.call();
      },
      child: Text(title, style: style ?? context.textTheme.labelLarge),
    );
  }
}
