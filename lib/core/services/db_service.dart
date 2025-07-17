import 'dart:convert';

import 'package:days/shared/package/logger/_logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

final class LocalStorage {
  LocalStorage._();

  static final LocalStorage instance = LocalStorage._();

  static SharedPreferences? _preferences;

  Future<void> init() async {
    assert(
      _preferences == null,
      'LocalStorage is already initialized. Call LocalStorage.instance.clear() to reset.',
    );
    Logger.i('Initializing LocalStorage');
    _preferences = await SharedPreferences.getInstance();
    Logger.i('LocalStorage initialized');
  }

  void set(String key, dynamic value) {
    _assertNotInitialized();
    Logger.d('[DbService] set: $key');
    if (value is String) {
      _preferences?.setString(key, value);
    } else if (value is int) {
      _preferences?.setInt(key, value);
    } else if (value is double) {
      _preferences?.setDouble(key, value);
    } else if (value is bool) {
      _preferences?.setBool(key, value);
    } else if (value is List<String>) {
      _preferences?.setStringList(key, value);
    } else if (value is DateTime) {
      _preferences?.setString(key, value.toIso8601String());
    } else if (value is Map) {
      _preferences?.setString(key, json.encode(value));
    } else {
      throw Exception('Type not supported');
    }
  }

  dynamic get(String key) {
    _assertNotInitialized();
    Logger.d('[DbService] get: $key');
    return _preferences?.get(key);
  }

  void remove(String key) {
    _assertNotInitialized();
    Logger.d('[DbService] remove: $key');
    _preferences?.remove(key);
  }

  void clear() {
    Logger.d('[DbService] clear');
    _preferences?.clear();
  }

  void _assertNotInitialized() {
    assert(
      _preferences != null,
      'LocalStorage is not initialized. Call LocalStorage.instance.init() first.',
    );
  }
}
