import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nartus_ui_package/widgets/text_error_label/text_and_error_label.dart';

import '../../widget_tester_extension.dart';

void main() {
  testWidgets(
      'When Text and Error label has only label, then only label is displayed',
      (WidgetTester widgetTester) async {
    TextAndErrorLabel label = const TextAndErrorLabel(label: 'Text Label');

    await widgetTester.wrapMaterialAndPump(label);

    expect(find.text('Text Label'), findsOneWidget);
  });

  testWidgets(
      'When Text and Error label has both text and error, then both Text and error are displayed',
      (WidgetTester widgetTester) async {
    TextAndErrorLabel label = const TextAndErrorLabel(
      label: 'Text Label',
      error: 'Error label',
    );

    await widgetTester.wrapMaterialAndPump(label);

    expect(find.text('Text Label'), findsOneWidget);
    expect(find.text('Error label'), findsOneWidget);
  });

  testWidgets(
      'When Text and Error label has label and error but error is not showed, then Error sizeFactor is 0',
      (WidgetTester widgetTester) async {
    TextAndErrorLabel label = const TextAndErrorLabel(
      label: 'Text Label',
      error: 'Error label',
    );

    await widgetTester.wrapMaterialAndPump(label);

    // find column
    Column column = widgetTester.widget(
        find.descendant(of: find.byType(Card), matching: find.byType(Column)));

    expect(column.children.length, 2);

    // 'Error label' has height 0
    SizeTransition sizeTransition = widgetTester.widget(find.descendant(
        of: find.byType(Column), matching: find.byType(SizeTransition)));

    expect(sizeTransition.sizeFactor.value, 0);
  });

  testWidgets(
      'When Text and Error label has label and error, and error is showed, then Error sizeFactor is 1',
      (WidgetTester widgetTester) async {
    TextAndErrorLabel label = const TextAndErrorLabel(
      label: 'Text label',
      error: 'Error label',
      showError: true,
    );

    await widgetTester.wrapMaterialAndPump(label,
        infiniteAnimationWidget: true);

    // find column
    Column column = widgetTester.widget(
        find.descendant(of: find.byType(Card), matching: find.byType(Column)));

    expect(column.children.length, 2);

    SizeTransition sizeTransition = widgetTester.widget(find.descendant(
        of: find.byType(Column), matching: find.byType(SizeTransition)));

    expect(sizeTransition.sizeFactor.value, 1);
  });
}
