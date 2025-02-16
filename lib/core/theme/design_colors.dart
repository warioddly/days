import 'package:flutter/cupertino.dart' show Brightness, BuildContext;
import 'package:flutter/material.dart' show Color, Colors, Theme;

abstract class DesignColors {

  const DesignColors();

  factory DesignColors.of(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    return switch (brightness) {
      Brightness.dark => DarkDesignColors(),
      Brightness.light => LightDesignColors(),
    };
  }

  Color get primary;

  Color get onPrimary;

  Color get secondary;

  Color get onSecondary;

  Color get background;

  Color get onBackground;

}

final class DarkDesignColors extends DesignColors {

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
  Color get secondary => Colors.white;

}

final class LightDesignColors extends DesignColors {
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
  Color get secondary => const Color(0xFF0047AB);

}

