part of 'locale_bloc.dart';

@immutable
sealed class LocaleEvent {}

final class LocaleSetInitialEvent extends LocaleEvent {
  final Locale locale;
  LocaleSetInitialEvent(this.locale);
}

final class LocaleSetEvent extends LocaleEvent {
  final Locale locale;
  LocaleSetEvent(this.locale);
}

final class LocaleGetEvent extends LocaleEvent {}