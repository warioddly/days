import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'day_localizations_en.dart';
import 'day_localizations_ky.dart';
import 'day_localizations_ru.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of DayLocalizations
/// returned by `DayLocalizations.of(context)`.
///
/// Applications need to include `DayLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'generated/day_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: DayLocalizations.localizationsDelegates,
///   supportedLocales: DayLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the DayLocalizations.supportedLocales
/// property.
abstract class DayLocalizations {
  DayLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static DayLocalizations? of(BuildContext context) {
    return Localizations.of<DayLocalizations>(context, DayLocalizations);
  }

  static const LocalizationsDelegate<DayLocalizations> delegate =
      _DayLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('ky'),
    Locale('ru'),
  ];

  /// No description provided for @app_name.
  ///
  /// In en, this message translates to:
  /// **'Days'**
  String get app_name;

  /// No description provided for @about_app.
  ///
  /// In en, this message translates to:
  /// **'hey there!\n\ni created \'days\' as a daily reminder that life is\ntoo short to spend doing things I am not excited about this.\ni hope every time you look at this app you\'re reminded\n\n\nevery day matters\n\nlove,'**
  String get about_app;

  /// No description provided for @settings.
  ///
  /// In en, this message translates to:
  /// **'settings'**
  String get settings;

  /// No description provided for @privacy.
  ///
  /// In en, this message translates to:
  /// **'privacy'**
  String get privacy;

  /// No description provided for @about.
  ///
  /// In en, this message translates to:
  /// **'about'**
  String get about;

  /// No description provided for @terms.
  ///
  /// In en, this message translates to:
  /// **'terms'**
  String get terms;

  /// No description provided for @github.
  ///
  /// In en, this message translates to:
  /// **'github'**
  String get github;

  /// No description provided for @more_days_of_growth.
  ///
  /// In en, this message translates to:
  /// **'more days of growth'**
  String get more_days_of_growth;

  /// No description provided for @days_left_in_the_year.
  ///
  /// In en, this message translates to:
  /// **'days left in the year'**
  String get days_left_in_the_year;
}

class _DayLocalizationsDelegate
    extends LocalizationsDelegate<DayLocalizations> {
  const _DayLocalizationsDelegate();

  @override
  Future<DayLocalizations> load(Locale locale) {
    return SynchronousFuture<DayLocalizations>(lookupDayLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'ky', 'ru'].contains(locale.languageCode);

  @override
  bool shouldReload(_DayLocalizationsDelegate old) => false;
}

DayLocalizations lookupDayLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return DayLocalizationsEn();
    case 'ky':
      return DayLocalizationsKy();
    case 'ru':
      return DayLocalizationsRu();
  }

  throw FlutterError(
    'DayLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
