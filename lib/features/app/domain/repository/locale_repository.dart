import 'package:flutter/material.dart' show Locale;

abstract class LocaleRepository {
  void setLocale(Locale theme);
  Future<Locale?> getLocale();
}