import 'dart:ui';
import 'package:flutter/material.dart';

class BackgroundImage extends StatelessWidget {
  const BackgroundImage({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: const BoxDecoration(
        image: DecorationImage(
            image: AssetImage('assets/images/mountain.jpeg'),
            fit: BoxFit.cover,
            filterQuality: FilterQuality.low
        ),
      ),
      child: child,
    );
  }
}
