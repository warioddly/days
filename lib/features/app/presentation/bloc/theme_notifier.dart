import 'dart:developer';

import 'package:days/features/app/domain/repository/theme_repository.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart' show BuildContext, ThemeMode;
import 'package:provider/provider.dart';

class ThemeNotifier extends ChangeNotifier {
  final ThemeRepository _repository;

  ThemeNotifier(this._repository);

  ThemeMode _themeMode = ThemeMode.system;

  void setTheme(ThemeMode themeMode) {
    try {
      if (_themeMode == themeMode) return;
      _themeMode = themeMode;
      _repository.setTheme(themeMode.name);
      notifyListeners();
    } catch (error, stackTrace) {
      log(
        'Error setting theme: ',
        error: error,
        stackTrace: stackTrace,
        name: 'ThemeNotifier',
      );
    }

  }

  void loadTheme() {
    _themeMode = _repository.getTheme();
    notifyListeners();
  }

  static ThemeNotifier of(BuildContext context) {
    return Provider.of<ThemeNotifier>(context);
  }

  static ThemeMode value(BuildContext context) {
    return of(context)._themeMode;
  }
}
