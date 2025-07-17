
import 'package:days/core/interfaces/usecase_interface.dart';
import 'package:days/features/app/domain/repository/theme_repository.dart';

class SetThemeUseCase extends UseCase<String, void> {

  final ThemeRepository repository;

  SetThemeUseCase({required this.repository});

  @override
  Future<void> call(String params) async => repository.setTheme(params);

}