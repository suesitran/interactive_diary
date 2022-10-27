import 'package:flutter_test/flutter_test.dart';
import 'package:nartus_ui_package/nartus_ui.dart';

void main() {
  test('When create menu item object, each property will be same type of what specified', () {
    final IDCircularMenuItemData data = IDCircularMenuItemData(
      item: const Icon(Icons.close), degree: 210, onPressed: () {}
    );
    expect(data.item, isA<Icon>());
    expect(data.degree, 210);
    expect(data.onPressed, isA<Function>());
  });
}