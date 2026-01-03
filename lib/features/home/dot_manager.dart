import 'package:days/shared/package/vm/view_model.dart';
import 'package:flutter/material.dart';

class DotManager extends ViewModel {
  static DotManager of(BuildContext context) => ViewModel.of<DotManager>(context);

  int _counter = 0;

  int get counter => _counter;

  void reset() {
    _counter = 0;
    notifyListeners();
  }

  void increment() {
    _counter++;
    notifyListeners();
  }

  void decrement() {
    if (_counter > 0) {
      _counter--;
      notifyListeners();
    }
  }
}
