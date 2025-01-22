import 'package:days/features/home/data/datasource/settings_datasource/settings_datasource.dart';
import 'package:days/features/home/data/mapper/settings_model_mapper.dart';
import 'package:days/features/home/domain/entity/settings_entity.dart';
import 'package:days/features/home/domain/repository/settings_repository.dart';

class SettingsRepositoryImpl implements SettingsRepository {

  final SettingsDataSource localDataSource;
  final SettingsModelMapper settingsModelMapper;

  SettingsRepositoryImpl({
    required this.localDataSource,
    required this.settingsModelMapper,
  });

  @override
  void setSettings(SettingsEntity entity) {
    localDataSource.setSettings(settingsModelMapper.mapFrom(entity));
  }

  @override
  Future<SettingsEntity> getSettings() async {
    return localDataSource
        .getSettings()
        .then(settingsModelMapper.mapTo);
  }

}