import 'package:days/features/l10n/generated/day_localizations.dart';
import 'package:flutter/foundation.dart' show PlatformDispatcher;

DayLocalizations l10n = lookupDayLocalizations(PlatformDispatcher.instance.locale);

const Map<String, String> languageNames = {
  'en': 'English',
  'ru': 'Русский',
  'ky': 'Кыргызча',
};