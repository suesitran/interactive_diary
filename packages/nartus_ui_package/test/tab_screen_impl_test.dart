import 'package:flutter/cupertino.dart' show CupertinoApp, CupertinoTabScaffold;
import 'package:flutter_test/flutter_test.dart';
import 'package:nartus_ui_package/nartus_ui.dart';
import 'package:flutter/material.dart'
    show FloatingActionButton, Icons, MaterialApp, Scaffold;

part 'tab_screen_test_data.dart';

void main() {
  group('Test tab screen blank', () {
    testWidgets(
        'When OS is iOS and no floating button, show Cupertino Tab scaffold without floating button',
        (WidgetTester tester) async {
      debugDefaultTargetPlatformOverride = TargetPlatform.iOS;

      final screen = CupertinoApp(
        builder: (context, widget) => widget ?? const TestTabScreenBlank(),
      );

      await tester.pumpWidget(screen);
      await tester.pumpAndSettle();

      expect(find.byType(CupertinoTabScaffold), findsOneWidget);
      expect(find.byType(FloatingActionButton), findsNothing);

      // check that page 1 is currently showing
      expect(find.text('Page 1'), findsOneWidget);

      // navigate to page 2
      await tester.tap(find.byIcon(Icons.settings));
      await tester.pump();

      // check that page 2 is currently showing
      expect(find.text('Page 2'), findsOneWidget);

      debugDefaultTargetPlatformOverride = null;
    });

    testWidgets(
        'When OS is android without floating button, show Material scaffold without floating button',
        (WidgetTester widgetTester) async {
      debugDefaultTargetPlatformOverride = TargetPlatform.android;

      const screen = MaterialApp(
        home: TestTabScreenBlank(),
      );

      await widgetTester.pumpWidget(screen);
      await widgetTester.pumpAndSettle();

      expect(find.byType(Scaffold), findsOneWidget);
      expect(find.byType(FloatingActionButton), findsNothing);

      debugDefaultTargetPlatformOverride = null;
    });

    testWidgets(
        'When OS is android with floating button, show Material scaffold with floating button',
        (widgetTester) async {
      debugDefaultTargetPlatformOverride = TargetPlatform.android;

      const screen = MaterialApp(
        home: TestTabScreenWithFloatingButton(),
      );

      await widgetTester.pumpWidget(screen);
      await widgetTester.pumpAndSettle();

      expect(find.byType(Scaffold), findsOneWidget);
      expect(find.text('Page 1'), findsOneWidget);
      expect(find.byType(FloatingActionButton), findsOneWidget);

      debugDefaultTargetPlatformOverride = null;
    });

    testWidgets(
        'When OS is windows without floating button, show Material scaffold without floating button',
        (widgetTester) async {
      debugDefaultTargetPlatformOverride = TargetPlatform.windows;

      const screen = MaterialApp(
        home: TestTabScreenBlank(),
      );

      await widgetTester.pumpWidget(screen);
      await widgetTester.pumpAndSettle();

      expect(find.byType(Scaffold), findsOneWidget);
      expect(find.text('Page 1'), findsOneWidget);
      expect(find.byType(FloatingActionButton), findsNothing);

      debugDefaultTargetPlatformOverride = null;
    });
  });

  group('Test tab screen with floating button', () {
    testWidgets(
        'When OS is iOS with floating button, show Cupertino Tab scaffold with floating button',
        (widgetTester) async {
      debugDefaultTargetPlatformOverride = TargetPlatform.iOS;

      final screen = CupertinoApp(
        builder: (context, widget) =>
            widget ?? const TestTabScreenWithFloatingButton(),
      );

      await widgetTester.pumpWidget(screen);
      await widgetTester.pumpAndSettle();

      expect(find.byType(CupertinoTabScaffold), findsOneWidget);
      expect(find.byType(FloatingActionButton), findsOneWidget);

      // check that page 1 is currently showing
      expect(find.text('Page 1'), findsOneWidget);

      // navigate to page 2
      await widgetTester.tap(find.byIcon(Icons.settings));
      await widgetTester.pump();

      // check that page 2 is currently showing
      expect(find.text('Page 2'), findsOneWidget);

      debugDefaultTargetPlatformOverride = null;
    });

    testWidgets(
        'When OS is windows with floating button, show Material scaffold with floating button',
        (widgetTester) async {
      debugDefaultTargetPlatformOverride = TargetPlatform.windows;

      const screen = MaterialApp(
        home: TestTabScreenWithFloatingButton(),
      );

      await widgetTester.pumpWidget(screen);
      await widgetTester.pumpAndSettle();

      expect(find.byType(Scaffold), findsOneWidget);
      expect(find.text('Page 1'), findsOneWidget);
      expect(find.byType(FloatingActionButton), findsOneWidget);

      debugDefaultTargetPlatformOverride = null;
    });
  });

  group('Test padding and alignment of floating button in iOS', () {
    testWidgets('when OS is iOS, and floating button is startTop',
        (widgetTester) async {
      debugDefaultTargetPlatformOverride = TargetPlatform.iOS;

      const screen = CupertinoApp(
        home: TestTabScreenWithFloatingButton(
          floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
        ),
      );

      await widgetTester.pumpWidget(screen);
      await widgetTester.pumpAndSettle();

      expect(find.byType(FloatingActionButton), findsOneWidget);

      // get container to check alignment and padding
      Container container = widgetTester.widget(find.descendant(
          of: find.byType(Stack),
          matching: find.ancestor(
              of: find.byType(FloatingActionButton),
              matching: find.byType(Container))));
      expect(container.padding, const EdgeInsets.only(left: 25));
      expect(container.alignment, Alignment.topLeft);

      debugDefaultTargetPlatformOverride = null;
    });

    testWidgets('when OS is iOS, and floating button is centerTop',
        (widgetTester) async {
      debugDefaultTargetPlatformOverride = TargetPlatform.iOS;

      const screen = CupertinoApp(
        home: TestTabScreenWithFloatingButton(
          floatingActionButtonLocation: FloatingActionButtonLocation.centerTop,
        ),
      );

      await widgetTester.pumpWidget(screen);
      await widgetTester.pumpAndSettle();

      expect(find.byType(FloatingActionButton), findsOneWidget);

      // get container to check alignment and padding
      Container container = widgetTester.widget(find.descendant(
          of: find.byType(Stack),
          matching: find.ancestor(
              of: find.byType(FloatingActionButton),
              matching: find.byType(Container))));
      expect(container.padding, EdgeInsets.zero);
      expect(container.alignment, Alignment.topCenter);

      debugDefaultTargetPlatformOverride = null;
    });

    testWidgets('when OS is iOS, and floating button is endTop',
        (widgetTester) async {
      debugDefaultTargetPlatformOverride = TargetPlatform.iOS;

      const screen = CupertinoApp(
        home: TestTabScreenWithFloatingButton(
          floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
        ),
      );

      await widgetTester.pumpWidget(screen);
      await widgetTester.pumpAndSettle();

      expect(find.byType(FloatingActionButton), findsOneWidget);

      // get container to check alignment and padding
      Container container = widgetTester.widget(find.descendant(
          of: find.byType(Stack),
          matching: find.ancestor(
              of: find.byType(FloatingActionButton),
              matching: find.byType(Container))));
      expect(container.padding, const EdgeInsets.only(right: 25));
      expect(container.alignment, Alignment.topRight);

      debugDefaultTargetPlatformOverride = null;
    });

    testWidgets('when OS is iOS, and floating button is startDocked',
        (widgetTester) async {
      debugDefaultTargetPlatformOverride = TargetPlatform.iOS;

      const screen = CupertinoApp(
        home: TestTabScreenWithFloatingButton(
          floatingActionButtonLocation:
              FloatingActionButtonLocation.startDocked,
        ),
      );

      await widgetTester.pumpWidget(screen);
      await widgetTester.pumpAndSettle();

      expect(find.byType(FloatingActionButton), findsOneWidget);

      // get container to check alignment and padding
      Container container = widgetTester.widget(find.descendant(
          of: find.byType(Stack),
          matching: find.ancestor(
              of: find.byType(FloatingActionButton),
              matching: find.byType(Container))));
      expect(container.padding, const EdgeInsets.only(left: 25, bottom: 25));
      expect(container.alignment, Alignment.bottomLeft);

      debugDefaultTargetPlatformOverride = null;
    });

    testWidgets('when OS is iOS, and floating button is centerDocked',
        (widgetTester) async {
      debugDefaultTargetPlatformOverride = TargetPlatform.iOS;

      const screen = CupertinoApp(
        home: TestTabScreenWithFloatingButton(
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
        ),
      );

      await widgetTester.pumpWidget(screen);
      await widgetTester.pumpAndSettle();

      expect(find.byType(FloatingActionButton), findsOneWidget);

      // get container to check alignment and padding
      Container container = widgetTester.widget(find.descendant(
          of: find.byType(Stack),
          matching: find.ancestor(
              of: find.byType(FloatingActionButton),
              matching: find.byType(Container))));
      expect(container.padding, const EdgeInsets.only(bottom: 25));
      expect(container.alignment, Alignment.bottomCenter);

      debugDefaultTargetPlatformOverride = null;
    });

    testWidgets('when OS is iOS, and floating button is endDocked',
        (widgetTester) async {
      debugDefaultTargetPlatformOverride = TargetPlatform.iOS;

      const screen = CupertinoApp(
        home: TestTabScreenWithFloatingButton(
          floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
        ),
      );

      await widgetTester.pumpWidget(screen);
      await widgetTester.pumpAndSettle();

      expect(find.byType(FloatingActionButton), findsOneWidget);

      // get container to check alignment and padding
      Container container = widgetTester.widget(find.descendant(
          of: find.byType(Stack),
          matching: find.ancestor(
              of: find.byType(FloatingActionButton),
              matching: find.byType(Container))));
      expect(container.padding, const EdgeInsets.only(right: 25, bottom: 25));
      expect(container.alignment, Alignment.bottomRight);

      debugDefaultTargetPlatformOverride = null;
    });

    testWidgets('when OS is iOS, and floating button is startFloat',
        (widgetTester) async {
      debugDefaultTargetPlatformOverride = TargetPlatform.iOS;

      const screen = CupertinoApp(
        home: TestTabScreenWithFloatingButton(
          floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
        ),
      );

      await widgetTester.pumpWidget(screen);
      await widgetTester.pumpAndSettle();

      expect(find.byType(FloatingActionButton), findsOneWidget);

      // get container to check alignment and padding
      Container container = widgetTester.widget(find.descendant(
          of: find.byType(Stack),
          matching: find.ancestor(
              of: find.byType(FloatingActionButton),
              matching: find.byType(Container))));
      expect(container.padding, const EdgeInsets.only(left: 25, bottom: 75));
      expect(container.alignment, Alignment.bottomLeft);

      debugDefaultTargetPlatformOverride = null;
    });

    testWidgets('when OS is iOS, and floating button is centerFloat',
        (widgetTester) async {
      debugDefaultTargetPlatformOverride = TargetPlatform.iOS;

      const screen = CupertinoApp(
        home: TestTabScreenWithFloatingButton(
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
        ),
      );

      await widgetTester.pumpWidget(screen);
      await widgetTester.pumpAndSettle();

      expect(find.byType(FloatingActionButton), findsOneWidget);

      // get container to check alignment and padding
      Container container = widgetTester.widget(find.descendant(
          of: find.byType(Stack),
          matching: find.ancestor(
              of: find.byType(FloatingActionButton),
              matching: find.byType(Container))));
      expect(container.padding, const EdgeInsets.only(bottom: 75));
      expect(container.alignment, Alignment.bottomCenter);

      debugDefaultTargetPlatformOverride = null;
    });

    testWidgets('when OS is iOS, and floating button is endFloat',
        (widgetTester) async {
      debugDefaultTargetPlatformOverride = TargetPlatform.iOS;

      const screen = CupertinoApp(
        home: TestTabScreenWithFloatingButton(
          floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        ),
      );

      await widgetTester.pumpWidget(screen);
      await widgetTester.pumpAndSettle();

      expect(find.byType(FloatingActionButton), findsOneWidget);

      // get container to check alignment and padding
      Container container = widgetTester.widget(find.descendant(
          of: find.byType(Stack),
          matching: find.ancestor(
              of: find.byType(FloatingActionButton),
              matching: find.byType(Container))));
      expect(container.padding, const EdgeInsets.only(right: 25, bottom: 75));
      expect(container.alignment, Alignment.bottomRight);

      debugDefaultTargetPlatformOverride = null;
    });
  });
}
