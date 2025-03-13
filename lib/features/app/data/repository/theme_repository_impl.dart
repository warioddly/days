import 'package:days/features/app/data/datasource/theme_datasource/theme_datasource.dart';
import 'package:days/features/app/domain/repository/theme_repository.dart';
import 'package:flutter/cupertino.dart' show Brightness;

class ThemeRepositoryImpl implements ThemeRepository {
  final ThemeDataSource localDataSource;

  ThemeRepositoryImpl({required this.localDataSource});

  @override
  void setTheme(String theme) => localDataSource.setTheme(theme);

  @override
  Future<Brightness> getTheme() async {
    return switch (await localDataSource.getTheme()) {
      'light' => Brightness.light,
      'dark' => Brightness.dark,
      _ => Brightness.light,
    };
  }
}
