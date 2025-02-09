

import 'package:flutter/animation.dart';

class SharedCurves {

  static const Curve bounceAnimation = ThreePointCubic(
    Offset(0.056, 0.024),
    Offset(0.108, 0.3085),
    Offset(0.198, 0.541),
    Offset(0.3655, 2.0),
    Offset(0.5465, 0.989),
  );

}