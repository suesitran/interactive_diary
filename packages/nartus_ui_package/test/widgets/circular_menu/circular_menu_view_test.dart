import 'package:flutter_test/flutter_test.dart';
import 'package:nartus_ui_package/nartus_ui.dart';

import '../../widget_tester_extension.dart';

void main() {
  testWidgets(
    'When add circular menu to a screen, it is visible',
    (WidgetTester widgetTester) async {
      final IDCircularMenuController controller = IDCircularMenuController();
      IDCircularMenuView menu = IDCircularMenuView(
        items: <IDCircularMenuItemData>[
          IDCircularMenuItemData(
            item: const Icon(Icons.call),
            onPressed: () {},
            degree: 210
          ),
        ],
        controller: controller,
      );

      await widgetTester.wrapMaterialAndPump(menu);

      expect(find.byType(IDCircularMenuView), findsOneWidget);
      expect(find.byType(Icon), findsOneWidget);
    });

  testWidgets(
    'When open menu, the coordinate of icon will different',
        (WidgetTester widgetTester) async {
      final GlobalKey iconKey = GlobalKey();
      final IDCircularMenuController controller = IDCircularMenuController();
      IDCircularMenuView menu = IDCircularMenuView(
        items: <IDCircularMenuItemData>[
          IDCircularMenuItemData(
            item: Icon(Icons.call, key: iconKey,),
            onPressed: () {},
            degree: 210
          ),
        ],
        controller: controller,
      );

      await widgetTester.wrapMaterialAndPump(menu);

      final RenderBox renderBox = iconKey.currentContext
          ?.findRenderObject() as RenderBox;
      Offset beforePosition = renderBox.localToGlobal(Offset.zero);

      controller.open();
      await widgetTester.pumpAndSettle();

      Offset afterPosition = renderBox.localToGlobal(Offset.zero);

      expect(beforePosition.dx != afterPosition.dx, true);
      expect(beforePosition.dy != afterPosition.dy, true);
      expect((afterPosition - beforePosition).distance > 0, true);
    });

  testWidgets(
    'When open menu then close menu, the coordinate of icon will the same',
        (WidgetTester widgetTester) async {
      final GlobalKey iconKey = GlobalKey();
      final IDCircularMenuController controller = IDCircularMenuController();
      IDCircularMenuView menu = IDCircularMenuView(
        items: <IDCircularMenuItemData>[
          IDCircularMenuItemData(
            item: Icon(Icons.call, key: iconKey,),
            onPressed: () {},
            degree: 210
          ),
        ],
        controller: controller,
      );

      await widgetTester.wrapMaterialAndPump(menu);

      final RenderBox renderBox = iconKey.currentContext
          ?.findRenderObject() as RenderBox;
      Offset beforePosition = renderBox.localToGlobal(Offset.zero);

      controller.open();
      await widgetTester.pumpAndSettle();

      controller.close();
      await widgetTester.pumpAndSettle();

      Offset afterPosition = renderBox.localToGlobal(Offset.zero);

      expect(beforePosition.dx == afterPosition.dx, true);
      expect(beforePosition.dy == afterPosition.dy, true);
      expect((afterPosition - beforePosition).distance == 0, true);
    });
}