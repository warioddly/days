import 'package:flutter/material.dart';

class UITextTheme extends TextTheme {

  const UITextTheme();

  @override
  TextStyle get displayLarge => const TextStyle(
    fontSize: 96.0,
    fontWeight: FontWeight.w300,
    textBaseline: TextBaseline.alphabetic,
    letterSpacing: -1.5,
  );

  @override
  TextStyle get displayMedium => const TextStyle(
    fontSize: 60.0,
    fontWeight: FontWeight.w300,
    textBaseline: TextBaseline.alphabetic,
    letterSpacing: -0.5,
  );

  @override
  TextStyle get displaySmall => const TextStyle(
    fontSize: 48.0,
    fontWeight: FontWeight.w400,
    textBaseline: TextBaseline.alphabetic,
    letterSpacing: 0.0,
  );

  @override
  TextStyle get headlineLarge => const TextStyle(
    fontSize: 40.0,
    fontWeight: FontWeight.w400,
    textBaseline: TextBaseline.alphabetic,
    letterSpacing: 0.25,
  );

  @override
  TextStyle get headlineMedium => const TextStyle(
    fontSize: 34.0,
    fontWeight: FontWeight.w400,
    textBaseline: TextBaseline.alphabetic,
    letterSpacing: 0.25,
  );

  @override
  TextStyle get headlineSmall => const TextStyle(
    fontSize: 24.0,
    fontWeight: FontWeight.w400,
    textBaseline: TextBaseline.alphabetic,
    letterSpacing: 0.0,
  );

  @override
  TextStyle get titleLarge => const TextStyle(
    fontSize: 20.0,
    fontWeight: FontWeight.w500,
    textBaseline: TextBaseline.alphabetic,
    letterSpacing: 0.15,
  );

  @override
  TextStyle get titleMedium => const TextStyle(
    fontSize: 16.0,
    fontWeight: FontWeight.w400,
    textBaseline: TextBaseline.alphabetic,
    letterSpacing: 0.15,
  );

  @override
  TextStyle get titleSmall => const TextStyle(
    fontSize: 14.0,
    fontWeight: FontWeight.w500,
    textBaseline: TextBaseline.alphabetic,
    letterSpacing: 0.1,
  );

  @override
  TextStyle get bodyLarge => const TextStyle(
    fontSize: 16.0,
    fontWeight: FontWeight.w400,
    textBaseline: TextBaseline.alphabetic,
    letterSpacing: 0.5,
  );

  @override
  TextStyle get bodyMedium => const TextStyle(
    fontSize: 14.0,
    fontWeight: FontWeight.w400,
    textBaseline: TextBaseline.alphabetic,
    letterSpacing: 0.25,
  );

  @override
  TextStyle get bodySmall => const TextStyle(
    fontSize: 12.0,
    fontWeight: FontWeight.w400,
    textBaseline: TextBaseline.alphabetic,
    letterSpacing: 0.0,
  );

  @override
  TextStyle get labelLarge => const TextStyle(
    fontSize: 16.0,
    fontWeight: FontWeight.w500,
    textBaseline: TextBaseline.alphabetic,
    letterSpacing: 0.15,
  );

}
