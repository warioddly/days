import 'package:days/core/base/store.dart';
import 'package:days/core/keys/storage_key.dart';
import 'package:days/core/services/local_storage.dart';
import 'package:days/core/utils/logger.dart';
import 'package:days/shared/package/vm/view_model.dart';
import 'package:flutter/material.dart';

class AppViewModel extends ViewModel with Logger {
  AppViewModel([Store? store]) : _storage = store ?? LocalStorage.instance {
    _loadTheme();
  }

  @override
  String get loggerName => 'AppViewModel';

  final Store _storage;

  ThemeMode _themeMode = ThemeMode.system;

  ThemeMode get themeMode => _themeMode;

  Future<void> _loadTheme() async {
    try {
      log('Load theme');
      _themeMode = switch (_storage.get<String>(StorageKey.theme)) {
        'light' => ThemeMode.light,
        'dark' => ThemeMode.dark,
        _ => ThemeMode.system,
      };
      log('Theme loaded: $_themeMode');
    } catch (error, stackTrace) {
      log('Error when load grid type: ', error: error, stackTrace: stackTrace);
    }
  }

  void setThemeMode(ThemeMode themeMode) {
    try {
      if (_themeMode == themeMode) {
        log('Theme is already set to $themeMode');
        return;
      }
      _storage.set(StorageKey.theme, themeMode.name);
      _themeMode = themeMode;
      log('Theme set to $themeMode');
    } catch (error, stackTrace) {
      log('Error setting grid type: ', error: error, stackTrace: stackTrace);
    }

    notifyListeners();
  }
}
