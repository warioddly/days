import 'package:days/core/constants/dimensions.dart';
import 'package:flutter/material.dart';

class DefaultDot extends StatelessWidget {
  const DefaultDot({super.key});

  @override
  Widget build(BuildContext context) {
    return const SizedBox.square(
      dimension: Dimensions.dotSize,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
        ),
      ),
    );
  }
}

