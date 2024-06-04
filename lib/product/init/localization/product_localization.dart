import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:health_excercise/product/utility/constants/enums/locales.dart';

@immutable

/// Product localization manager
final class ProductLocalization extends EasyLocalization {
  /// Product Localization needs [child]
  ProductLocalization({
    required super.child,
    super.key,
  }) : super(
          supportedLocales: _supportedLocales,
          path: _translationPath,
          useOnlyLangCode: true,
        );

  static final List<Locale> _supportedLocales = [
    Locales.tr.locale,
    Locales.en.locale,
  ];

  static const String _translationPath = 'assets/translations';

  /// Change project language by using [Locales]
  static Future<void> updateLanguage({
    required BuildContext context,
    required Locales value,
  }) =>
      context.setLocale(value.locale);
}
