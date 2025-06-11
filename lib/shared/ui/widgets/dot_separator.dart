import 'package:days/core/extensions/theme_extensions.dart';
import 'package:flutter/cupertino.dart';

class DotSeparator extends StatelessWidget {
  const DotSeparator({super.key});

  @override
  Widget build(BuildContext context) {
    return Icon(
      CupertinoIcons.circle_filled,
      color: context.colorScheme.onPrimary,
      size: 7,
    );
  }
}
