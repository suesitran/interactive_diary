import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nartus_ui_package/nartus_ui.dart';

void main() {
  group('Test platform specific constructor', () {
    late Key kTextField;
    late Key kTextFormField;
    late IDTextField idTextField;
    late IDTextFormField idTextFormField;

    setUp(() {
      kTextField = const Key('TextField');
      kTextFormField = const Key('TextFormField');

      idTextField = IDTextField(key: kTextField);
      idTextFormField = IDTextFormField(key: kTextFormField);
    });

    testWidgets('When platform is Android, then show TextField & TextFormField',
        (WidgetTester widgetTester) async {
      debugDefaultTargetPlatformOverride = TargetPlatform.android;

      await widgetTester.pumpWidget(MaterialApp(
          home: Scaffold(
        body: Column(
          children: <Widget>[idTextField, idTextFormField],
        ),
      )));
      await widgetTester.pumpAndSettle();

      final Finder findMaterialTextField = find.descendant(
          of: find.byKey(kTextField), matching: find.byType(TextField));
      final Finder findMaterialTextFormField = find.descendant(
          of: find.byWidget(idTextFormField),
          matching: find.byType(TextFormField));

      final Finder findCupertinoTextField = find.descendant(
          of: find.byWidget(idTextField),
          matching: find.byType(CupertinoTextField));
      final Finder findCupertinoTextFormField = find.descendant(
          of: find.byWidget(idTextFormField),
          matching: find.byType(CupertinoTextFormFieldRow));

      expect(findMaterialTextField, findsOneWidget);
      expect(findMaterialTextFormField, findsOneWidget);

      expect(findCupertinoTextField, findsNothing);
      expect(findCupertinoTextFormField, findsNothing);

      debugDefaultTargetPlatformOverride = null;
    });

    testWidgets(
        'When platform is IOS, then show CupertinoTextField & CupertinoTextFormFieldRow',
        (WidgetTester widgetTester) async {
      debugDefaultTargetPlatformOverride = TargetPlatform.iOS;

      await widgetTester.pumpWidget(CupertinoApp(
          home: CupertinoPageScaffold(
        child: Column(
          children: <Widget>[idTextField, idTextFormField],
        ),
      )));
      await widgetTester.pumpAndSettle();

      final Finder findMaterialTextField = find.descendant(
          of: find.byWidget(idTextField), matching: find.byType(TextField));
      final Finder findMaterialTextFormField = find.descendant(
          of: find.byKey(kTextFormField), matching: find.byType(TextFormField));

      final Finder findCupertinoTextField = find.descendant(
          of: find.byWidget(idTextField),
          matching: find.byType(CupertinoTextField));
      final Finder findCupertinoTextFormField = find.descendant(
          of: find.byWidget(idTextFormField),
          matching: find.byType(CupertinoTextFormFieldRow));

      expect(findMaterialTextField, findsNothing);
      expect(findMaterialTextFormField, findsNothing);

      expect(findCupertinoTextField, findsOneWidget);
      expect(findCupertinoTextFormField, findsOneWidget);

      debugDefaultTargetPlatformOverride = null;
    });
  });
}
