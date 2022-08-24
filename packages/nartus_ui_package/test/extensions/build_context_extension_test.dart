import 'package:flutter/cupertino.dart' show CupertinoAlertDialog;
import 'package:flutter/material.dart' show AlertDialog;
import 'package:flutter_test/flutter_test.dart';
import 'package:nartus_ui_package/nartus_ui.dart';
import '../widget_tester_extension.dart';

void main() {
  testWidgets(
      'given platform is iOS, when showDialogAdaptive, then show CupertinoAlertDialog',
      (widgetTester) async {
    debugDefaultTargetPlatformOverride = TargetPlatform.iOS;

    int counter = 0;

    Widget builder = Builder(
      builder: (BuildContext context) {
        context.showDialogAdaptive(
            title: const Text('Title'),
            content: const Center(
              child: Text('Content'),
            ),
            actions: [TextButton(onPressed: () {
              counter++;
            }, child: Text('Action'))]);
        return Container();
      },
    );

    await widgetTester.wrapCupertinoAndPump(builder);

    expect(find.byType(CupertinoAlertDialog), findsOneWidget);

    // test action
    await widgetTester.tap(find.text('Action'));

    expect(counter, 1);

    debugDefaultTargetPlatformOverride = null;
  });

  testWidgets('given platform is Android, when showDialogAdaptive, then show MaterialAlertDialog', (widgetTester) async {
    debugDefaultTargetPlatformOverride = TargetPlatform.android;

    int counter = 0;

    Widget builder = Builder(
      builder: (BuildContext context) {
        context.showDialogAdaptive(
            title: const Text('Title'),
            content: const Center(
              child: Text('Content'),
            ),
            actions: [TextButton(onPressed: () {
              counter++;
            }, child: Text('Action'))]);
        return Container();
      },
    );

    await widgetTester.wrapMaterialAndPump(builder);

    expect(find.byType(AlertDialog), findsOneWidget);

    // test action
    await widgetTester.tap(find.text('Action'));

    expect(counter, 1);

    debugDefaultTargetPlatformOverride = null;
  });
}
