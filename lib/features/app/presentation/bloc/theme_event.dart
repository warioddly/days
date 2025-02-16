part of 'theme_bloc.dart';

@immutable
sealed class ThemeEvent {}

class SetTheme extends ThemeEvent {
  final ThemeState themeBrightness;

  SetTheme(this.themeBrightness);
}

class GetTheme extends ThemeEvent {}

