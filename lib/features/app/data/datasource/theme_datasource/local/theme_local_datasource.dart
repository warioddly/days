import 'package:days/core/keys/storage_key.dart';
import 'package:days/core/services/db_service.dart';
import 'package:days/features/app/data/datasource/theme_datasource/theme_datasource.dart';

class ThemeLocalDataSourceImpl implements ThemeDataSource {

  final LocalStorage db;

  const ThemeLocalDataSourceImpl({required this.db});

  @override
  void setTheme(String params) => db.set(StorageKey.theme, params);

  @override
  String? getTheme() => db.get(StorageKey.theme);
}
