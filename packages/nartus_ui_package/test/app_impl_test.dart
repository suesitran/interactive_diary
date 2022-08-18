import 'package:flutter/cupertino.dart' show CupertinoApp;
import 'package:flutter/material.dart' show MaterialApp, Brightness;
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

      expect(find.text('Hello'), findsOneWidget);

      debugDefaultTargetPlatformOverride = null;
    });

    testWidgets('When platform is iOS, check details of CupertinoApp',
        (widgetTester) async {
      debugDefaultTargetPlatformOverride = TargetPlatform.iOS;

      const app = App.adaptive(
        title: 'Title',
        home: Center(
          child: Text('Hello'),
        ),
        theme: Theme(
            primaryColor: Colors.deepOrange, brightness: Brightness.light),
        darkTheme:
            Theme(primaryColor: Colors.deepOrange, brightness: Brightness.dark),
      );

      await widgetTester.pumpWidget(app);
      await widgetTester.pumpAndSettle();

      // CupertinoApp is found
      expect(find.byType(CupertinoApp), findsOneWidget);
      expect(find.text('Hello'), findsOneWidget);

      final CupertinoApp cupertinoApp =
          widgetTester.widget(find.byType(CupertinoApp));

      // title is 'Title'
      expect(cupertinoApp.title, 'Title');
      // light theme is used
      expect(cupertinoApp.theme?.primaryColor, Colors.deepOrange);
      expect(cupertinoApp.theme?.brightness, Brightness.light);

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

      expect(find.text('Hello'), findsOneWidget);

      debugDefaultTargetPlatformOverride = null;
    });

    testWidgets('When platform is Android, check details of MaterialApp',
        (widgetTester) async {
      debugDefaultTargetPlatformOverride = TargetPlatform.android;

      const app = App.adaptive(
        title: 'Title',
        home: Center(
          child: Text('Hello'),
        ),
        theme: Theme(
            primaryColor: Colors.deepOrange, brightness: Brightness.light),
        darkTheme:
            Theme(primaryColor: Colors.deepOrange, brightness: Brightness.dark),
      );

      await widgetTester.pumpWidget(app);
      await widgetTester.pumpAndSettle();

      // CupertinoApp is found
      expect(find.byType(MaterialApp), findsOneWidget);
      expect(find.text('Hello'), findsOneWidget);

      final MaterialApp materialApp =
          widgetTester.widget(find.byType(MaterialApp));

      // title is 'Title'
      expect(materialApp.title, 'Title');
      // light theme is used
      expect(materialApp.theme?.primaryColor, Colors.deepOrange);
      expect(materialApp.theme?.brightness, Brightness.light);
      expect(materialApp.darkTheme?.brightness, Brightness.dark);

      debugDefaultTargetPlatformOverride = null;
    });
  });

  group('Test platform specific constructor', () {
    testWidgets('Material constructor will build MaterialApp',
        (widgetTester) async {
      const app = App.material(
          title: 'Title',
          home: Center(
            child: Text('Hello'),
          ));

      await widgetTester.pumpWidget(app);
      await widgetTester.pumpAndSettle();

      expect(find.byType(MaterialApp), findsOneWidget);
      expect(find.byType(CupertinoApp), findsNothing);

      expect(find.text('Hello'), findsOneWidget);

      MaterialApp materialApp = widgetTester.widget(find.byType(MaterialApp));
      expect(materialApp.title, 'Title');
    });

    testWidgets('Cupertino constructor will build CupertinoApp',
        (widgetTester) async {
      const app = App.cupertino(
          title: 'Title',
          home: Center(
            child: Text('Hello'),
          ));

      await widgetTester.pumpWidget(app);
      await widgetTester.pumpAndSettle();

      expect(find.byType(MaterialApp), findsNothing);
      expect(find.byType(CupertinoApp), findsOneWidget);

      expect(find.text('Hello'), findsOneWidget);

      CupertinoApp cupertinoApp =
          widgetTester.widget(find.byType(CupertinoApp));
      expect(cupertinoApp.title, 'Title');
    });
  });
}
