import 'package:days/features/home/domain/entity/settings_entity.dart';
import 'package:days/features/home/domain/repository/settings_repository.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart' show BuildContext;
import 'package:provider/provider.dart';

class GridTypeNotifier extends ChangeNotifier {
  final SettingsRepository _repository;

  GridTypeNotifier(this._repository);

  GridType _gridType = GridType.illustrated;

  GridType get gridType => _gridType;

  Future<void> getGridType() async {
    try {
      _gridType = await _repository.getGridType();
    } catch (error, stackTrace) {
      debugPrint('SettingsNotifier error: $error\n$stackTrace');
    }
    notifyListeners();
  }

  set setGridType(GridType newGridType) {
    try {

      if (_gridType == newGridType) return;

      _repository.setGridType(newGridType);

      _gridType = newGridType;

    } catch (error, stackTrace) {
      debugPrint('SettingsNotifier error: $error\n$stackTrace');
    }

    notifyListeners();
  }


  static GridTypeNotifier of(BuildContext context) {
    return Provider.of<GridTypeNotifier>(context, listen: false);
  }

  static GridType value(BuildContext context) {
    return Provider.of<GridTypeNotifier>(context, listen: false).gridType;
  }
}
