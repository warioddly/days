
import 'package:days/core/constants/dimensions.dart';
import 'package:flutter/cupertino.dart';

class CupertinoSheetWrapper extends StatelessWidget {
  const CupertinoSheetWrapper({required this.child, super.key});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Center(
        heightFactor: 1,
        child: Container(
          constraints: BoxConstraints(
            maxWidth: Dimensions.maxViewWidthSize,
            maxHeight: MediaQuery.of(context).size.height * 0.8,
          ),
          child: child,
        ),
      ),
    );
  }
}
