
import 'package:days/core/interfaces/usecase_interface.dart';
import 'package:days/features/app/domain/repository/theme_repository.dart';
import 'package:days/features/app/presentation/bloc/theme_bloc.dart';

class GetThemeUseCase extends UseCase<void, ThemeState> {

  final ThemeRepository repository;

  GetThemeUseCase({required this.repository});

  @override
  Future<ThemeState> call(void params) async {
    return switch(await repository.getTheme()) {
      'light' => ThemeState.light,
      'dark' => ThemeState.dark,
      _ => ThemeState.system,
    };
  }

}