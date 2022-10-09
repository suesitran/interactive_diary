import 'package:flutter/material.dart';

const MaterialColor lightColorSwatch = MaterialColor(0xFF779ECB, {
  50: Color(0xFFEFF3F9),
  100: Color(0xFFD6E2EF),
  200: Color(0xFFBBCFE5),
  300: Color(0xFFA0BBDB),
  400: Color(0xFF8BADD3),
  500: Color(0xFF779ECB),
  600: Color(0xFF6F96C6),
  700: Color(0xFF648CBE),
  800: Color(0xFF5A82B8),
  900: Color(0xFF4770AC)
});

class NartusColor {
  static const Color errorColor = Color(0xFF8B0101);
  static const Color primary = Color(0xFF7D54F8);
  static const Color onPrimary = Color(0xFFFFFFFF);
  static const Color primaryContainer = Color(0xFFEFEAFE);
  static const Color onPrimaryContainer = Color(0xFF1C2025);

  static const Color secondary = Color(0xFF7A7A7A);
  static const Color onSecondary = Color(0xFFFFFFFF);
  static const Color secondaryContainer = Color(0xFFECECF1);
  static const Color onSecondaryContainer = Color(0xFF1C2025);

  static const Color background = Color(0xFFFFFFFF);
  static const Color onBackground = Color(0xFF1C2025);
  static const Color surface = Color(0xFFFFFFFF);
  static const Color onSurface = Color(0xFF1C2025);

  static const Gradient gradient = LinearGradient(
      begin: Alignment.bottomLeft,
      end: Alignment.topRight,
      colors: [
        Color(0xFFFBF2E3),
        Color(0xFFEFF2FB),
      ]);
  static const Color onGradient = Color(0xFF1C2025);

  static const Color red = Color(0xFFB3261E);
  static const Color onRed = Color(0xFFFFFFFF);
  static const Color redContainer = Color(0xFFF6E5E4);
  static const Color onRedContainer = Color(0xFF1C2025);

  static const Color green = Color(0xFF00B14F);
  static const Color onGreen = Color(0xFFFFFFFF);
  static const Color greenContainer = Color(0xFFE0F6EA);
  static const Color onGreenContainer = Color(0xFF1C2025);

  static const Color orange = Color(0xFFF39C14);
  static const Color onOrange = Color(0xFF1C2025);
  static const Color orangeContainer = Color(0xFFFEF3E3);
  static const Color onOrangeContainer = Color(0xFF1C2025);
}

const ColorScheme lightColorScheme = ColorScheme(
    brightness: Brightness.light,
    primary: NartusColor.primary,
    onPrimary: NartusColor.onPrimary,
    secondary: NartusColor.secondary,
    onSecondary: NartusColor.onSecondary,
    error: NartusColor.red,
    onError: NartusColor.red,
    background: NartusColor.background,
    onBackground: NartusColor.onBackground,
    surface: NartusColor.surface,
    onSurface: NartusColor.onSurface);
