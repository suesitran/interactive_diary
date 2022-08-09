import 'package:flutter/cupertino.dart' show CupertinoApp, CupertinoTabScaffold;
import 'package:flutter_test/flutter_test.dart';
import 'package:nartus_ui_package/nartus_ui.dart';
import 'package:flutter/material.dart'
    show FloatingActionButton, Icons, MaterialApp, Scaffold;

class TestTabScreenWithoutFloatingButton extends TabScreen {
  const TestTabScreenWithoutFloatingButton({Key? key}) : super(key: key);

  @override
  List<TabScreenContent> buildTabScreenContent() => [
        TabScreenContent(
            const BottomNavigationBarItem(
                label: 'Home', icon: Icon(Icons.home)),
            const Center(
              child: Text('Page 1'),
            )),
        TabScreenContent(
            const BottomNavigationBarItem(
                icon: Icon(Icons.settings), label: 'Settings'),
            const Center(child: Text('Page 2')))
      ];
}

class TestTabScreenWithFloatingButton extends TabScreen {
  const TestTabScreenWithFloatingButton({Key? key}) : super(key: key);

  @override
  List<TabScreenContent> buildTabScreenContent() => [
        TabScreenContent(
            const BottomNavigationBarItem(
                label: 'Home', icon: Icon(Icons.home)),
            const Center(
              child: Text('Page 1'),
            )),
        TabScreenContent(
            const BottomNavigationBarItem(
                icon: Icon(Icons.settings), label: 'Settings'),
            const Center(child: Text('Page 2')))
      ];

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
      'When OS is iOS and no floating button, show Cupertino Tab scaffold without floating button',
      (WidgetTester tester) async {
    debugDefaultTargetPlatformOverride = TargetPlatform.iOS;

    final screen = CupertinoApp(
      builder: (context, widget) =>
          widget ?? const TestTabScreenWithoutFloatingButton(),
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
      'When OS is android without floating button, show Material scaffold without floating button',
      (WidgetTester widgetTester) async {
    debugDefaultTargetPlatformOverride = TargetPlatform.android;

    const screen = MaterialApp(
      home: TestTabScreenWithoutFloatingButton(),
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
      home: TestTabScreenWithoutFloatingButton(),
    );

    await widgetTester.pumpWidget(screen);
    await widgetTester.pumpAndSettle();

    expect(find.byType(Scaffold), findsOneWidget);
    expect(find.text('Page 1'), findsOneWidget);
    expect(find.byType(FloatingActionButton), findsNothing);

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
}
