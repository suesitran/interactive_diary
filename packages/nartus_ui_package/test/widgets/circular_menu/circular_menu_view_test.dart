import 'package:flutter_test/flutter_test.dart';
import 'package:nartus_ui_package/nartus_ui.dart';

void main() {
  testWidgets(
    'When fire open menu from controller, all menu item will be shown on the screen',
    (widgetTester) async {
      final IDCircularMenuController controller = IDCircularMenuController();
      IDCircularMenuView menu = IDCircularMenuView(
        items: [
          IDCircularMenuItemData(
            TextButton()
          ),
        ], controller: controller,);


      await widgetTester.wrapMaterialAndPump(label);

      expect(find.text('Text Label'), findsOneWidget);
    });
}