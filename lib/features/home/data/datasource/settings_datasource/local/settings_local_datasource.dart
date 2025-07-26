import 'package:days/core/services/db_service.dart';
import 'package:days/features/home/data/datasource/settings_datasource/settings_datasource.dart';

class SettingsLocalDataSourceImpl implements SettingsDataSource {

  final LocalStorage db;

  const SettingsLocalDataSourceImpl({required this.db});

  @override
  void setGridType(String gridType) {
    db.set('gridType', gridType);
  }

  @override
  Future<String?> getGridType() async {
    return db.get('gridType');
  }

}