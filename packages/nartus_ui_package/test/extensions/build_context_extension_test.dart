import 'package:flutter/cupertino.dart' show CupertinoAlertDialog;
import 'package:flutter/material.dart' show AlertDialog;
import 'package:flutter_test/flutter_test.dart';
import 'package:nartus_ui_package/nartus_ui.dart';
import '../widget_tester_extension.dart';

void main() {
  testWidgets(
      'given platform is iOS, when showDialogAdaptive, then show CupertinoAlertDialog',
      (WidgetTester widgetTester) async {
    debugDefaultTargetPlatformOverride = TargetPlatform.iOS;

    int counter = 0;

    Widget builder = Builder(
      builder: (BuildContext context) {
        context.showDialogAdaptive(
            title: const Text('Title'),
            content: const Center(
              child: Text('Content'),
            ),
            actions: <Widget>[
              TextButton(
                  onPressed: () {
                    counter++;
                  },
                  child: const Text('Action'))
            ]);
        return Container();
      },
    );

    await widgetTester.wrapCupertinoAndPump(builder);

    expect(find.byType(CupertinoAlertDialog), findsOneWidget);

    // test action
    CupertinoAlertDialog cupertinoAlertDialog =
        widgetTester.widget(find.byType(CupertinoAlertDialog));

    expect(cupertinoAlertDialog.actions.length, 1);

    await widgetTester.tap(find.text('Action'));

    expect(counter, 1);

    debugDefaultTargetPlatformOverride = null;
  });

  testWidgets(
      'given platform is Android, when showDialogAdaptive, then show MaterialAlertDialog',
      (WidgetTester widgetTester) async {
    debugDefaultTargetPlatformOverride = TargetPlatform.android;

    int counter = 0;

    Widget builder = Builder(
      builder: (BuildContext context) {
        context.showDialogAdaptive(
            title: const Text('Title'),
            content: const Center(
              child: Text('Content'),
            ),
            actions: <Widget>[
              TextButton(
                  onPressed: () {
                    counter++;
                  },
                  child: const Text('Action'))
            ]);
        return Container();
      },
    );

    await widgetTester.wrapMaterialAndPump(builder);

    expect(find.byType(AlertDialog), findsOneWidget);

    // test action
    AlertDialog alertDialog = widgetTester.widget(find.byType(AlertDialog));

    expect(alertDialog.actions?.length, 1);

    await widgetTester.tap(find.text('Action'));

    expect(counter, 1);

    debugDefaultTargetPlatformOverride = null;
  });

  testWidgets(
      'given platform is iOS, when showDialogAdaptive without actions, then show CupertinoAlertDialog without actions',
      (WidgetTester widgetTester) async {
    debugDefaultTargetPlatformOverride = TargetPlatform.iOS;

    Widget builder = Builder(
      builder: (BuildContext context) {
        context.showDialogAdaptive(
          title: const Text('Title'),
          content: const Center(
            child: Text('Content'),
          ),
        );
        return Container();
      },
    );

    await widgetTester.wrapCupertinoAndPump(builder);

    expect(find.byType(CupertinoAlertDialog), findsOneWidget);

    // test action
    CupertinoAlertDialog cupertinoAlertDialog =
        widgetTester.widget(find.byType(CupertinoAlertDialog));

    expect(cupertinoAlertDialog.actions.length, 0);

    debugDefaultTargetPlatformOverride = null;
  });

  testWidgets(
      'given platform is Android, when showDialogAdaptive without actions, then show MaterialAlertDialog without actions',
      (WidgetTester widgetTester) async {
    debugDefaultTargetPlatformOverride = TargetPlatform.android;

    Widget builder = Builder(
      builder: (BuildContext context) {
        context.showDialogAdaptive(
          title: const Text('Title'),
          content: const Center(
            child: Text('Content'),
          ),
        );
        return Container();
      },
    );

    await widgetTester.wrapMaterialAndPump(builder);

    expect(find.byType(AlertDialog), findsOneWidget);

    // test action
    AlertDialog alertDialog = widgetTester.widget(find.byType(AlertDialog));

    expect(alertDialog.actions?.length, 0);

    debugDefaultTargetPlatformOverride = null;
  });
}
