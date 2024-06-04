import 'package:flutter/material.dart';

/// Project Locale enum
enum Locales {
  /// Turkish locale
  tr(Locale('tr', 'TR')),

  /// English locale
  en(Locale('en', 'US')),
  ;

  const Locales(this.locale);

  /// Locale instance
  final Locale locale;
}
