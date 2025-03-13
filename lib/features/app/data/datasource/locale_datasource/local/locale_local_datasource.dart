import 'package:days/core/services/db_service.dart';
import 'package:days/features/app/data/datasource/locale_datasource/locale_datasource.dart';

class LocaleLocalDataSourceImpl implements LocaleDataSource {
  final DbService db;

  const LocaleLocalDataSourceImpl({required this.db});

  @override
  void setLocale(String params) => db.set('locale', params);

  @override
  Future<String?> getLocale() async => db.get('locale');
}
