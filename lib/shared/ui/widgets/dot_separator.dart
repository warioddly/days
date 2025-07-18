import 'package:days/core/utils/extensions/theme_extensions.dart';
import 'package:flutter/cupertino.dart';

class DotSeparator extends StatelessWidget {
  const DotSeparator({super.key, this.color});


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
