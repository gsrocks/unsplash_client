import 'dart:ui';

import 'package:flutter/material.dart';

Color primaryColor = Color(0xFFC19875);
Color secondaryColor = Color(0xffF2E3BC);
Color backgroundColor = Color(0xFFFCFCFC);

ThemeData themeLight = ThemeData.light().copyWith(
  colorScheme: ColorScheme.light().copyWith(
    primary: primaryColor,
    primaryVariant: primaryColor,
    secondary: secondaryColor,
    secondaryVariant: secondaryColor,
    surface: backgroundColor,
    onSecondary: Colors.black54,
    onPrimary: Colors.black54,
    background: backgroundColor,
  ),
  backgroundColor: backgroundColor,
  accentColor: primaryColor,
  buttonColor: primaryColor,
  primaryColor: primaryColor,
  buttonTheme: ButtonThemeData(buttonColor: primaryColor),
  primaryTextTheme: TextTheme(
      headline6: TextStyle(color: primaryColor, fontWeight: FontWeight.bold)),
  appBarTheme: AppBarTheme(
    centerTitle: true,
    elevation: 0,
    backgroundColor: backgroundColor,
  ),
);
