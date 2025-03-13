import 'package:days/core/interfaces/usecase_interface.dart';
import 'package:days/features/app/domain/repository/locale_repository.dart';
import 'package:flutter/cupertino.dart' show Locale;

class SetLocaleUseCase extends UseCase<Locale, void> {
  final LocaleRepository repository;

  SetLocaleUseCase({required this.repository});

  @override
  Future<void> call(Locale params) async {
    repository.setLocale(params);
  }
}
