

import 'package:flutter/cupertino.dart';

class BarController extends ChangeNotifier {

  final AnimationController bar;
  final AnimationController gridType;

  BarController({
    required this.bar,
    required this.gridType,
  });

}
