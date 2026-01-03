import 'package:flutter/animation.dart';

class UICurves {

  static const bounceAnimation = ThreePointCubic(
    Offset(0.056, 0.024),
    Offset(0.108, 0.3085),
    Offset(0.198, 0.541),
    Offset(0.3655, 2.0),
    Offset(0.5465, 0.989),
  );

  static const bounceSwitchAnimation = ThreePointCubic(
    Offset(0.056, 0.024),
    Offset(0.208, 0.3085),
    Offset(0.322, .99),
    Offset(0.421, 1.16),
    Offset(0.546, 1.0),
  );

}