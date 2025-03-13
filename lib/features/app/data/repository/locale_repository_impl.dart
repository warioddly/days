import 'package:days/features/app/data/datasource/locale_datasource/locale_datasource.dart';
import 'package:days/features/app/domain/repository/locale_repository.dart';
import 'package:flutter/cupertino.dart' show Locale;


class LocaleRepositoryImpl implements LocaleRepository {

  final LocaleDataSource localDataSource;

  LocaleRepositoryImpl({
    required this.localDataSource,
  });

  @override
  void setLocale(Locale locale) {
    return localDataSource.setLocale(locale.languageCode);
  }

  @override
  Future<Locale?> getLocale() async {
    final locale = await localDataSource.getLocale();
    return locale != null ? Locale(locale) : null;
  }

}