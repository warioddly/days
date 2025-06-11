// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'day_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class DayLocalizationsEn extends DayLocalizations {
  DayLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get app_name => 'Days';

  @override
  String get about_app =>
      'hey there!\n\ni created \'days\' as a daily reminder that life is\ntoo short to spend doing things I am not excited about this.\ni hope every time you look at this app you\'re reminded\n\n\nevery day matters\n\nlove,';

  @override
  String get settings => 'Settings';

  @override
  String get privacy => 'Privacy';

  @override
  String get about => 'About';

  @override
  String get github => 'Github';

  @override
  String get more_days_of_growth => 'more days of growth';

  @override
  String get days_left_in_the_year => 'days left in the year';
}
