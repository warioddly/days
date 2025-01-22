
import 'package:days/features/home/data/model/settings_model.dart';

abstract class SettingsDataSource {

  void setSettings(SettingsModel entity);

  Future<SettingsModel> getSettings();

}