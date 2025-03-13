import 'package:days/core/interfaces/usecase_interface.dart';
import 'package:days/features/app/domain/repository/locale_repository.dart';
import 'package:flutter/material.dart' show Locale;

class GetLocaleUseCase extends UseCase<void, Locale?> {
  final LocaleRepository repository;

  GetLocaleUseCase({required this.repository});

  @override
  Future<Locale?> call(void params) {
    return repository.getLocale();
  }
}
