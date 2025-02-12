import 'package:days/core/constants/dimensions.dart';
import 'package:flutter/material.dart';

class DefaultDot extends StatelessWidget {
  const DefaultDot({super.key, this.color = Colors.white});

  final Color color;

  @override
  Widget build(BuildContext context) {
    return SizedBox.square(
      dimension: Dimensions.dotSize,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
        ),
      ),
    );
  }
}

