import 'dart:ui';

import '../enums.dart';

class LocaleBuilder {
  static Locale getLocale(String languageCode) {
    switch (languageCode) {
      default:
        return Locale(Language.en.value, 'US');
    }
  }
}
