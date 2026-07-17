import 'package:flutter/material.dart';
import 'package:ilajak/core/constants/app_constants.dart';

class LocalizationHelper {
  static const List<Locale> supportedLocales = [
    Locale(AppConstants.arabicLangCode),
    Locale(AppConstants.englishLangCode),
  ];

  static const String path = AppConstants.translationsPath;

  static Locale get fallbackLocale =>
      const Locale(AppConstants.englishLangCode);
}
