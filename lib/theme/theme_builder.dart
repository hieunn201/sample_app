import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import '../extensions/extension.dart';
import '../resources/resources.dart';

class ThemeBuilder {
  static ThemeData build(BuildContext context, String themeName, {String fontFamily}) {
    return _getTheme(context, themeName, MyColors.primary, fontFamily: fontFamily);
  }

  static ThemeMode themeMode(String theme) {
    if (theme == null) return ThemeMode.system;

    switch (theme) {
      case 'dark':
        return ThemeMode.dark;
      case 'system':
        return ThemeMode.system;
      default:
        return ThemeMode.light;
    }
  }

  static ThemeData _generateBasicTheme(
    BuildContext context,
    MaterialColor primaryColor, {
    ThemeData themeData,
    bool isDark,
    String fontFamily,
  }) {
    final _isDark = isDark ?? false;
    final _themeData = themeData ?? ThemeData();
    final _defaultTextTheme = _themeData.textTheme;
    final _primaryColor = primaryColor ?? _themeData.primaryColor.materialColor;

    final _textTheme = _defaultTextTheme.copyWith(
      headline1: _themeData.textTheme.headline1.medium
          .size(97.0)
          .textColor(_isDark ? MyColors.text.combineWhite40 : MyColors.text),
      headline2: _themeData.textTheme.headline2.medium
          .size(61.0)
          .textColor(_isDark ? MyColors.text.combineWhite40 : MyColors.text),
      headline3: _themeData.textTheme.headline3.medium
          .size(48.0)
          .textColor(_isDark ? MyColors.text.combineWhite40 : MyColors.text),
      headline4: _themeData.textTheme.headline4.medium
          .size(34.0)
          .textColor(_isDark ? MyColors.text.combineWhite40 : MyColors.text),
      headline5: _themeData.textTheme.headline5.medium
          .size(28.0)
          .textColor(_isDark ? MyColors.text.combineWhite40 : MyColors.text),
      headline6: _themeData.textTheme.headline6.medium
          .size(20.0)
          .textColor(_isDark ? MyColors.text.combineWhite40 : MyColors.text),
      subtitle1: _themeData.textTheme.subtitle1.medium.size14
          .textColor(_isDark ? MyColors.text.combineWhite40 : MyColors.text),
      subtitle2: _themeData.textTheme.subtitle2.medium.size13
          .textColor(_isDark ? MyColors.text.combineWhite40 : MyColors.text),
      bodyText1: _themeData.textTheme.bodyText1.medium.size16
          .textColor(_isDark ? MyColors.text.combineWhite40 : MyColors.text),
      bodyText2: _themeData.textTheme.bodyText2.medium.size15
          .textColor(_isDark ? MyColors.text.combineWhite40 : MyColors.text),
      button: _themeData.textTheme.button.bold.size14.textColor(_primaryColor),
      caption: _themeData.textTheme.caption.size12.textColor(_isDark ? MyColors.text.combineWhite40 : MyColors.text),
      overline: _themeData.textTheme.overline.size10.textColor(_isDark ? MyColors.text.combineWhite40 : MyColors.text),
    );
    return ThemeData(
      primarySwatch: _primaryColor,
      brightness: _isDark ? Brightness.dark : Brightness.light,
      backgroundColor: MyColors.primary,
      colorScheme: (_isDark ? ColorScheme.dark() : ColorScheme.fromSwatch()),
      primaryColor: MyColors.primary,
      primaryColorLight: MyColors.primaryLight,
      primaryColorDark: MyColors.primaryDark,
      disabledColor: _isDark ? MyColors.dark_unselected_item_color : MyColors.unselected_item_color,
      accentColor: _isDark ? _primaryColor.combineWhite40 : _primaryColor,
      indicatorColor: _isDark ? _primaryColor.combineWhite40 : _primaryColor,
      errorColor: _isDark ? MyColors.dark_red : MyColors.red,
      unselectedWidgetColor: _isDark ? MyColors.dark_unselected_item_color : MyColors.unselected_item_color,
      toggleableActiveColor: _isDark ? _primaryColor.combineWhite40 : _primaryColor,
      dividerColor: MyColors.divider,
      textSelectionTheme: TextSelectionThemeData(
        selectionHandleColor: _isDark ? _primaryColor.combineWhite40 : MyColors.primaryLight,
        cursorColor: _isDark ? _primaryColor.combineWhite40 : MyColors.text,
        selectionColor: _isDark ? _primaryColor.combineWhite70 : MyColors.hintColor,
      ),
      textTheme: _textTheme,
      splashColor: _primaryColor.shade100,
      hintColor: _isDark ? MyColors.hintColor.combineWhite40 : MyColors.hintColor,
      appBarTheme: AppBarTheme(
        brightness: !_isDark ? Brightness.dark : Brightness.light,
        color: _isDark ? MyColors.primaryDark : MyColors.primary,
        iconTheme: IconThemeData(color: _isDark ? MyColors.primaryWhite : MyColors.primaryDark),
        actionsIconTheme: IconThemeData(color: _isDark ? MyColors.primaryWhite : MyColors.primaryDark),
        elevation: _isDark ? null : 1,
        textTheme: _textTheme.copyWith(
          headline6: _textTheme.headline6.copyWith(color: MyColors.primaryDark).size(18.0),
        ),
        centerTitle: true,
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        unselectedItemColor: _isDark ? MyColors.description.combineWhite40 : MyColors.description,
        selectedItemColor: _isDark ? _primaryColor.combineWhite40 : _primaryColor,
        backgroundColor: _isDark ? null : Colors.white,
        unselectedLabelStyle: _themeData.textTheme.overline.medium.size(10.0),
        selectedLabelStyle: _themeData.textTheme.overline.medium.size(10.0),
        type: BottomNavigationBarType.fixed,
      ),
      scaffoldBackgroundColor: MyColors.scaffoldBackgroundColor,
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
          elevation: MaterialStateProperty.all(0.0),
          shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0))),
          padding: MaterialStateProperty.all(
            EdgeInsets.all(16.0),
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: ButtonStyle(
          shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0))),
          padding: MaterialStateProperty.all(
            EdgeInsets.all(16.0),
          ),
        ),
      ),
      inputDecorationTheme: _themeData.inputDecorationTheme.copyWith(
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: MyColors.hintColor),
        ),
        focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: MyColors.primaryDark)),
      ),
      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: Colors.transparent,
        clipBehavior: Clip.antiAliasWithSaveLayer,

      )
    );
  }

  static ThemeData _getTheme(BuildContext context, String themeName, Color primaryColor, {String fontFamily}) {
    switch (themeName) {
      case 'dark':
        return _darkTheme(context, primaryColor, fontFamily: fontFamily);
      case 'system':
        final deviceBrightness = SchedulerBinding.instance.window.platformBrightness;
        if (deviceBrightness == Brightness.dark) return _darkTheme(context, primaryColor, fontFamily: fontFamily);
        break;
    }

    return _lightTheme(context, primaryColor, fontFamily: fontFamily);
  }

  static ThemeData _lightTheme(BuildContext context, Color primaryColor, {String fontFamily}) {
    return _generateBasicTheme(
      context,
      primaryColor == null ? null : primaryColor.materialColor,
      isDark: false,
      fontFamily: fontFamily,
    );
  }

  static ThemeData _darkTheme(BuildContext context, Color primaryColor, {String fontFamily}) {
    return _generateBasicTheme(
      context,
      primaryColor == null ? null : primaryColor.materialColor,
      isDark: true,
      fontFamily: fontFamily,
    );
  }
}
