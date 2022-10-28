part of 'nartus_theme.dart';

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

  static const double letterSpacing0 = 0;

  static const FontWeight fwBold = FontWeight.w700;
  static const FontWeight fwSemiBold = FontWeight.w600;
  static const FontWeight fwRegular = FontWeight.w400;
}

const TextTheme textTheme = TextTheme(
  /// [DISPLAY] ----------------------------------------------------------------

  displayLarge: TextStyle(
      fontSize: FontStyleGuide.fontSize48,
      letterSpacing: FontStyleGuide.letterSpacing0,
      fontWeight: FontStyleGuide.fwBold),
  displayMedium: TextStyle(
      fontSize: FontStyleGuide.fontSize32,
      letterSpacing: FontStyleGuide.letterSpacing0,
      fontWeight: FontStyleGuide.fwBold),
  displaySmall: TextStyle(
      fontSize: FontStyleGuide.fontSize24,
      letterSpacing: FontStyleGuide.letterSpacing0,
      fontWeight: FontStyleGuide.fwBold),

  /// [HEADLINE] ---------------------------------------------------------------

  headlineLarge: TextStyle(
      fontSize: FontStyleGuide.fontSize20,
      letterSpacing: FontStyleGuide.letterSpacing0,
      fontWeight: FontStyleGuide.fwBold),
  headlineMedium: TextStyle(
      fontSize: FontStyleGuide.fontSize18,
      letterSpacing: FontStyleGuide.letterSpacing0,
      fontWeight: FontStyleGuide.fwBold),

  /// [TITLE] ------------------------------------------------------------------

  titleLarge: TextStyle(
      fontSize: FontStyleGuide.fontSize18,
      letterSpacing: FontStyleGuide.letterSpacing0,
      fontWeight: FontStyleGuide.fwSemiBold),
  titleMedium: TextStyle(
      fontSize: FontStyleGuide.fontSize16,
      letterSpacing: FontStyleGuide.letterSpacing0,
      fontWeight: FontStyleGuide.fwSemiBold),
  titleSmall: TextStyle(
      fontSize: FontStyleGuide.fontSize14,
      letterSpacing: FontStyleGuide.letterSpacing0,
      fontWeight: FontStyleGuide.fwSemiBold),

  /// [BODY] -------------------------------------------------------------------

  bodyLarge: TextStyle(
      fontSize: FontStyleGuide.fontSize16,
      letterSpacing: FontStyleGuide.letterSpacing0,
      fontWeight: FontStyleGuide.fwRegular),
  bodyMedium: TextStyle(
      fontSize: FontStyleGuide.fontSize14,
      letterSpacing: FontStyleGuide.letterSpacing0,
      fontWeight: FontStyleGuide.fwRegular),
  bodySmall: TextStyle(
      fontSize: FontStyleGuide.fontSize12,
      letterSpacing: FontStyleGuide.letterSpacing0,
      fontWeight: FontStyleGuide.fwRegular),

  /// [LABEL] ------------------------------------------------------------------

  labelMedium: TextStyle(
      fontSize: FontStyleGuide.fontSize12,
      letterSpacing: FontStyleGuide.letterSpacing0,
      fontWeight: FontStyleGuide.fwSemiBold),
  labelSmall: TextStyle(
      fontSize: FontStyleGuide.fontSize10,
      letterSpacing: FontStyleGuide.letterSpacing0,
      fontWeight: FontStyleGuide.fwSemiBold),
);
