import 'dart:async';

import 'package:days/features/home/presentation/pages/widgets/dot_grid/dots/dot.dart';
import 'package:days/features/home/presentation/pages/widgets/dot_grid/grid_animations/dot_disable_animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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

  bool _userOutsideClicked = false;

  bool get userOutsideClicked => _userOutsideClicked;

  void userOutsideClick() {
    if (_userOutsideClicked) return;
    _userOutsideClicked = true;

    _resetHoverActivatedDotsTimer?.cancel();
    _resetHoverActivatedDotsTimer = null;
    _disableAllDots();

    notifyListeners();
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
    _userOutsideClicked = false;
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


  static DotsManagerNotifier of(BuildContext context, {bool listen = false}) {
    return Provider.of<DotsManagerNotifier>(context, listen: listen);
  }

}
