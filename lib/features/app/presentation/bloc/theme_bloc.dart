import 'dart:ui' show Brightness;

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:days/features/app/domain/usecase/get_theme_usecase.dart';
import 'package:days/features/app/domain/usecase/set_theme_usecase.dart';
import 'package:meta/meta.dart';

part 'theme_event.dart';

class ThemeBloc extends Bloc<ThemeEvent, Brightness> {

  final GetThemeUseCase getThemeUseCase;
  final SetThemeUseCase setThemeUseCase;

  ThemeBloc({
    required this.getThemeUseCase,
    required this.setThemeUseCase,
  }) : super(Brightness.dark) {
    on<SetTheme>(_setTheme);
    on<GetTheme>(_getTheme);
  }

  void _setTheme(
      SetTheme event,
      Emitter<Brightness> emit,
  ) async {
    emit(event.themeBrightness);
    await setThemeUseCase(event.themeBrightness.name);
  }

  void _getTheme(
    GetTheme event,
    Emitter<Brightness> emit,
  ) async {
    emit(await getThemeUseCase(null));
  }

}
