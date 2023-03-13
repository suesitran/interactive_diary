import 'package:flutter_test/flutter_test.dart';
import 'package:nartus_ui_package/nartus_ui.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test('Validate all theme color', () {
    // brightness is light
    expect(lightTheme.brightness, Brightness.light);

    // ensure there's no changes to our color scheme from design
    // primary color
    expect(lightTheme.colorScheme.primary, const Color(0xFF7D54F8));
    // onPrimary color
    expect(lightTheme.colorScheme.onPrimary, const Color(0xFFFFFFFF));
    // primary container
    expect(lightTheme.colorScheme.primaryContainer, const Color(0xFFEFEAFE));
    // on primary container
    expect(lightTheme.colorScheme.onPrimaryContainer, const Color(0xFF1C2025));
    // secondary
    expect(lightTheme.colorScheme.secondary, const Color(0xFF7A7A7A));
    // on secondary
    expect(lightTheme.colorScheme.onSecondary, const Color(0xFFFFFFFF));
    // secondary container
    expect(lightTheme.colorScheme.secondaryContainer, const Color(0xFFECECF1));
    // on secondary container
    expect(
        lightTheme.colorScheme.onSecondaryContainer, const Color(0xFF1C2025));
    // background
    expect(lightTheme.colorScheme.background, const Color(0xFFFFFFFF));
    // on background
    expect(lightTheme.colorScheme.onBackground, const Color(0xFF1C2025));
    // surface
    expect(lightTheme.colorScheme.surface, const Color(0xFFFFFFFF));
    // on surface
    expect(lightTheme.colorScheme.onSurface, const Color(0xFF1C2025));
    // error
    expect(lightTheme.colorScheme.error, const Color(0xFFB3261E));
    // on error
    expect(lightTheme.colorScheme.onError, const Color(0xFFFFFFFF));
    // error container
    expect(lightTheme.colorScheme.errorContainer, const Color(0xFFF6E5E4));
    // on error container
    expect(lightTheme.colorScheme.onErrorContainer, const Color(0xFF1C2025));
  });
}
