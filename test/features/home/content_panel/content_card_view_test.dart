import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:interactive_diary/features/home/content_panel/widgets/content_card_view.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:network_image_mock/network_image_mock.dart';

import '../../../widget_tester_extension.dart';

void main() {
  initializeDateFormatting();
  testWidgets('verify content of ContentCardView', (widgetTester) async {
    final Widget widget = ContentCardView(
      displayName: 'displayName',
      photoUrl: 'photoUrl',
      dateTime: DateTime(2022, 9, 20, 18, 20),
      text: 'description',
    );

    await mockNetworkImagesFor(() => widgetTester.wrapAndPump(widget));

    expect(find.text('displayName'), findsOneWidget);
    expect(find.text('description'), findsOneWidget);
    expect(find.text('Sep 20, 2022 at 18:20 PM'), findsOneWidget);
  });
}
