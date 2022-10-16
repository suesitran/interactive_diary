import 'package:flutter_test/flutter_test.dart';
import 'package:nartus_ui_package/nartus_ui.dart';

import '../widget_tester_extension.dart';

void main() {
  test('Validate all theme color', () {
    // brightness is light
    expect(lightTheme.brightness, Brightness.light);
    // bottom app bar color is default light - white
    expect(lightTheme.bottomAppBarColor, const Color(0xffffffff));
    // error color is dark red
    expect(lightTheme.errorColor, const Color(0xFFB3261E));
  });

  testWidgetsCustom(lightTheme, const Color(0xFF7D54F8),
      (context) => Theme.of(context).colorScheme.primary);
  testWidgetsCustom(lightTheme, const Color(0xFFFFFFFF),
      (context) => Theme.of(context).colorScheme.onPrimary);
  testWidgetsCustom(lightTheme, const Color(0xFFEFEAFE), 
      (context) => Theme.of(context).colorScheme.primaryContainer);
  testWidgetsCustom(lightTheme, const Color(0xFF1C2025), 
      (context) => Theme.of(context).colorScheme.onPrimaryContainer);
  testWidgetsCustom(lightTheme, const Color(0xFF7A7A7A),
      (context) => Theme.of(context).colorScheme.secondary);
  testWidgetsCustom(lightTheme, const Color(0xFFFFFFFF),
      (context) => Theme.of(context).colorScheme.onSecondary);
  testWidgetsCustom(lightTheme, const Color(0xFFECECF1), 
      (context) => Theme.of(context).colorScheme.secondaryContainer);
  testWidgetsCustom(lightTheme, const Color(0xFF1C2025), 
      (context) => Theme.of(context).colorScheme.onSecondaryContainer);
  testWidgetsCustom(lightTheme, const Color(0xFFFFFFFF),
      (context) => Theme.of(context).colorScheme.background);
  testWidgetsCustom(lightTheme, const Color(0xFF1C2025), 
      (context) => Theme.of(context).colorScheme.onBackground);
  testWidgetsCustom(lightTheme, const Color(0xFFFFFFFF),
      (context) => Theme.of(context).colorScheme.surface);
  testWidgetsCustom(lightTheme, const Color(0xFF1C2025), 
      (context) => Theme.of(context).colorScheme.onSurface);
  testWidgetsCustom(lightTheme, const Color(0xFFB3261E), 
      (context) => Theme.of(context).colorScheme.error);
  testWidgetsCustom(lightTheme, const Color(0xFFFFFFFF), 
      (context) => Theme.of(context).colorScheme.onError);
  testWidgetsCustom(lightTheme, const Color(0xFFF6E5E4), 
      (context) => Theme.of(context).colorScheme.errorContainer);
  testWidgetsCustom(lightTheme, const Color(0xFF1C2025), 
      (context) => Theme.of(context).colorScheme.onErrorContainer);
}

Future<void> testWidgetsCustom(ThemeData theme, Color expectColor,
    Color Function(BuildContext context) getAppliedColor) async {
  testWidgets('Validate color scheme [${expectColor.value.toRadixString(16)}]', (tester) async {
    final testIcon = Builder(builder: (context) {
      return Icon(
        Icons.abc_outlined,
        color: getAppliedColor(context),
      );
    });

    await tester.wrapMaterialAndPump(testIcon, theme: lightTheme);

    final Icon renderedIcon = tester.widget<Icon>(find.byType(Icon));

    expect((renderedIcon.color?.value.toRadixString(16)),
        expectColor.value.toRadixString(16),
        reason: 'Failed compare theme color (${renderedIcon.color?.value.toRadixString(16)}) vs expect color (${expectColor.value.toRadixString(16)})');
  });
}
