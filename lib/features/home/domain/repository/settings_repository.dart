

import 'package:days/features/home/domain/entity/settings_entity.dart';

abstract class SettingsRepository {

  void setSettings(SettingsEntity entity);

  Future<SettingsEntity> getSettings();

}