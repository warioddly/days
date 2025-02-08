import 'package:flutter/material.dart';

const _defaultDotSize = 3.0;

class DefaultDot extends StatelessWidget {
  const DefaultDot({super.key});

  @override
  Widget build(BuildContext context) {
    return const SizedBox.square(
      dimension: _defaultDotSize,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: Colors.white12,
          shape: BoxShape.circle,
        ),
      ),
    );
  }
}
