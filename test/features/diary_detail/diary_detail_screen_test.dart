import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:interactive_diary/features/diary_detail/diary_detail_screen.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:nartus_ui_package/nartus_ui.dart';
import 'package:network_image_mock/network_image_mock.dart';
import 'package:interactive_diary/generated/l10n.dart';

import '../../widget_tester_extension.dart';

void main() {
  initializeDateFormatting();
  testWidgets('verify UI diary detail screen', (widgetTester) async {
    const Widget widget = DiaryDetailScreen();

    await mockNetworkImagesFor(() => widgetTester.wrapAndPump(widget));
    expect(
        find.descendant(
            of: find.byType(AppBar), matching: find.byType(DiaryHeaderAppbar)),
        findsOneWidget);
    expect(
        find.descendant(
            of: find.byType(AppBar), matching: find.byType(NartusButton)),
        findsOneWidget);
    expect(
        find.descendant(
            of: find.byType(Scaffold), matching: find.byType(QuillEditor)),
        findsOneWidget);

    expect(find.text('Hoang Nguyen'), findsOneWidget);
  });

  testWidgets(
      'given back to previous screen '
      'when tap on Back button on appbar, '
      'then Diary Detail Screen will be back to previous screen',
      (widgetTester) async {
    const Widget widget = DiaryDetailScreen();

    await mockNetworkImagesFor(() => widgetTester.wrapAndPump(widget));

    final findBackButton = find.descendant(
        of: find.byType(NartusButton),
        matching: find.bySemanticsLabel(S.current.back));

    expect(findBackButton, findsOneWidget);

    //test pressed button
    await widgetTester.tap(findBackButton);
    await widgetTester.pumpAndSettle();
    expect(find.byType(DiaryDetailScreen), findsNothing);
  });
}
