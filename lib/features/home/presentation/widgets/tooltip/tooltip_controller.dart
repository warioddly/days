import 'dart:ui' show Offset;
import 'package:flutter/foundation.dart' show ChangeNotifier;

final class TooltipController extends ChangeNotifier {

  Offset _position = Offset.zero;
  DateTime _content = DateTime.now();

  bool _isVisible = false;

  bool get isVisible => _isVisible;

  Offset get position => _position;

  DateTime get content => _content;

  void show() {
    if (_isVisible) return;
    _isVisible = true;
    notifyListeners();
  }

  void hide() {
    _isVisible = false;
    notifyListeners();
  }

  void setPosition(Offset position) {
    _position = position;
    notifyListeners();
  }

  void setContent(DateTime date) {
    _content = date;
    notifyListeners();
  }
}