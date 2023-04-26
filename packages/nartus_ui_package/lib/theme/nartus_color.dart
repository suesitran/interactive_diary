part of 'nartus_theme.dart';

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
      colors: <Color>[
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

  static const Color white = Color(0xFFFFFFFF);
  static const Color grey = Color(0xFF6B727B);
  static const Color lightGrey = Color(0xFFECECF1);
  static const Color dark = Color(0xFF1C2025);
  static const Color black = Color(0xFF000000);
  static const Color semiLightGrey = Color(0xFFD1D1D1);

  static const Color backButtonColor = Color(0xFF292D32);
}

const ColorScheme lightColorScheme = ColorScheme(
  brightness: Brightness.light,
  primary: NartusColor.primary,
  onPrimary: NartusColor.onPrimary,
  secondary: NartusColor.secondary,
  onSecondary: NartusColor.onSecondary,
  error: NartusColor.red,
  onError: NartusColor.onRed,
  onErrorContainer: NartusColor.onRedContainer,
  errorContainer: NartusColor.redContainer,
  background: NartusColor.background,
  onBackground: NartusColor.onBackground,
  surface: NartusColor.surface,
  onSurface: NartusColor.onSurface,
  primaryContainer: NartusColor.primaryContainer,
  onPrimaryContainer: NartusColor.onPrimaryContainer,
  secondaryContainer: NartusColor.secondaryContainer,
  onSecondaryContainer: NartusColor.onSecondaryContainer,
);
