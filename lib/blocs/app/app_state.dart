import 'dart:ui';

import 'package:equatable/equatable.dart';

class AppState extends Equatable {
  final String appTheme;
  final String fontFamily;
  final Locale locale;

  AppState({
    AppState state,
    String appTheme,
    String fontFamily,
    Locale locale,
  })  : appTheme = appTheme ?? state?.appTheme,
        fontFamily = fontFamily ?? state?.fontFamily,
        locale = locale ?? state?.locale;

  @override
  List<Object> get props => [appTheme, locale, fontFamily];
}
