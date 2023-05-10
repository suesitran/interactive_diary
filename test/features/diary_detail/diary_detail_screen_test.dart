import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:interactive_diary/features/diary_detail/diary_detail_screen.dart';
import 'package:interactive_diary/features/diary_detail/widgets/diary_header.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:nartus_ui_package/widgets/buttons/nartus_button.dart';
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
  });
}
