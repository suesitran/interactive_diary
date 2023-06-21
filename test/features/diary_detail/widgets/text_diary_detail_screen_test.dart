import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:interactive_diary/features/diary_detail/widgets/text_diary_detail_screen.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:nartus_ui_package/nartus_ui.dart';
import 'package:nartus_ui_package/widgets/activity_feed_card.dart';
import 'package:network_image_mock/network_image_mock.dart';
import 'package:interactive_diary/generated/l10n.dart';

import '../../../widget_tester_extension.dart';

void main() {
  initializeDateFormatting();

  const String textJson = '[{"insert":"Text diary\\n"}]';

  testWidgets('verify UI diary detail screen', (widgetTester) async {
    final Widget widget = TextDiaryDetailScreen(
      dateTime: DateTime(2022, 10, 20, 10, 18, 23),
      photoUrl: null,
      displayName: null,
      jsonText: textJson,
    );

    await mockNetworkImagesFor(() => widgetTester.wrapAndPump(widget));
    expect(
        find.descendant(
            of: find.byType(AppBar), matching: find.byType(ActivityFeedCard)),
        findsOneWidget);
    expect(
        find.descendant(
            of: find.byType(AppBar), matching: find.byType(NartusButton)),
        findsOneWidget);
    expect(
        find.descendant(
            of: find.byType(Scaffold), matching: find.byType(QuillEditor)),
        findsOneWidget);

    expect(find.text('Guest'), findsOneWidget);
  });

  testWidgets(
      'given back to previous screen '
      'when tap on Back button on appbar, '
      'then Diary Detail Screen will be back to previous screen',
      (widgetTester) async {
    final Widget widget = TextDiaryDetailScreen(
      dateTime: DateTime(2022, 10, 20, 10, 18, 23),
      photoUrl: null,
      displayName: null,
      jsonText: textJson,
    );

    await mockNetworkImagesFor(() => widgetTester.wrapAndPump(widget));

    final findBackButton = find.descendant(
        of: find.byType(NartusButton),
        matching: find.bySemanticsLabel(S.current.back));

    expect(findBackButton, findsOneWidget);

    //test pressed button
    await widgetTester.tap(findBackButton);
    await widgetTester.pumpAndSettle();
    expect(find.byType(TextDiaryDetailScreen), findsNothing);
  });
}
