import 'package:days/shared/ui/theme/ui_colors.dart';
import 'package:flutter/material.dart';

extension ThemeExtensions on BuildContext {

  UIColors get colors => UIColors.of(this);

  ColorScheme get colorScheme => Theme.of(this).colorScheme;

  TextTheme get primaryTextTheme => Theme.of(this).primaryTextTheme;

  TextTheme get textTheme => Theme.of(this).textTheme;

}
