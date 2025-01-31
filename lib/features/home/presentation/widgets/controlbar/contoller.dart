

import 'package:flutter/cupertino.dart';

class BarController extends ChangeNotifier {

  final AnimationController bar;
  final AnimationController gridType;
  bool showGridType = false;

  BarController({
    required this.bar,
    required this.gridType,
  });

  @override
  void dispose() {
    bar.dispose();
    gridType.dispose();
    super.dispose();
  }

}
