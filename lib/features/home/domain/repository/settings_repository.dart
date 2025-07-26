

import 'package:days/features/home/domain/entity/settings_entity.dart';

abstract class SettingsRepository {

  void setGridType(GridType gridType);

  Future<GridType> getGridType();

}