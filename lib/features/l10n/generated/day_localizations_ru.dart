// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'day_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Russian (`ru`).
class DayLocalizationsRu extends DayLocalizations {
  DayLocalizationsRu([String locale = 'ru']) : super(locale);

  @override
  String get app_name => 'Days';

  @override
  String get about_app =>
      'Эй, привет!\n\nЯ создал \'Days\' как ежедневное напоминание о том, что жизнь слишком коротка, чтобы тратить ее на то, что меня не вдохновляет.\nЯ надеюсь, что каждый раз, когда вы смотрите на это приложение, вы напоминаете себе что\n\nкаждый день имеет значение\n\nс любовью,';

  @override
  String get settings => 'Настройки';

  @override
  String get privacy => 'Конфиденциальность';

  @override
  String get about => 'О нас';

  @override
  String get terms => 'terms';

  @override
  String get github => 'Github';

  @override
  String get more_days_of_growth => 'больше дней роста';

  @override
  String get days_left_in_the_year => 'дней осталось в году';
}
