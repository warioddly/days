import 'package:days/core/constants/dimensions.dart';
import 'package:days/core/extensions/dimensions_extensions.dart';
import 'package:days/core/theme/design_colors.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData getTheme(BuildContext context, Brightness themeBrightness) {
    return themeBrightness == Brightness.light ? lightTheme() : darkTheme();
  }

  static ThemeData darkTheme() {
    final colors = DarkDesignColors();
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
        bodySmall: textTheme.bodySmall?.copyWith(color: colors.onPrimary),
        bodyLarge: textTheme.bodyLarge?.copyWith(color: colors.onPrimary),
        bodyMedium: textTheme.bodyMedium?.copyWith(color: colors.onPrimary),
        labelLarge: textTheme.labelLarge?.copyWith(color: colors.onPrimary),
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
    final colors = LightDesignColors();
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
        bodySmall: textTheme.bodySmall?.copyWith(color: colors.onPrimary),
        bodyLarge: textTheme.bodyLarge?.copyWith(color: colors.onPrimary),
        bodyMedium: textTheme.bodyMedium?.copyWith(color: colors.onPrimary),
        labelLarge: textTheme.labelLarge?.copyWith(color: colors.onPrimary),
      ),
      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: Dimensions.large.topBorder),
      ),
    );
  }

  static TextTheme get textTheme {
    return const TextTheme(
      displayLarge: TextStyle(
        fontSize: 96.0,
        fontWeight: FontWeight.w300,
        textBaseline: TextBaseline.alphabetic,
        letterSpacing: -1.5,
      ),
      displayMedium: TextStyle(
        fontSize: 60.0,
        fontWeight: FontWeight.w300,
        textBaseline: TextBaseline.alphabetic,
        letterSpacing: -0.5,
      ),
      displaySmall: TextStyle(
        fontSize: 48.0,
        fontWeight: FontWeight.w400,
        textBaseline: TextBaseline.alphabetic,
        letterSpacing: 0.0,
      ),
      headlineLarge: TextStyle(
        fontSize: 40.0,
        fontWeight: FontWeight.w400,
        textBaseline: TextBaseline.alphabetic,
        letterSpacing: 0.25,
      ),
      headlineMedium: TextStyle(
        fontSize: 34.0,
        fontWeight: FontWeight.w400,
        textBaseline: TextBaseline.alphabetic,
        letterSpacing: 0.25,
      ),
      headlineSmall: TextStyle(
        fontSize: 24.0,
        fontWeight: FontWeight.w400,
        textBaseline: TextBaseline.alphabetic,
        letterSpacing: 0.0,
      ),
      titleLarge: TextStyle(
        fontSize: 20.0,
        fontWeight: FontWeight.w500,
        textBaseline: TextBaseline.alphabetic,
        letterSpacing: 0.15,
      ),
      titleMedium: TextStyle(
        fontSize: 16.0,
        fontWeight: FontWeight.w400,
        textBaseline: TextBaseline.alphabetic,
        letterSpacing: 0.15,
      ),
      titleSmall: TextStyle(
        fontSize: 14.0,
        fontWeight: FontWeight.w500,
        textBaseline: TextBaseline.alphabetic,
        letterSpacing: 0.1,
      ),
      bodyLarge: TextStyle(
        fontSize: 16.0,
        fontWeight: FontWeight.w400,
        textBaseline: TextBaseline.alphabetic,
        letterSpacing: 0.5,
      ),
      bodyMedium: TextStyle(
        fontSize: 14.0,
        fontWeight: FontWeight.w400,
        textBaseline: TextBaseline.alphabetic,
        letterSpacing: 0.25,
      ),
      bodySmall: TextStyle(
        fontSize: 12.0,
        fontWeight: FontWeight.w400,
        textBaseline: TextBaseline.alphabetic,
        letterSpacing: 0.4,
      ),
      labelLarge: TextStyle(
        fontSize: 14.0,
        fontWeight: FontWeight.w500,
        textBaseline: TextBaseline.alphabetic,
        letterSpacing: 1.25,
      ),
      labelMedium: TextStyle(
        fontSize: 11.0,
        fontWeight: FontWeight.w400,
        textBaseline: TextBaseline.alphabetic,
        letterSpacing: 1.5,
      ),
      labelSmall: TextStyle(
        fontSize: 10.0,
        fontWeight: FontWeight.w400,
        textBaseline: TextBaseline.alphabetic,
        letterSpacing: 1.5,
      ),
    );
  }
}
