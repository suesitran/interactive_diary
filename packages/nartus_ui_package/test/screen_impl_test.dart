import 'package:flutter/cupertino.dart'
    show CupertinoApp, CupertinoPageScaffold;
import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nartus_ui_package/nartus_ui.dart';
import 'package:flutter/material.dart' show MaterialApp, Scaffold;

class TestScreenWithoutFloatingButton extends Screen {
  const TestScreenWithoutFloatingButton({Key? key}) : super(key: key);

  @override
  Widget body(BuildContext context) => const Center(
        child: Text('Sample Test'),
      );
}

class TestScreenWithFloatingButton extends Screen {
  const TestScreenWithFloatingButton({Key? key}) : super(key: key);

  @override
  Widget body(BuildContext context) => const Center(
        child: Text('Sample Test'),
      );

  @override
  FloatingActionButtonConfig? floatingActionButtonConfig(BuildContext context) {
    return FloatingActionButtonConfig(
        button: FloatingActionButton(
      onPressed: () {},
      child: const Icon(Icons.ac_unit),
    ));
  }

  @override
  List<ScreenAction>? appBarActions(BuildContext context) =>
      <ScreenAction>[ScreenAction(onPress: () {}, label: 'Action')];

  @override
  String? title(BuildContext context) => 'Title';
}

void main() {
  testWidgets(
      'When OS is iOS and no floating button, show Cupertino page scaffold without floating button',
      (widgetTester) async {
    debugDefaultTargetPlatformOverride = TargetPlatform.iOS;

    final screen = CupertinoApp(
      builder: (context, widget) =>
          widget ?? const TestScreenWithoutFloatingButton(),
    );

    await widgetTester.pumpWidget(screen);
    await widgetTester.pumpAndSettle();

    expect(find.byType(CupertinoPageScaffold), findsOneWidget);
    expect(find.text('Sample Test'), findsOneWidget);
    expect(find.byType(FloatingActionButton), findsNothing);

    debugDefaultTargetPlatformOverride = null;
  });

  testWidgets(
      'When OS is iOS with floating button, show Cupertino page scaffold with floating button',
      (widgetTester) async {
    debugDefaultTargetPlatformOverride = TargetPlatform.iOS;

    final screen = CupertinoApp(
      builder: (context, widget) =>
          widget ?? const TestScreenWithFloatingButton(),
    );

    await widgetTester.pumpWidget(screen);
    await widgetTester.pumpAndSettle();

    expect(find.byType(CupertinoPageScaffold), findsOneWidget);
    expect(find.text('Sample Test'), findsOneWidget);
    expect(find.byType(FloatingActionButton), findsOneWidget);

    debugDefaultTargetPlatformOverride = null;
  });

  testWidgets(
      'When OS is android without floating button, show Material scaffold without floating button',
      (widgetTester) async {
    debugDefaultTargetPlatformOverride = TargetPlatform.android;

    const screen = MaterialApp(
      home: TestScreenWithoutFloatingButton(),
    );

    await widgetTester.pumpWidget(screen);
    await widgetTester.pumpAndSettle();

    expect(find.byType(Scaffold), findsOneWidget);
    expect(find.text('Sample Test'), findsOneWidget);
    expect(find.byType(FloatingActionButton), findsNothing);

    debugDefaultTargetPlatformOverride = null;
  });

  testWidgets(
      'When OS is android with floating button, show Material scaffold with floating button',
      (widgetTester) async {
    debugDefaultTargetPlatformOverride = TargetPlatform.android;

    const screen = MaterialApp(
      home: TestScreenWithFloatingButton(),
    );

    await widgetTester.pumpWidget(screen);
    await widgetTester.pumpAndSettle();

    expect(find.byType(Scaffold), findsOneWidget);
    expect(find.text('Sample Test'), findsOneWidget);
    expect(find.byType(FloatingActionButton), findsOneWidget);

    debugDefaultTargetPlatformOverride = null;
  });

  testWidgets(
      'When OS is windows without floating button, show Material scaffold without floating button',
      (widgetTester) async {
    debugDefaultTargetPlatformOverride = TargetPlatform.windows;

    const screen = MaterialApp(
      home: TestScreenWithoutFloatingButton(),
    );

    await widgetTester.pumpWidget(screen);
    await widgetTester.pumpAndSettle();

    expect(find.byType(Scaffold), findsOneWidget);
    expect(find.text('Sample Test'), findsOneWidget);
    expect(find.byType(FloatingActionButton), findsNothing);

    debugDefaultTargetPlatformOverride = null;
  });

  testWidgets(
      'When OS is windows with floating button, show Material scaffold with floating button',
      (widgetTester) async {
    debugDefaultTargetPlatformOverride = TargetPlatform.windows;

    const screen = MaterialApp(
      home: TestScreenWithFloatingButton(),
    );

    await widgetTester.pumpWidget(screen);
    await widgetTester.pumpAndSettle();

    expect(find.byType(Scaffold), findsOneWidget);
    expect(find.text('Sample Test'), findsOneWidget);
    expect(find.byType(FloatingActionButton), findsOneWidget);

    debugDefaultTargetPlatformOverride = null;
  });
}
