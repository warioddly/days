import 'package:days/core/constants/dimensions.dart';
import 'package:days/core/extensions/theme_extensions.dart';
import 'package:flutter/cupertino.dart';

class SlidingSegmentControl<T extends Object> extends StatelessWidget {
  const SlidingSegmentControl({
    required this.groupValue,
    required this.onValueChanged,
    required this.children,
    this.backgroundColor = CupertinoColors.tertiarySystemFill,
    super.key,
  });

  final T groupValue;
  final ValueChanged<T?> onValueChanged;
  final Map<T, Widget> children;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    return CupertinoSlidingSegmentedControl<T>(
      padding: Insets.quarter,
      thumbColor: context.colorScheme.primary,
      groupValue: groupValue,
      onValueChanged: onValueChanged,
      children: children,
    );
  }
}
