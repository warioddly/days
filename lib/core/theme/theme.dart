


import 'package:days/core/constants/dimensions.dart';
import 'package:days/core/extensions/dimensions_extensions.dart';
import 'package:flutter/material.dart';

class AppTheme {

  static ThemeData get theme {
    return ThemeData(
      useMaterial3: true,
      fontFamily: 'ChakraPetch',
      colorScheme: ColorScheme(
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

}