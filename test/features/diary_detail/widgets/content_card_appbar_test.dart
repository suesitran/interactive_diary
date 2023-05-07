import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:network_image_mock/network_image_mock.dart';

import 'package:interactive_diary/features/diary_detail/widgets/content_card_appbar.dart';
import '../../../widget_tester_extension.dart';

void main() {
  initializeDateFormatting();
  testWidgets('verify content of Content Card Appbar', (widgetTester) async {
    final Widget widget = ContentCardAppBarView(
      displayName: 'displayName',
      photoUrl: 'photoUrl',
      dateTime: DateTime(2023, 5, 16, 1, 10),
    );

    await mockNetworkImagesFor(() => widgetTester.wrapAndPump(widget));
    expect(find.text('displayName'), findsOneWidget);
    expect(find.text('16 May, 2023 at 01:10 AM'), findsOneWidget);
  });
}
