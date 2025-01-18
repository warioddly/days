


import 'package:flutter/material.dart';

class AppTheme {

  static ThemeData get theme {
    return ThemeData(
      
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
      useMaterial3: true,
      scaffoldBackgroundColor: Colors.black,
    );
  }

}