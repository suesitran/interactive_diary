import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nartus_ui_package/nartus_ui.dart';

import '../widget_tester_extension.dart';

void main() {
  group('Test Button UI', () {
    testWidgets('When button is not busy, then show button label',
      (WidgetTester tester) async {

        final IDButton textButton = IDButton(
          text: 'Test button', onPressed: () {});

        await tester.wrapMaterialAndPump(textButton);

        expect(find.byType(IDButton), findsOneWidget);

        expect(find.text('Test button'), findsOneWidget);

      });

    testWidgets('When button is busy, then show loading widget',
      (WidgetTester tester) async {

        final IDButton textButton = IDButton(
          text: 'Test button', onPressed: () {},
          isBusy: true,
        );

        await tester.wrapMaterialAndPump(textButton, infiniteAnimationWidget: true);

        expect(find.byType(IDButton), findsOneWidget);

        expect(find.byType(CircularProgressIndicator), findsOneWidget);

      });

    testWidgets('When button was clicked, then update counter',
      (WidgetTester tester) async {
        int counter = 0;

        final IDButton textButton = IDButton(
          text: 'Test button', onPressed: () => counter++,
        );

        await tester.wrapMaterialAndPump(textButton);

        await tester.tap(find.byWidget(textButton));

        expect(counter, 1);

      });
  });
}