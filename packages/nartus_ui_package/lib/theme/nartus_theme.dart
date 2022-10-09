import 'package:flutter/material.dart';

import 'nartus_color.dart';

ThemeData lightTheme = ThemeData(
  primarySwatch: lightColorSwatch,
  errorColor: NartusColor.red,
  textTheme: _textTheme,
  materialTapTargetSize: MaterialTapTargetSize.padded,
  // fontFamily: 
);

const FontWeight fwBold = FontWeight.w700;
const FontWeight fwSemiBold = FontWeight.w600;
const FontWeight fwRegular = FontWeight.w400;

const TextTheme _textTheme = TextTheme(

  displayLarge: TextStyle(fontSize: 48, height: 64, letterSpacing: 0, fontWeight: fwBold),
  displayMedium: TextStyle(fontSize: 32, height: 40, letterSpacing: 0, fontWeight: fwBold),
  displaySmall: TextStyle(fontSize: 24, height: 32, letterSpacing: 0, fontWeight: fwBold),

  /// --------------------------------------------------------------------------
  
  headlineLarge: TextStyle(fontSize: 20, height: 30, letterSpacing: 0, fontWeight: fwBold),
  headlineMedium: TextStyle(fontSize: 18, height: 28, letterSpacing: 0, fontWeight: fwBold),

  /// --------------------------------------------------------------------------

  titleLarge: TextStyle(fontSize: 18, height: 28, letterSpacing: 0, fontWeight: fwSemiBold),
  titleMedium: TextStyle(fontSize: 16, height: 24, letterSpacing: 0, fontWeight: fwSemiBold),
  titleSmall: TextStyle(fontSize: 14, height: 22, letterSpacing: 0, fontWeight: fwSemiBold),

  /// --------------------------------------------------------------------------

  bodyLarge: TextStyle(fontSize: 16, height: 24, letterSpacing: 0, fontWeight: fwRegular),
  bodyMedium: TextStyle(fontSize: 14, height: 22, letterSpacing: 0, fontWeight: fwRegular),
  bodySmall: TextStyle(fontSize: 12, height: 18, letterSpacing: 0, fontWeight: fwRegular),

  /// --------------------------------------------------------------------------

  labelMedium: TextStyle(fontSize: 12, height: 18, letterSpacing: 0, fontWeight: fwSemiBold),
  labelSmall: TextStyle(fontSize: 10, height: 16, letterSpacing: 0, fontWeight: fwSemiBold),

  /// --------------------------------------------------------------------------

);
