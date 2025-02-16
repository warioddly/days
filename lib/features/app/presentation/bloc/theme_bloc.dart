import 'dart:ui' show Brightness;

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:days/features/app/domain/usecase/get_theme_usecase.dart';
import 'package:days/features/app/domain/usecase/set_theme_usecase.dart';
import 'package:meta/meta.dart';

part 'theme_event.dart';
part 'theme_state.dart';

class ThemeBloc extends Bloc<ThemeEvent, Brightness> {

  final GetThemeUseCase getThemeUseCase;
  final SetThemeUseCase setThemeUseCase;

  ThemeBloc({
    required this.getThemeUseCase,
    required this.setThemeUseCase,
  }) : super(Brightness.light) {
    on<SetTheme>(_setTheme);
    on<GetTheme>(_getTheme);
  }

  void _setTheme(
      SetTheme event,
      Emitter<Brightness> emit,
  ) async {
    await setThemeUseCase(event.themeBrightness.name);
    emit(event.themeBrightness);
  }

  void _getTheme(
    GetTheme event,
    Emitter<Brightness> emit,
  ) async {
    final theme = await getThemeUseCase(null);
    emit(theme);
  }

}
