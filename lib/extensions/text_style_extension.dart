import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../resources/resources.dart';

extension TextStyleExt on TextStyle {
  TextStyle get errorColor => textColor(MyColors.red);
  TextStyle get underLine => setDecoration(TextDecoration.underline);
  TextStyle get primaryWhiteColor => textColor(MyColors.primaryWhite);
  TextStyle get primaryColor => textColor(MyColors.primary);
  TextStyle get description => textColor(MyColors.description);
  TextStyle get secondaryPrimary => textColor(MyColors.secondaryPrimary);

  TextStyle get size8 => size(Dimens.typography8);
  TextStyle get size10 => size(Dimens.typography10);
  TextStyle get size12 => size(Dimens.typography12);
  TextStyle get size13 => size(Dimens.typography13);
  TextStyle get size14 => size(Dimens.typography14);
  TextStyle get size15 => size(Dimens.typography15);
  TextStyle get size16 => size(Dimens.typography16);
  TextStyle get size17 => size(Dimens.typography17);
  TextStyle get size18 => size(Dimens.typography18);
  TextStyle get size19 => size(Dimens.typography19);
  TextStyle get size20 => size(Dimens.typography20);
  TextStyle get size21 => size(Dimens.typography21);
  TextStyle get size24 => size(Dimens.typography24);
  TextStyle get size38 => size(Dimens.typography38);
  TextStyle get lineThrough => setDecoration(TextDecoration.lineThrough);

  TextStyle get thin => weight(FontWeight.w100);

  TextStyle get extraLight => weight(FontWeight.w200);

  TextStyle get light => weight(FontWeight.w300);

  TextStyle get regular => weight(FontWeight.w400);

  TextStyle get medium => weight(FontWeight.w500);

  TextStyle get semiBold => weight(FontWeight.w600);

  TextStyle get bold => weight(FontWeight.w700);

  TextStyle get italic => fontStyle(FontStyle.italic);

  TextStyle get normal => fontStyle(FontStyle.normal);

  TextStyle size(double size) => copyWith(fontSize: size);

  TextStyle textColor(Color v) => copyWith(color: v);

  TextStyle weight(FontWeight v) => copyWith(fontWeight: v);

  TextStyle fontStyle(FontStyle v) => copyWith(fontStyle: v);

  TextStyle setDecoration(TextDecoration v) => copyWith(decoration: v);

  TextStyle fontFamilies(String v) => copyWith(fontFamily: v);

  TextStyle fontHeight(double height) => copyWith(height: height);
}