
import 'package:days/core/constants/dimensions.dart';
import 'package:days/core/extensions/dimensions_extensions.dart';
import 'package:flutter/cupertino.dart';

class CupertinoSheetWrapper extends StatelessWidget {
  const CupertinoSheetWrapper({required this.child, super.key});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Center(
      heightFactor: 1,
      child: Container(
        constraints: BoxConstraints(
          maxWidth: Dimensions.maxViewWidthSize,
          maxHeight: MediaQuery.of(context).size.height * 0.92,
        ),
        child: Padding(
          padding: Dimensions.normal.padding,
          child: child,
        ),
      ),
    );
  }
}
