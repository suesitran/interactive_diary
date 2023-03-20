import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:interactive_diary/features/writediary/widgets/advance_text_editor_view.dart';

import '../../../widget_tester_extension.dart';

void main() {
  final ColorPickerController controller = ColorPickerController();

  testWidgets('verify ColorPickerBar in default state', (widgetTester) async {
    final Widget widget = ColorPickerBar(controller: controller);

    await widgetTester.wrapAndPump(widget);

    // verify height
    expect(find.byType(SizedBox), findsOneWidget);

    // verify that SizeTransition default at 0.0
    expect(find.byType(SizeTransition), findsOneWidget);
    SizeTransition sizeTransition =
        widgetTester.widget(find.byType(SizeTransition));
    expect(sizeTransition.sizeFactor.value, 0.0);

    expect(find.byType(GestureDetector), findsOneWidget);
  });

  testWidgets('verify ColorPickerBar in show state', (widgetTester) async {
    final Widget widget = ColorPickerBar(controller: controller);

    await widgetTester.wrapAndPump(widget);

    controller.show();
    await widgetTester.pumpAndSettle(const Duration(milliseconds: 300));

    expect(find.byType(SizeTransition), findsOneWidget);
    SizeTransition sizeTransition =
        widgetTester.widget(find.byType(SizeTransition));
    expect(sizeTransition.sizeFactor.value, 1.0);
  });

  testWidgets('verify ColorPickerBar in hide state', (widgetTester) async {
    final Widget widget = ColorPickerBar(controller: controller);

    await widgetTester.wrapAndPump(widget);

    controller.show();
    await widgetTester.pumpAndSettle(const Duration(milliseconds: 300));

    controller.hide();
    await widgetTester.pumpAndSettle(const Duration(milliseconds: 300));

    expect(find.byType(SizeTransition), findsOneWidget);
    SizeTransition sizeTransition =
        widgetTester.widget(find.byType(SizeTransition));
    expect(sizeTransition.sizeFactor.value, 0.0);
  });

  testWidgets('verify thumb in ColorPickerBar in default state',
      (widgetTester) async {
    final Widget widget = ColorPickerBar(controller: controller);

    await widgetTester.wrapAndPump(widget);

    expect(
        find.descendant(
            of: find.byType(LayoutBuilder), matching: find.byType(CustomPaint)),
        findsOneWidget);

    CustomPaint customPaint = widgetTester.widget(find.descendant(
        of: find.byType(LayoutBuilder), matching: find.byType(CustomPaint)));

    expect(customPaint.painter, isA<ThumbHandlePainter>());

    ThumbHandlePainter painter = customPaint.painter as ThumbHandlePainter;

    expect(painter.position, 0.0);
  });

  testWidgets('verify ColorPickerBar in thumb move when tap action happens',
      (widgetTester) async {
    final Widget widget = ColorPickerBar(controller: controller);

    await widgetTester.wrapAndPump(widget);

    controller.show();
    await widgetTester.pumpAndSettle(const Duration(milliseconds: 500));

    expect(find.byType(SizeTransition), findsOneWidget);
    SizeTransition sizeTransition =
        widgetTester.widget(find.byType(SizeTransition));
    expect(sizeTransition.sizeFactor.value, 1.0);

    await widgetTester.tapAt(const Offset(15, 10));
    await widgetTester.pumpAndSettle(const Duration(milliseconds: 500));

    CustomPaint customPaint = widgetTester.widget(find.descendant(
        of: find.byType(LayoutBuilder), matching: find.byType(CustomPaint)));
    expect(customPaint.painter, isA<ThumbHandlePainter>());

    ThumbHandlePainter painter = customPaint.painter as ThumbHandlePainter;

    expect(painter.position, 15.0);
  });

  testWidgets('verify ColorPickerBar in thumb move when drag action happens',
      (widgetTester) async {
    final Widget widget = ColorPickerBar(controller: controller);

    await widgetTester.wrapAndPump(widget);

    controller.show();
    await widgetTester.pumpAndSettle(const Duration(milliseconds: 500));

    expect(find.byType(SizeTransition), findsOneWidget);
    SizeTransition sizeTransition =
        widgetTester.widget(find.byType(SizeTransition));
    expect(sizeTransition.sizeFactor.value, 1.0);

    await widgetTester.dragFrom(const Offset(15, 10), const Offset(150, 10));
    await widgetTester.pumpAndSettle(const Duration(milliseconds: 500));

    CustomPaint customPaint = widgetTester.widget(find.descendant(
        of: find.byType(LayoutBuilder), matching: find.byType(CustomPaint)));
    expect(customPaint.painter, isA<ThumbHandlePainter>());

    ThumbHandlePainter painter = customPaint.painter as ThumbHandlePainter;

    expect(painter.position, 165.0);
  });
}
