// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'day_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Kirghiz Kyrgyz (`ky`).
class DayLocalizationsKy extends DayLocalizations {
  DayLocalizationsKy([String locale = 'ky']) : super(locale);

  @override
  String get app_name => 'Days';

  @override
  String get about_app =>
      'Эй, салам!\n\nмен \'Days\' жашоонун күнүмдүк эскертүүсү катары жараттым\nмага жакпаган нерсеге жаашону коротуу үчүн өтө кыска.\nбул колдонмону карап чыккан сайын, сиз аны эстеп каласыз деп ишенем.\n\nкүн сайын маанилүү\n\nсүйүү менен,';

  @override
  String get settings => 'Орнотуулар';

  @override
  String get privacy => 'Купуялык';

  @override
  String get about => 'Жөнүндө';

  @override
  String get terms => 'terms';

  @override
  String get restore => 'restore';

  @override
  String get github => 'Github';

  @override
  String get more_days_of_growth => 'күн дагы өсүү';

  @override
  String days_left_in_the_year(Object year) {
    return 'күн өттү $year';
  }
}
