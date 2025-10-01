import 'package:flutter/material.dart';

abstract class ThemeRepository {
  void setTheme(String themeMode);
  ThemeMode getTheme();
}