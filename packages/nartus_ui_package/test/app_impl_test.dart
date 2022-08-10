import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nartus_ui_package/nartus_ui.dart';

void main() {
  group('Test adaptive constructor', () {
    testWidgets('When platform is iOS, use CupertinoApp',
        (WidgetTester tester) async {
      debugDefaultTargetPlatformOverride = TargetPlatform.iOS;

      const app = App.adaptive(
          home: Center(
        child: Text('Hello'),
      ));

      await tester.pumpWidget(app);
      await tester.pumpAndSettle();

      expect(find.byType(CupertinoApp), findsOneWidget);
      expect(find.byType(MaterialApp), findsNothing);

      debugDefaultTargetPlatformOverride = null;
    });

    testWidgets('When platform is Android, use MaterialApp',
        (WidgetTester tester) async {
      debugDefaultTargetPlatformOverride = TargetPlatform.android;

      const app = App.adaptive(
          home: Center(
        child: Text('Hello'),
      ));

      await tester.pumpWidget(app);
      await tester.pumpAndSettle();

      expect(find.byType(MaterialApp), findsOneWidget);
      expect(find.byType(CupertinoApp), findsNothing);

      debugDefaultTargetPlatformOverride = null;
    });
  });

  group('Test platform specific constructor', () {
    testWidgets('Material constructor will build MaterialApp',
        (widgetTester) async {
      const app = App.material(
          home: Center(
        child: Text('Hello'),
      ));

      await widgetTester.pumpWidget(app);
      await widgetTester.pumpAndSettle();

      expect(find.byType(MaterialApp), findsOneWidget);
      expect(find.byType(CupertinoApp), findsNothing);
    });

    testWidgets('Cupertino constructor will build CupertinoApp',
        (widgetTester) async {
      const app = App.cupertino(
          home: Center(
        child: Text('Hello'),
      ));

      await widgetTester.pumpWidget(app);
      await widgetTester.pumpAndSettle();

      expect(find.byType(MaterialApp), findsNothing);
      expect(find.byType(CupertinoApp), findsOneWidget);
    });
  });
}
