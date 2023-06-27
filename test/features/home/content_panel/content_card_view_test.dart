import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:interactive_diary/features/home/content_panel/widgets/content_card_view.dart';
import 'package:interactive_diary/features/home/data/diary_display_content.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:network_image_mock/network_image_mock.dart';

import '../../../widget_tester_extension.dart';

void main() {
  initializeDateFormatting();
  testWidgets('verify content of ContentCardView', (widgetTester) async {
    final Widget widget = ContentCardView(
      displayName: 'displayName',
      userPhotoUrl: 'photoUrl',
      dateTime: DateTime(2022, 9, 20, 18, 20),
      text: 'description',
    );

    await mockNetworkImagesFor(() => widgetTester.wrapAndPump(widget));

    expect(find.text('displayName'), findsOneWidget);
    expect(find.text('description', findRichText: true), findsOneWidget);
    expect(find.text('20 Sep, 2022 at 18:20 PM'), findsOneWidget);
  });

  testWidgets(
      'given no photos, when show ContentCardView, then do not show any photo',
      (widgetTester) async {
    final Widget widget = ContentCardView(
      displayName: 'displayName',
      userPhotoUrl: 'photoUrl',
      dateTime: DateTime(2022, 9, 20, 18, 20),
      text: 'description',
    );

    await mockNetworkImagesFor(() => widgetTester.wrapAndPump(widget));

    expect(find.byType(ClipRRect), findsNothing);
  });

  testWidgets(
      'given there are text and less than 3 pictures, when show ContentCardView, then show all pictures without extra indicator',
      (widgetTester) async {
    final Widget widget = ContentCardView(
      displayName: 'displayName',
      userPhotoUrl: 'photoUrl',
      dateTime: DateTime(2022, 9, 20, 18, 20),
      text: 'description',
      mediaInfo: [
        MediaInfo('image1', false),
        MediaInfo('image2', true),
      ],
    );

    await mockNetworkImagesFor(() => widgetTester.wrapAndPump(widget));

    expect(find.byType(Image), findsNWidgets(2));
  });

  testWidgets(
      'given there are text and 3 pictures, when show ContentCardView, then show all pictures without extra indicator',
      (widgetTester) async {
    final Widget widget = ContentCardView(
      displayName: 'displayName',
      userPhotoUrl: 'photoUrl',
      dateTime: DateTime(2022, 9, 20, 18, 20),
      text: 'description',
      mediaInfo: [
        MediaInfo('image1', false),
        MediaInfo('image2', true),
        MediaInfo('image3', true),
      ],
    );

    await mockNetworkImagesFor(() => widgetTester.wrapAndPump(widget));

    expect(find.byType(Image), findsNWidgets(3));
  });

  testWidgets(
      'given there are text and more than 3 pictures, when show ContentCardView, then show 3 pictures with extra indicator',
      (widgetTester) async {
    final Widget widget = ContentCardView(
      displayName: 'displayName',
      userPhotoUrl: 'photoUrl',
      dateTime: DateTime(2022, 9, 20, 18, 20),
      text: 'description',
      mediaInfo: [
        MediaInfo('image1', false),
        MediaInfo('image2', true),
        MediaInfo('image3', true),
        MediaInfo('image4', true),
      ],
    );

    await mockNetworkImagesFor(() => widgetTester.wrapAndPump(widget));

    expect(find.byType(Image), findsNWidgets(3));
    expect(find.text('+1'), findsOneWidget);
  });

  testWidgets(
      'given there are no text and less than 4 pictures, when show ContentCardView, then show all pictures without extra indicator',
      (widgetTester) async {
    final Widget widget = SingleChildScrollView(
      child: ContentCardView(
        displayName: 'displayName',
        userPhotoUrl: 'photoUrl',
        dateTime: DateTime(2022, 9, 20, 18, 20),
        mediaInfo: [
          MediaInfo('image1', false),
          MediaInfo('image2', true),
          MediaInfo('image3', true),
        ],
      ),
    );

    await mockNetworkImagesFor(() => widgetTester.wrapAndPump(widget));

    expect(find.byType(Image), findsNWidgets(3));
  });

  testWidgets(
      'given there are no text and 4 pictures, when show ContentCardView, then show all pictures without extra indicator',
      (widgetTester) async {
    final Widget widget = SingleChildScrollView(
      child: ContentCardView(
        displayName: 'displayName',
        userPhotoUrl: 'photoUrl',
        dateTime: DateTime(2022, 9, 20, 18, 20),
        mediaInfo: [
          MediaInfo('image1', false),
          MediaInfo('image2', true),
          MediaInfo('image3', true),
          MediaInfo('image4', true),
        ],
      ),
    );

    await mockNetworkImagesFor(() => widgetTester.wrapAndPump(widget));

    expect(find.byType(Image), findsNWidgets(4));
  });

  testWidgets(
      'given there are no text and more than 4 pictures, when show ContentCardView, then show 4 pictures with extra indicator',
      (widgetTester) async {
    final Widget widget = SingleChildScrollView(
      child: ContentCardView(
        displayName: 'displayName',
        userPhotoUrl: 'photoUrl',
        dateTime: DateTime(2022, 9, 20, 18, 20),
        mediaInfo: [
          MediaInfo('image1', false),
          MediaInfo('image2', true),
          MediaInfo('image3', true),
          MediaInfo('image4', true),
          MediaInfo('image5', true),
        ],
      ),
    );

    await mockNetworkImagesFor(() => widgetTester.wrapAndPump(widget));

    expect(find.byType(Image), findsNWidgets(4));
    expect(find.text('+1'), findsOneWidget);
  });
}
