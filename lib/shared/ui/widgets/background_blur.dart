import 'dart:ui';
import 'package:flutter/material.dart';

class BackgroundBlur extends StatelessWidget {
  const BackgroundBlur({super.key});

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 45, sigmaY: 45),
      child: Container(
        color: Colors.black.withAlpha(200),
      ),
    );
  }
}
