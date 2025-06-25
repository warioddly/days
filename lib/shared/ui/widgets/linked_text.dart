import 'package:days/core/extensions/theme_extensions.dart';
import 'package:flutter/material.dart';

class LinkedText extends StatelessWidget {
  const LinkedText({required this.title, super.key, this.onPressed, this.style});

  final VoidCallback? onPressed;
  final String title;
  final TextStyle? style;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Text(
        title,
        style: style ?? context.textTheme.labelLarge
      ),
    );
  }
}
