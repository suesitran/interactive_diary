import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:interactive_diary/features/diary_detail/diary_detail_screen.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:nartus_ui_package/nartus_ui.dart';
import 'package:network_image_mock/network_image_mock.dart';

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
    expect(find.text('06 May, 2023 at 01:10 AM'), findsOneWidget);
  });
}
