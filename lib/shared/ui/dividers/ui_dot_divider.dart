import 'package:days/core/utils/extensions/theme_extensions.dart';
import 'package:flutter/cupertino.dart';

class UIDotDivider extends StatelessWidget {
  const UIDotDivider({super.key, this.color});

  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Icon(
      CupertinoIcons.circle_filled,
      color: color ?? context.colorScheme.onPrimary,
      size: 7,
    );
  }
}
