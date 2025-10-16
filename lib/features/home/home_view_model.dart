import 'package:days/core/base/store.dart';
import 'package:days/core/base/view_model.dart';
import 'package:days/core/keys/storage_key.dart';
import 'package:days/core/services/local_storage.dart';
import 'package:days/core/utils/mixins/logger_mixin.dart';

enum GridType { illustrated, doted }

class HomeViewModel extends ViewModel with LoggerMixin {
  HomeViewModel([Store? store]) : _storage = store ?? LocalStorage.instance {
    _loadGridType();
  }

  @override
  String get loggerName => 'HomeViewModel';

  final Store _storage;

  GridType _gridType = GridType.illustrated;

  GridType get gridType => _gridType;

  Future<void> _loadGridType() async {
    try {
      log('Load grid type');
      _gridType = switch (_storage.get<String>(StorageKey.gridType)) {
        'doted' => GridType.doted,
        _ => GridType.illustrated,
      };
    } catch (error, stackTrace) {
      log('Error setting grid type: ', error: error, stackTrace: stackTrace);
    }
  }

  void setGridType(GridType newGridType) {
    try {
      if (_gridType == newGridType) return;
      _storage.set(StorageKey.gridType, newGridType.name);
      _gridType = newGridType;
    } catch (error, stackTrace) {
      log('Error setting grid type: ', error: error, stackTrace: stackTrace);
    }

    notifyListeners();
  }
}
