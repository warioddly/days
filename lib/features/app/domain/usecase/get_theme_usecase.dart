import 'dart:ui' show Brightness;
import 'package:days/core/interfaces/usecase_interface.dart';
import 'package:days/features/app/domain/repository/theme_repository.dart';

class GetThemeUseCase extends UseCase<void, Brightness> {

  final ThemeRepository repository;

  GetThemeUseCase({required this.repository});

  @override
  Future<Brightness> call(void params) async {
    return repository.getTheme();
  }

}