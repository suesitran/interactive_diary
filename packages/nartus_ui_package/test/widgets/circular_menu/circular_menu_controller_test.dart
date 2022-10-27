import 'package:flutter_test/flutter_test.dart';
import 'package:nartus_ui_package/nartus_ui.dart';

void main() {

  late IDCircularMenuController controller;

  setUpAll(() {
    controller = IDCircularMenuController();
  });

  tearDownAll(() {
    controller.dispose();
  });

  test('When call open() function, the isShowing var will be true', () {
    controller.open();
    expect(controller.isShowing, true);
  });

  test('When call close() function, the isShowing var will be false', () {
    controller.open();
    controller.close();
    expect(controller.isShowing, false);
  });

  test('When create controller with initial value, the isShowing var will be equal to initial value', () {
    controller = IDCircularMenuController(isShowing: true);
    expect(controller.isShowing, true);

    controller = IDCircularMenuController(isShowing: false);
    expect(controller.isShowing, false);
  });

  test('When create controller with no initial value, the isShowing var will be false', () {
    expect(controller.isShowing, false);
  });


}