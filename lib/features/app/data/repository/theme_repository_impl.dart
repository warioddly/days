import 'package:days/features/app/data/datasource/settings_datasource/theme_datasource.dart';
import 'package:days/features/app/domain/repository/theme_repository.dart';

class ThemeRepositoryImpl implements ThemeRepository {

  final ThemeDataSource localDataSource;

  ThemeRepositoryImpl({
    required this.localDataSource,
  });

  @override
  void setTheme(String theme) => localDataSource.setTheme(theme);

  @override
  Future<String?> getTheme() async => localDataSource.getTheme();

}