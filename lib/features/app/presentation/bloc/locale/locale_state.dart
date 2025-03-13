part of 'locale_bloc.dart';

final class LocaleState {
  final Locale locale;

  LocaleState({
    required this.locale,
  });

  LocaleState.initial() : locale = const Locale('en', 'US');

}