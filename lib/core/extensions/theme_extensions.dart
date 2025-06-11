import 'package:days/core/theme/_colors.dart';
import 'package:flutter/material.dart';

extension ThemeExtensions on BuildContext {

  DayColors get colors => DayColors.of(this);

  ColorScheme get colorScheme => Theme.of(this).colorScheme;

  TextTheme get primaryTextTheme => Theme.of(this).primaryTextTheme;

  TextTheme get textTheme => Theme.of(this).textTheme;

}
