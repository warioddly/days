import 'dart:ui';

import 'package:days/features/l10n/generated/day_localizations.dart';
// import 'package:flutter/foundation.dart' show PlatformDispatcher;

const defaultLocale = Locale('en', 'US');

DayLocalizations l10n = lookupDayLocalizations(defaultLocale);

const Map<String, String> languageNames = {
  'en': 'English',
  'ru': 'Русский',
  'ky': 'Кыргызча',
};