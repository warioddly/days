import 'package:days/core/constants/dimensions.dart';
import 'package:days/core/extensions/dimensions_extensions.dart';
import 'package:days/features/app/presentation/bloc/theme_bloc.dart';
import 'package:flutter/material.dart';

class AppTheme {

  static ThemeData getTheme(ThemeState themeBrightness) {
    final systemBrightness = WidgetsBinding.instance.window.platformBrightness;
    if (themeBrightness == ThemeState.system) {
      return systemBrightness == Brightness.light ? lightTheme : darkTheme;
    }
    return themeBrightness == ThemeState.light ? lightTheme : darkTheme;
  }

  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      fontFamily: 'ChakraPetch',
      brightness: Brightness.dark,
      colorScheme: const ColorScheme(
        primary: Colors.white,
        onPrimary: Colors.black,
        secondary: Colors.black,
        onSecondary: Colors.white,
        brightness: Brightness.dark,
        error: Colors.red,
        onError: Colors.white,
        surface: Colors.black,
        onSurface: Colors.white,
      ),
      scaffoldBackgroundColor: Colors.black,
      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: Colors.black,
        shape: RoundedRectangleBorder(
          borderRadius: Dimensions.large.topBorder,
        ),
      ),
    );
  }

  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      fontFamily: 'ChakraPetch',
      brightness: Brightness.light,
      colorScheme: const ColorScheme(
        primary: Colors.black,
        onPrimary: Colors.black12,
        secondary: Colors.white,
        onSecondary: Colors.black,
        brightness: Brightness.light,
        error: Colors.red,
        onError: Colors.white,
        surface: Colors.white,
        onSurface: Colors.black,
      ),
      scaffoldBackgroundColor: Colors.white,
      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: Dimensions.large.topBorder,
        ),
      ),
    );
  }
}
