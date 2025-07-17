import 'dart:convert';

import 'package:days/core/services/db_service.dart';
import 'package:days/features/home/data/datasource/settings_datasource/settings_datasource.dart';
import 'package:days/features/home/data/model/settings_model.dart';

class SettingsLocalDataSourceImpl implements SettingsDataSource {

  final LocalStorage db;

  const SettingsLocalDataSourceImpl({required this.db});

  @override
  void setSettings(SettingsModel entity) {
    db.set('settings', entity.toJson());
  }

  @override
  Future<SettingsModel> getSettings() async {
    final settings = db.get('settings');

    if (settings == null) {
      return SettingsModel.initial();
    }

    return SettingsModel.fromJson(jsonDecode(settings));
  }

}