import 'dart:convert';

import 'package:days/shared/package/logger/_logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

final class LocalStorage {

  static final _instance = LocalStorage._internal();

  LocalStorage._internal();

  static LocalStorage get instance => _instance;

  late final SharedPreferences _preferences;

  static bool _initialized = false;

  static bool get initialized => _initialized;

  Future<void> init() async {

    assert(!_initialized, 'LocalStorage is already initialized');

    _instance._preferences = await SharedPreferences.getInstance();

    _initialized = true;

  }

  Future<bool> set(String key, dynamic value) async {
    _log('Setting key: $key, value: $value');
    if (value is String) {
      return _preferences.setString(key, value);
    } else if (value is int) {
      return _preferences.setInt(key, value);
    } else if (value is double) {
      return _preferences.setDouble(key, value);
    } else if (value is bool) {
      return _preferences.setBool(key, value);
    } else if (value is List<String>) {
      return _preferences.setStringList(key, value);
    } else if (value is DateTime) {
      return _preferences.setString(key, value.toIso8601String());
    } else if (value is Map) {
      return _preferences.setString(key, json.encode(value));
    } else {
      return false;
    }
  }

  T? get<T>(String key) {
    _log('Getting key: $key, type: $T');

    if (!_initialized) {
      throw Exception('DbService is not initialized');
    }

    final value = _preferences.get(key);
    if (value == null) {
      _log('Key not found: $key');
      return null;
    }

    if (T == String) {
      return _preferences.getString(key) as T?;
    } else if (T == int) {
      return _preferences.getInt(key) as T?;
    } else if (T == bool) {
      return _preferences.getBool(key) as T?;
    } else if (T == double) {
      return _preferences.getDouble(key) as T?;
    } else if (T == List<String>) {
      return _preferences.getStringList(key) as T?;
    } else {
      return _preferences.get(key) as T?;
    }
  }

  Future<bool> remove(String key) {
    _log('Removing key: $key');
    return _preferences.remove(key);
  }

  Future<bool>  clear() {
    _log('Clearing all preferences');
    return _preferences.clear();
  }

  void _log(String message) {
    Logger.log(message, level: Level.debug, name: 'LocalStorage');
  }

}
