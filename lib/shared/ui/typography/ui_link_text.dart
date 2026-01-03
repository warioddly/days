import 'package:days/core/utils/extensions/theme_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class UILinkText extends StatelessWidget {
  const UILinkText({
    required this.title,
    super.key,
    this.onTap,
    this.style,
  });

  final VoidCallback? onTap;
  final String title;
  final TextStyle? style;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        HapticFeedback.lightImpact();
        onTap?.call();
      },
      child: Text(
        title,
        style: style ?? context.textTheme.labelLarge,
      ),
    );
  }
}
