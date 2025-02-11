import 'package:flutter/material.dart';

class Background extends StatelessWidget {
  const Background({required this.child, super.key});

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
