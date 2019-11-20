import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

abstract class BasicLocalizations  {
  Locale _currentLocale;
  Locale get currentLocale => _currentLocale;

  operator [](String localizedName) => getLocalizedValue(localizedName);

  BasicLocalizations(Locale locale) {
    _currentLocale = (suportedLocales.contains(locale)
      ? locale
      : defaultLocale);
  }

  Locale get defaultLocale;
  Iterable<Locale> get suportedLocales;

  Map<String, Map<String, String>> get localizedValues;
  
  String getLocalizedValue(localizedName) {
    return localizedValues[currentLocale.languageCode][localizedName];
  }
}

abstract class BasicLocalizationsDelegate<T extends BasicLocalizations> extends LocalizationsDelegate<T> {
  final T Function(Locale locale) customLocalization;

  BasicLocalizationsDelegate(this.customLocalization);

  T defaultLocalization(Locale locale);

  @override
  bool isSupported(Locale locale) => true;

  @override
  Future<T> load(Locale locale) {
    return SynchronousFuture<T>(customLocalization != null 
      ? customLocalization(locale)
      : defaultLocalization(locale));
  }

  @override
  bool shouldReload(LocalizationsDelegate<T> old) => false;
}