

import 'package:days/features/home/domain/entity/grid_type.dart';

abstract class SettingsRepository {

  void setGridType(GridType gridType);

  Future<GridType> getGridType();

}