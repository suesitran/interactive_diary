import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nartus_ui_package/nartus_ui.dart';

void main() {
  testWidgets('When platform is iOS, use CupertinoApp', (WidgetTester tester) async {
    debugDefaultTargetPlatformOverride = TargetPlatform.iOS;

    final app = App(home: const Center(child: Text('Hello'),));

    await tester.pumpWidget(app);
    await tester.pumpAndSettle();

    expect(find.byType(CupertinoApp), findsOneWidget);
    expect(find.byType(MaterialApp), findsNothing);

    debugDefaultTargetPlatformOverride = null;
  });

  testWidgets('When platform is Android, use MaterialApp', (WidgetTester tester) async {
    debugDefaultTargetPlatformOverride = TargetPlatform.android;

    final app = App(home: const Center(child: Text('Hello'),));

    await tester.pumpWidget(app);
    await tester.pumpAndSettle();

    expect(find.byType(MaterialApp), findsOneWidget);
    expect(find.byType(CupertinoApp), findsNothing);

    debugDefaultTargetPlatformOverride = null;
  });
}