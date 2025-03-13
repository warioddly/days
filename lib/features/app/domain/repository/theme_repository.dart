
import 'dart:ui';

abstract class ThemeRepository {
  void setTheme(String theme);
  Future<Brightness> getTheme();
}