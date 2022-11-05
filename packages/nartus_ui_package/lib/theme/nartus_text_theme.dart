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

  displayLarge: _displayLarge,
  displayMedium: _displayMedium,
  displaySmall: _displaySmall,

  /// [HEADLINE] ---------------------------------------------------------------

  headlineLarge: _headlineLarge,
  headlineMedium: _headlineMedium,

  /// [TITLE] ------------------------------------------------------------------

  titleLarge: _titleLarge,
  titleMedium: _titleMedium,
  titleSmall: _titleSmall,

  /// [BODY] -------------------------------------------------------------------

  bodyLarge: _bodyLarge,
  bodyMedium: _bodyMedium,
  bodySmall: _bodySmall,

  /// [LABEL] ------------------------------------------------------------------

  labelMedium: _labelMedium,
  labelSmall: _labelSmall,
);

/// ---------------------------------------------------------------------------
/// Define all text styles
const TextStyle _displayLarge = TextStyle(
    fontSize: FontStyleGuide.fontSize48,
    letterSpacing: FontStyleGuide.letterSpacing0,
    fontWeight: FontStyleGuide.fwBold);

const TextStyle _displayMedium = TextStyle(
    fontSize: FontStyleGuide.fontSize32,
    letterSpacing: FontStyleGuide.letterSpacing0,
    fontWeight: FontStyleGuide.fwBold);

const TextStyle _displaySmall = TextStyle(
    fontSize: FontStyleGuide.fontSize24,
    letterSpacing: FontStyleGuide.letterSpacing0,
    fontWeight: FontStyleGuide.fwBold);

const TextStyle _headlineLarge = TextStyle(
    fontSize: FontStyleGuide.fontSize20,
    letterSpacing: FontStyleGuide.letterSpacing0,
    fontWeight: FontStyleGuide.fwBold);

const TextStyle _headlineMedium = TextStyle(
    fontSize: FontStyleGuide.fontSize18,
    letterSpacing: FontStyleGuide.letterSpacing0,
    fontWeight: FontStyleGuide.fwBold);

const TextStyle _titleLarge = TextStyle(
    fontSize: FontStyleGuide.fontSize18,
    letterSpacing: FontStyleGuide.letterSpacing0,
    fontWeight: FontStyleGuide.fwSemiBold);

const TextStyle _titleMedium = TextStyle(
    fontSize: FontStyleGuide.fontSize16,
    letterSpacing: FontStyleGuide.letterSpacing0,
    fontWeight: FontStyleGuide.fwSemiBold);

const TextStyle _titleSmall = TextStyle(
    fontSize: FontStyleGuide.fontSize14,
    letterSpacing: FontStyleGuide.letterSpacing0,
    fontWeight: FontStyleGuide.fwSemiBold);

const TextStyle _bodyLarge = TextStyle(
    fontSize: FontStyleGuide.fontSize16,
    letterSpacing: FontStyleGuide.letterSpacing0,
    fontWeight: FontStyleGuide.fwRegular);

const TextStyle _bodyMedium = TextStyle(
    fontSize: FontStyleGuide.fontSize14,
    letterSpacing: FontStyleGuide.letterSpacing0,
    fontWeight: FontStyleGuide.fwRegular);

const TextStyle _bodySmall = TextStyle(
    fontSize: FontStyleGuide.fontSize12,
    letterSpacing: FontStyleGuide.letterSpacing0,
    fontWeight: FontStyleGuide.fwRegular);

const TextStyle _labelMedium = TextStyle(
    fontSize: FontStyleGuide.fontSize12,
    letterSpacing: FontStyleGuide.letterSpacing0,
    fontWeight: FontStyleGuide.fwSemiBold);

const TextStyle _labelSmall = TextStyle(
    fontSize: FontStyleGuide.fontSize10,
    letterSpacing: FontStyleGuide.letterSpacing0,
    fontWeight: FontStyleGuide.fwSemiBold);
