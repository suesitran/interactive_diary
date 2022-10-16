import 'package:flutter_test/flutter_test.dart';
import 'package:nartus_ui_package/nartus_ui.dart';

void main() {
  test('Validate all theme color', () {
    // brightness is light
    expect(lightTheme.brightness, Brightness.light);
    // bottom app bar color is default light - white
    expect(lightTheme.bottomAppBarColor, const Color(0xffffffff));
    // theme color dark is swatch 700
    expect(lightTheme.primaryColorDark, const Color(0xFF648CBE));
    // theme color light is swatch 100
    expect(lightTheme.primaryColorLight, const Color(0xFFD6E2EF));
    // background color is swatch 200
    expect(lightTheme.backgroundColor, const Color(0xFFFFFFFF));

    // error color is dark red
    expect(lightTheme.errorColor, const Color(0xFF8B0101));
  });
}
