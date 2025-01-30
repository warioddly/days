import 'package:days/core/constants/dimensions.dart';
import 'package:days/core/extensions/dimensions_extensions.dart';
import 'package:flutter/material.dart';

class CardContainer extends StatelessWidget {
  const CardContainer({
    required this.child,
    this.padding,
    this.margin,
    super.key,
  });

  final Widget child;
  final EdgeInsets? padding;
  final EdgeInsets? margin;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin ?? Dimensions.dotContainerSize.padding.copyWith(
          top: Dimensions.small,
          bottom: Dimensions.large
      ),
      decoration: BoxDecoration(
        borderRadius: Dimensions.extra.allBorder,
        color: Colors.black.withAlpha(180),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.5),
            blurRadius: 10,
          ),
        ],
      ),
      padding: padding ?? Dimensions.large.padding.copyWith(
        top: Dimensions.small,
        bottom: Dimensions.small,
      ),
      child: child,
    );
  }
}
