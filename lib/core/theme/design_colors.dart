import 'package:flutter/cupertino.dart' show Brightness, BuildContext;
import 'package:flutter/material.dart' show Color, Theme;

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

  Color get error;

  Color get onError;

  Color get surface;

  Color get onSurface;

  Color get background;

  Color get onBackground;

  Color get scaffoldBackground;

  Color get bottomSheetBackground;

  Color get bottomSheetOnBackground;

  Color get bottomSheetSurface;

  Color get bottomSheetOnSurface;


}

final class DarkDesignColors extends DesignColors {

  @override
  // TODO: implement background
  Color get background => throw UnimplementedError();

  @override
  // TODO: implement bottomSheetBackground
  Color get bottomSheetBackground => throw UnimplementedError();

  @override
  // TODO: implement bottomSheetOnBackground
  Color get bottomSheetOnBackground => throw UnimplementedError();

  @override
  // TODO: implement bottomSheetOnSurface
  Color get bottomSheetOnSurface => throw UnimplementedError();

  @override
  // TODO: implement bottomSheetSurface
  Color get bottomSheetSurface => throw UnimplementedError();

  @override
  // TODO: implement error
  Color get error => throw UnimplementedError();

  @override
  // TODO: implement onBackground
  Color get onBackground => throw UnimplementedError();

  @override
  // TODO: implement onError
  Color get onError => throw UnimplementedError();

  @override
  // TODO: implement onPrimary
  Color get onPrimary => throw UnimplementedError();

  @override
  // TODO: implement onSecondary
  Color get onSecondary => throw UnimplementedError();

  @override
  // TODO: implement onSurface
  Color get onSurface => throw UnimplementedError();

  @override
  Color get primary => const Color(0xFF121212);

  @override
  // TODO: implement scaffoldBackground
  Color get scaffoldBackground => throw UnimplementedError();

  @override
  // TODO: implement secondary
  Color get secondary => throw UnimplementedError();

  @override
  // TODO: implement surface
  Color get surface => throw UnimplementedError();



}

final class LightDesignColors extends DesignColors {

  @override
  // TODO: implement background
  Color get background => throw UnimplementedError();

  @override
  // TODO: implement bottomSheetBackground
  Color get bottomSheetBackground => throw UnimplementedError();

  @override
  // TODO: implement bottomSheetOnBackground
  Color get bottomSheetOnBackground => throw UnimplementedError();

  @override
  // TODO: implement bottomSheetOnSurface
  Color get bottomSheetOnSurface => throw UnimplementedError();

  @override
  // TODO: implement bottomSheetSurface
  Color get bottomSheetSurface => throw UnimplementedError();

  @override
  // TODO: implement error
  Color get error => throw UnimplementedError();

  @override
  // TODO: implement onBackground
  Color get onBackground => throw UnimplementedError();

  @override
  // TODO: implement onError
  Color get onError => throw UnimplementedError();

  @override
  // TODO: implement onPrimary
  Color get onPrimary => throw UnimplementedError();

  @override
  // TODO: implement onSecondary
  Color get onSecondary => throw UnimplementedError();

  @override
  // TODO: implement onSurface
  Color get onSurface => throw UnimplementedError();

  @override
  // TODO: implement primary
  Color get primary => const Color(0xFFFFFFFF);

  @override
  // TODO: implement scaffoldBackground
  Color get scaffoldBackground => throw UnimplementedError();

  @override
  // TODO: implement secondary
  Color get secondary => throw UnimplementedError();

  @override
  // TODO: implement surface
  Color get surface => throw UnimplementedError();


}

