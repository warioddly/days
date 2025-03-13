
import 'package:flutter/cupertino.dart' show Locale;

const String _assetPath = 'assets/images/flags/';

final class FlagAssets {

    static const ky = '$_assetPath/ky.png';
    static const ru = '$_assetPath/ru.png';
    static const en = '$_assetPath/en.png';

    static String flagPathFor(Locale locale) {
      return switch (locale.languageCode) {
        'ky' => ky,
        'ru' => ru,
          _  => en,
      };
    }

}
