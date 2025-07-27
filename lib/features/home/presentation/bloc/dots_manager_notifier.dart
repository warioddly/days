import 'dart:async';

import 'package:days/core/constants/constants.dart';
import 'package:days/features/home/presentation/pages/widgets/dot_grid/dots/dot.dart';
import 'package:days/features/home/presentation/pages/widgets/dot_grid/grid_animations/dot_disable_animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

const _dotDeactivateDuration = Duration(
  milliseconds: Constants.deactivateDotDurationInMilliseconds,
);

class DotsManagerNotifier extends ChangeNotifier {

  final List<GlobalKey<DotState>> _keys = [];

  List<GlobalKey<DotState>> get keys => List.unmodifiable(_keys);

  GlobalKey<DotState> addKey() {
    final key = GlobalKey<DotState>();
    _keys.add(key);
    return key;
  }

  void clearKeys() {
    _keys.clear();
  }

  Timer? _resetHoverActivatedDotsTimer;

  int _activeDots = 0;

  int get activeDots => _activeDots;

  void userOutsideClick() {
    _resetHoverActivatedDotsTimer?.cancel();
    _resetHoverActivatedDotsTimer = null;
    _disableAllDots();
  }

  void userHovered() {
    _resetHoverActivatedDotsTimer?.cancel();
    _resetHoverActivatedDotsTimer = Timer(
      _dotDeactivateDuration,
      userOutsideClick,
    );
  }

  void incrementActiveDots() {
    _activeDots += 1;
    notifyListeners();
  }

  void decrementActiveDots() {
    if (_activeDots > 0) {
      _activeDots -= 1;
      notifyListeners();
    }
  }

  void reset() {
    _activeDots = 0;
    clearKeys();
    _resetHoverActivatedDotsTimer?.cancel();
    notifyListeners();
  }

  void _disableAllDots() {
    DotDisableAnimation(keys: _keys);
  }

  @override
  void dispose() {
    _resetHoverActivatedDotsTimer?.cancel();
    _resetHoverActivatedDotsTimer = null;
    super.dispose();
  }

  static DotsManagerNotifier of(BuildContext context) {
    return Provider.of<DotsManagerNotifier>(context, listen: false);
  }

}
