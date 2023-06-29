import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:interactive_diary/features/diary_detail/widgets/video_diary_detail_screen.dart';
import 'package:interactive_diary/features/media_diary/_shared/widgets/buttons.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:nartus_ui_package/widgets/activity_feed_card.dart';
import 'package:video_player_platform_interface/video_player_platform_interface.dart';

import '../../../widget_tester_extension.dart';

class MockVideoPlayerPlatform extends VideoPlayerPlatform {
  @override
  Future<void> init() async {}

  @override
  Future<int?> create(DataSource dataSource) async {
    return 0;
  }

  @override
  Stream<VideoEvent> videoEventsFor(int textureId) {
    return Stream.value(VideoEvent(eventType: VideoEventType.initialized));
  }

  @override
  Future<void> pause(int textureId) async {}

  @override
  Future<void> dispose(int textureId) async {}

  @override
  Future<Duration> getPosition(int textureId) async {
    return const Duration(seconds: 100);
  }
}

void main() {
  initializeDateFormatting();

  testWidgets('verify UI component', (widgetTester) async {
    VideoPlayerPlatform.instance = MockVideoPlayerPlatform();

    final Widget widget = VideoDiaryDetailScreen(
        videoPath: 'videoPath',
        displayName: null,
        photoUrl: null,
        dateTime: DateTime(2022, 10, 22, 18, 27));

    await widgetTester.wrapAndPump(widget, infiniteAnimationWidget: true);

    expect(find.byType(VideoPlayUI), findsOneWidget);
    // close button
    expect(
        find.descendant(
            of: find.byType(CircleButton), matching: find.byType(SvgPicture)),
        findsOneWidget);
    // guest icon
    expect(
        find.descendant(
            of: find.byType(ActivityFeedCard),
            matching: find.byType(SvgPicture)),
        findsOneWidget);
    // Play icon
    expect(
        find.descendant(
            of: find.byType(VideoPlayUI), matching: find.byType(SvgPicture)),
        findsOneWidget);
    // Default display name
    expect(find.text('Guest'), findsOneWidget);
  });
}
