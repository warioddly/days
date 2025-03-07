part of 'theme_bloc.dart';

sealed class ThemeEvent {}

class SetTheme extends ThemeEvent {
  final Brightness themeBrightness;

  SetTheme(this.themeBrightness);
}

class GetTheme extends ThemeEvent {}

