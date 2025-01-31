import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class MediaQueryUtils {
  static Size get screenSize {
    return PlatformDispatcher.instance.views.first.display.size;
  }

  static double get getScreenWidth => screenSize.width;

  static double get screenHeight => screenSize.height;
}
