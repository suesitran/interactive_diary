import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:interactive_diary/features/diary_detail/diary_detail_screen.dart';
import 'package:interactive_diary/features/home/data/diary_display_content.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:nartus_ui_package/widgets/buttons/nartus_button.dart';
import 'package:network_image_mock/network_image_mock.dart';

import 'package:flutter_quill/flutter_quill.dart' hide Text;

import '../../widget_tester_extension.dart';

void main() {
  initializeDateFormatting();
  testWidgets('verify UI diary detail screen', (widgetTester) async {
    final document =
        Document.fromJson(jsonDecode('[{"insert":"sample text\\n"}]'));

    DiaryDisplayContent displayContent = DiaryDisplayContent(
        dateTime: DateTime(2023, 5, 16, 1, 10),
        userPhotoUrl: 'userPhotoUrl',
        plainText: document.toPlainText(),
        document: document,
        userDisplayName: 'userDisplayName');

    final Widget widget = DiaryDetailBody(displayContent: displayContent);

    await mockNetworkImagesFor(() => widgetTester.wrapAndPump(widget));
    expect(
        find.descendant(
            of: find.byType(AppBar), matching: find.byType(NartusButton)),
        findsOneWidget);
    expect(find.text('userDisplayName'), findsOneWidget);
    expect(find.text('16 May, 2023 at 01:10 AM'), findsOneWidget);
  });
}
