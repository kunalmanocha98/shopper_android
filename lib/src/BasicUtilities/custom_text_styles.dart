
import 'package:flutter/painting.dart';
import 'package:shopper/src/BasicUtilities/shopper_colors.dart';

class ShopperTextStyles {
  static TextStyle get headline1 => TextStyle(
        fontSize: 96,
        fontWeight: FontWeight.w300,
        color: ShopperColor.appColorBlack85,
      );

  static TextStyle get headline2 => TextStyle(
        fontSize: 60,
        fontWeight: FontWeight.w300,
        color: ShopperColor.appColorBlack85,
      );

  static TextStyle get headline3 => TextStyle(
        fontSize: 48,
        fontWeight: FontWeight.normal,
        color: ShopperColor.appColorBlack85,
      );

  static TextStyle get headline4 => TextStyle(
        fontSize: 34,
        fontWeight: FontWeight.normal,
        color: ShopperColor.appColorBlack85,
      );

  static TextStyle get headline5 => TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: ShopperColor.appColorBlack85,
      );

  static TextStyle get headline6 => TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w500,
        color: ShopperColor.appColorBlack85,
      );

  static TextStyle get subtitle1 => TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        color: ShopperColor.appColorBlack85,
      );

  static TextStyle get subtitle2 => TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: ShopperColor.appColorBlack65,
      );

  static TextStyle get bodyText1 => TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.normal,
        color: ShopperColor.appColorBlack65,
      );

  static TextStyle get bodyText2 => TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: ShopperColor.appColorBlack35,
      );

  static TextStyle get button => TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.normal,
      color: ShopperColor.appColorBlack65,
      letterSpacing: 1.25);

  static TextStyle get caption => TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.normal,
      color: ShopperColor.appColorBlack35,
      letterSpacing: 0.4);

  static TextStyle get overline => TextStyle(
      fontSize: 10,
      fontWeight: FontWeight.normal,
      color: ShopperColor.appColorBlack10,
      letterSpacing: 1.5);
}
