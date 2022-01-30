import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TextWidgetUtils {
  static const primaryFont = "MerriweatherSans";
  static const secondaryFont = "coolvetica";
  static const defaultFont = "Roboto";

  static TextStyle getTitleStyleText(
      {double fontSize = 16,
      FontWeight fontWeight = FontWeight.w500,
      Color color = Colors.black}) {
    return getRegularStyleText(
        color: color, fontWeight: fontWeight, fontSize: fontSize);
  }

  static TextStyle getRegularStyleText(
      {double fontSize = 14,
      FontWeight fontWeight = FontWeight.normal,
      Color color = Colors.black}) {
    return TextStyle(
        color: color,
        fontWeight: fontWeight,
        fontSize: fontSize,
        fontFamily: primaryFont);
  }

  static TextStyle getBaseStyleText(
      {double fontSize = 16,
      FontWeight fontWeight = FontWeight.normal,
      Color color = Colors.black}) {
    return TextStyle(
        color: color,
        fontWeight: fontWeight,
        fontSize: fontSize,
        fontFamily: defaultFont);
  }

  static TextStyle getHeaderStyleText(
      {double fontSize = 22,
      FontWeight fontWeight = FontWeight.normal,
      Color? color}) {
    return TextStyle(
        color: color,
        fontWeight: fontWeight,
        fontSize: fontSize,
        fontFamily: secondaryFont);
  }
}
