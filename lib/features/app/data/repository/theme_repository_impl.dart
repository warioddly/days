import 'package:days/features/app/data/datasource/theme_datasource/theme_datasource.dart';
import 'package:days/features/app/domain/repository/theme_repository.dart';
import 'package:flutter/material.dart';

class ThemeRepositoryImpl implements ThemeRepository {
  final ThemeDataSource localDataSource;

  ThemeRepositoryImpl({required this.localDataSource});

  @override
  void setTheme(String themeMode) => localDataSource.setTheme(themeMode);

  @override
  ThemeMode getTheme() {
    return switch (localDataSource.getTheme()) {
      'light' => ThemeMode.light,
      'dark' => ThemeMode.dark,
      _ => ThemeMode.system,
    };
  }
}
