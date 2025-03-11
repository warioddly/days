import 'package:days/core/constants/dimensions.dart';
import 'package:days/core/extensions/dimensions_extensions.dart';
import 'package:days/core/theme/_text_theme.dart';
import 'package:days/core/theme/_colors.dart';
import 'package:flutter/material.dart';

class AppTheme {

  static ThemeData getTheme(BuildContext context, Brightness brightness) {
    return brightness == Brightness.light ? lightTheme() : darkTheme();
  }

  static const textTheme = DayTextTheme();

  static ThemeData darkTheme() {
    final colors = DarkDayColors();
    return ThemeData(
      useMaterial3: true,
      fontFamily: 'ChakraPetch',
      brightness: Brightness.dark,
      colorScheme: ColorScheme(
        primary: colors.primary,
        onPrimary: colors.onPrimary,
        secondary: colors.secondary,
        onSecondary: colors.onSecondary,
        brightness: Brightness.dark,
        error: Colors.red,
        onError: Colors.white,
        surface: Colors.black,
        onSurface: Colors.white,
      ),
      textTheme: TextTheme(
        bodySmall: textTheme.bodySmall.copyWith(color: colors.onPrimary),
        bodyLarge: textTheme.bodyLarge.copyWith(color: colors.onPrimary),
        bodyMedium: textTheme.bodyMedium.copyWith(color: colors.onPrimary),
        labelLarge: textTheme.labelLarge.copyWith(color: colors.onPrimary),
      ),
      scaffoldBackgroundColor: Colors.black,
      iconTheme: const IconThemeData(color: Colors.white),
      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: Colors.black,
        shape: RoundedRectangleBorder(borderRadius: Dimensions.large.topBorder),
      ),
    );
  }

  static ThemeData lightTheme() {
    final colors = LightDayColors();
    return ThemeData(
      useMaterial3: true,
      fontFamily: 'ChakraPetch',
      brightness: Brightness.light,
      colorScheme: ColorScheme(
        primary: colors.primary,
        onPrimary: colors.onPrimary,
        secondary: colors.secondary,
        onSecondary: colors.onSecondary,
        brightness: Brightness.light,
        error: Colors.red,
        onError: Colors.white,
        surface: Colors.white,
        onSurface: Colors.black,
      ),
      scaffoldBackgroundColor: Colors.white,
      iconTheme: IconThemeData(color: colors.onPrimary),
      textTheme: TextTheme(
        bodySmall: textTheme.bodySmall.copyWith(color: colors.onPrimary),
        bodyLarge: textTheme.bodyLarge.copyWith(color: colors.onPrimary),
        bodyMedium: textTheme.bodyMedium.copyWith(color: colors.onPrimary),
        labelLarge: textTheme.labelLarge.copyWith(color: colors.onPrimary),
      ),
      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: Dimensions.large.topBorder),
      ),
    );
  }

}
