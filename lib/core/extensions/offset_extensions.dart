import 'dart:ui';

extension OffsetExtensions on Offset {

  double distanceTo(Offset other) {
    return (this - other).distance;
  }

}
