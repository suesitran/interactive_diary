import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';



// final TextTheme textTheme = GoogleFonts.plusJakartaSansTextTheme();

class FontStyleGuide {
  static const double fontSize48 = 48;
  static const double fontSize32 = 32;
  static const double fontSize24 = 24;
  static const double fontSize20 = 20;
  static const double fontSize18 = 18;
  static const double fontSize16 = 16;
  static const double fontSize14 = 14;
  static const double fontSize12 = 12;
  static const double fontSize10 = 10;

  static const double lineHeight64 = 64;
  static const double lineHeight40 = 40;
  static const double lineHeight32 = 32;
  static const double lineHeight30 = 30;
  static const double lineHeight28 = 28;
  static const double lineHeight24 = 24;
  static const double lineHeight22 = 22;
  static const double lineHeight18 = 18;
  static const double lineHeight16 = 16;

  static const double letterSpacing0 = 0;

  static const FontWeight fwBold = FontWeight.w700;
  static const FontWeight fwSemiBold = FontWeight.w600;
  static const FontWeight fwRegular = FontWeight.w400;

}

const TextTheme textTheme = TextTheme(
  /// [DISPLAY] ----------------------------------------------------------------

  displayLarge: TextStyle(
      fontSize: FontStyleGuide.fontSize48,
      height: FontStyleGuide.lineHeight64,
      letterSpacing: FontStyleGuide.letterSpacing0,
      fontWeight: FontStyleGuide.fwBold),
  displayMedium: TextStyle(
      fontSize: FontStyleGuide.fontSize32,
      height: FontStyleGuide.lineHeight40,
      letterSpacing: FontStyleGuide.letterSpacing0,
      fontWeight: FontStyleGuide.fwBold),
  displaySmall: TextStyle(
      fontSize: FontStyleGuide.fontSize24,
      height: FontStyleGuide.lineHeight40,
      letterSpacing: FontStyleGuide.letterSpacing0,
      fontWeight: FontStyleGuide.fwBold),

  /// [HEADLINE] ---------------------------------------------------------------

  headlineLarge: TextStyle(
      fontSize: FontStyleGuide.fontSize20,
      height: FontStyleGuide.lineHeight30,
      letterSpacing: FontStyleGuide.letterSpacing0,
      fontWeight: FontStyleGuide.fwBold),
  headlineMedium: TextStyle(
      fontSize: FontStyleGuide.fontSize18,
      height: FontStyleGuide.lineHeight28,
      letterSpacing: FontStyleGuide.letterSpacing0,
      fontWeight: FontStyleGuide.fwBold),

  /// [TITLE] ------------------------------------------------------------------

  titleLarge: TextStyle(
      fontSize: FontStyleGuide.fontSize18,
      height: FontStyleGuide.lineHeight28,
      letterSpacing: FontStyleGuide.letterSpacing0,
      fontWeight: FontStyleGuide.fwSemiBold),
  titleMedium: TextStyle(
      fontSize: FontStyleGuide.fontSize16,
      height: FontStyleGuide.lineHeight24,
      letterSpacing: FontStyleGuide.letterSpacing0,
      fontWeight: FontStyleGuide.fwSemiBold),
  titleSmall: TextStyle(
      fontSize: FontStyleGuide.fontSize14,
      height: FontStyleGuide.lineHeight22,
      letterSpacing: FontStyleGuide.letterSpacing0,
      fontWeight: FontStyleGuide.fwSemiBold),

  /// [BODY] -------------------------------------------------------------------

  bodyLarge: TextStyle(
      fontSize: FontStyleGuide.fontSize16, height: FontStyleGuide.lineHeight24, 
      letterSpacing: FontStyleGuide.letterSpacing0, fontWeight: FontStyleGuide.fwRegular),
  bodyMedium: TextStyle(
      fontSize: FontStyleGuide.fontSize14, height: FontStyleGuide.lineHeight22, 
      letterSpacing: FontStyleGuide.letterSpacing0, fontWeight: FontStyleGuide.fwRegular),
  bodySmall: TextStyle(
      fontSize: FontStyleGuide.fontSize12, height: FontStyleGuide.lineHeight18, 
      letterSpacing: FontStyleGuide.letterSpacing0, fontWeight: FontStyleGuide.fwRegular),

  /// [LABEL] ------------------------------------------------------------------

  labelMedium: TextStyle(
      fontSize: FontStyleGuide.fontSize12, height: FontStyleGuide.lineHeight18, 
      letterSpacing: FontStyleGuide.letterSpacing0, fontWeight: FontStyleGuide.fwSemiBold),
  labelSmall: TextStyle(
      fontSize: FontStyleGuide.fontSize10, height: FontStyleGuide.lineHeight16, 
      letterSpacing: FontStyleGuide.letterSpacing0, fontWeight: FontStyleGuide.fwSemiBold),
);
