import 'package:days/features/home/data/datasource/settings_datasource/settings_datasource.dart';
import 'package:days/features/home/data/mapper/grid_type_mapper.dart';
import 'package:days/features/home/domain/entity/grid_type.dart';
import 'package:days/features/home/domain/repository/settings_repository.dart';

class SettingsRepositoryImpl implements SettingsRepository {

  final SettingsDataSource localDataSource;
  final GridTypeMapper gridTypeMapper;

  const SettingsRepositoryImpl({
    required this.localDataSource,
    required this.gridTypeMapper,
  });

  @override
  void setGridType(GridType gridType) {
    localDataSource.setGridType(gridTypeMapper.mapFrom(gridType));
  }

  @override
  GridType getGridType() {
    return gridTypeMapper.mapTo(localDataSource.getGridType());
  }

}