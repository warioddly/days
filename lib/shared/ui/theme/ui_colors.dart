import 'package:flutter/cupertino.dart' show Brightness, BuildContext;
import 'package:flutter/material.dart' show Color, Colors, Theme;

abstract final class UIColors {

  const UIColors();

  factory UIColors.of(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    return switch (brightness) {
      Brightness.dark => UIDarkColors(),
      Brightness.light => UILightColors(),
    };
  }

  Color get primary;

  Color get onPrimary;

  Color get secondary;

  Color get onSecondary;

  Color get background;

  Color get onBackground;

}

final class UIDarkColors extends UIColors {

  @override
  Color get background => Colors.black;

  @override
  Color get onBackground => onPrimary;

  @override
  Color get onPrimary => Colors.white;

  @override
  Color get onSecondary => Colors.white;

  @override
  Color get primary => Colors.black;

  @override
  Color get secondary => Colors.white.withAlpha(155);

}

final class UILightColors extends UIColors {
  @override
  Color get background => Colors.white;

  @override
  Color get onBackground => onPrimary;

  @override
  Color get onPrimary => const Color(0xFF0047AB);

  @override
  Color get onSecondary => Colors.white;

  @override
  Color get primary => Colors.white;

  @override
  Color get secondary => const Color(0xFF4B6AB1);

}

