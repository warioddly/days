import 'package:days/features/app/domain/repository/theme_repository.dart';
import 'package:days/shared/package/logger/_logger.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart' show BuildContext;
import 'package:provider/provider.dart';

class ThemeNotifier extends ChangeNotifier {
  final ThemeRepository _repository;

  ThemeNotifier(this._repository);

  Brightness _brightness = Brightness.dark;

  Brightness get brightness => _brightness;

  set setTheme(Brightness newBrightness) {
    try {
      if (_brightness == newBrightness) return;
      _brightness = newBrightness;
      _repository.setTheme(newBrightness.name);
    } catch (error, stackTrace) {
      Logger.log(
        'Error setting theme: ',
        error: error,
        stackTrace: stackTrace,
        name: 'ThemeNotifier',
      );
    }

    notifyListeners();
  }

  Future<void> getTheme() async {
    _brightness = await _repository.getTheme();
    notifyListeners();
  }

  static ThemeNotifier of(BuildContext context) {
    return Provider.of<ThemeNotifier>(context, listen: false);
  }

  static Brightness value(BuildContext context) {
    return Provider.of<ThemeNotifier>(context, listen: false).brightness;
  }
}
