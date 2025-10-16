import 'dart:developer';

import 'package:days/core/base/store.dart';
import 'package:days/core/base/view_model.dart';
import 'package:days/core/keys/storage_key.dart';
import 'package:days/core/services/local_storage.dart';

enum GridType { illustrated, doted }

class HomeViewModel extends ViewModel {

  HomeViewModel([Store? store]) : _storage = store ?? LocalStorage.instance {
    _loadGridType();
  }

  final Store _storage;

  GridType _gridType = GridType.illustrated;

  GridType get gridType => _gridType;

  Future<void> _loadGridType() async {
    try {
      _gridType = switch (_storage.get<String>(StorageKey.gridType)) {
        'doted' => GridType.doted,
        _ => GridType.illustrated,
      };
    } catch (error, stackTrace) {
      log(
        'Error setting grid type: ',
        error: error,
        stackTrace: stackTrace,
        name: 'GridTypeNotifier',
      );
    }
    notifyListeners();
  }

  void setGridType(GridType newGridType) {
    try {
      if (_gridType == newGridType) return;
      _storage.set(StorageKey.gridType, newGridType.name);
      _gridType = newGridType;
    } catch (error, stackTrace) {
      log(
        'Error setting grid type: ',
        error: error,
        stackTrace: stackTrace,
        name: 'GridTypeNotifier',
      );
    }

    notifyListeners();
  }
}
