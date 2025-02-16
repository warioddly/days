import 'package:days/core/constants/dimensions.dart';
import 'package:days/core/extensions/dimensions_extensions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SlidingSegmentControl<T extends Object> extends StatelessWidget {
  const SlidingSegmentControl({
    required this.groupValue,
    required this.onValueChanged,
    required this.children,
    super.key,
  });

  final T groupValue;
  final ValueChanged<T?> onValueChanged;
  final Map<T, Widget> children;

  @override
  Widget build(BuildContext context) {
    return CupertinoSlidingSegmentedControl<T>(
      padding: Dimensions.small.padding,
      backgroundColor: Colors.white10,
      thumbColor: Theme.of(context).colorScheme.onPrimary,
      groupValue: groupValue,
      onValueChanged: onValueChanged,
      children: children,
    );
  }
}
