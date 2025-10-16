import 'dart:developer';

import 'package:days/core/base/store.dart';
import 'package:days/core/base/view_model.dart';
import 'package:days/core/keys/storage_key.dart';
import 'package:days/core/services/local_storage.dart';
import 'package:flutter/material.dart';

class AppViewModel extends ViewModel {
  AppViewModel([Store? store]) : _storage = store ?? LocalStorage.instance {
    _loadTheme();
  }

  final Store _storage;

  ThemeMode _themeMode = ThemeMode.system;

  ThemeMode get themeMode => _themeMode;

  Future<void> _loadTheme() async {
    try {
      _themeMode = switch (_storage.get<String>(StorageKey.theme)) {
        'light' => ThemeMode.light,
        'dark' => ThemeMode.dark,
        _ => ThemeMode.system,
      };
    } catch (error, stackTrace) {
      log('Error setting grid type: ', error: error, stackTrace: stackTrace, name: 'AppViewModel');
    }
    notifyListeners();
  }

  void setThemeMode(ThemeMode themeMode) {
    try {
      if (_themeMode == themeMode) return;
      _storage.set(StorageKey.theme, themeMode.name);
      _themeMode = themeMode;
    } catch (error, stackTrace) {
      log('Error setting grid type: ', error: error, stackTrace: stackTrace, name: 'AppViewModel');
    }

    notifyListeners();
  }
}
