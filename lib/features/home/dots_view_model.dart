import 'dart:async';

import 'package:days/features/home/widgets/dot_grid/dots/dot.dart';
import 'package:days/features/home/widgets/dot_grid/grid_animations/dot_disable_animation.dart';
import 'package:days/shared/package/vm/view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DotsViewModel extends ViewModel {

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
      const Duration(seconds: 3),
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

}
