import 'package:days/core/constants/dimensions.dart';
import 'package:days/core/extensions/dimensions_extensions.dart';
import 'package:days/core/theme/design_colors.dart';
import 'package:days/features/app/presentation/bloc/theme_bloc.dart';
import 'package:flutter/material.dart';

class AppTheme {

  static ThemeData getTheme(BuildContext context, ThemeState themeBrightness) {
    final systemBrightness = WidgetsBinding.instance.window.platformBrightness;

    ThemeData getTheme(bool light) => light
        ? lightTheme(context)
        : darkTheme(context);

    return themeBrightness == ThemeState.system
        ? getTheme(systemBrightness == Brightness.light)
        : getTheme(themeBrightness == ThemeState.light);
  }

  static ThemeData darkTheme(BuildContext context) {
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
      scaffoldBackgroundColor: Colors.black,
      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: Colors.black,
        shape: RoundedRectangleBorder(
          borderRadius: Dimensions.large.topBorder,
        ),
      ),
    );
  }

  static ThemeData lightTheme(BuildContext context) {
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
      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: Dimensions.large.topBorder,
        ),
      ),
    );
  }
}
