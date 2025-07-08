import 'package:days/core/constants/dimensions.dart';
import 'package:flutter/material.dart';

class DefaultDot extends StatelessWidget {
  const DefaultDot({
    super.key,
    this.color = Colors.white,
    this.size = Dimensions.dotSize,
  });

  final Color? color;
  final double size;

  @override
  Widget build(BuildContext context) {
    return SizedBox.square(
      dimension: size,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
        ),
      ),
    );
  }
}
