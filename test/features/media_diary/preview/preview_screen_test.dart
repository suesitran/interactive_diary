import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:interactive_diary/features/media_diary/_shared/constant/media_type.dart';
import 'package:interactive_diary/features/media_diary/_shared/widgets/buttons.dart';
import 'package:interactive_diary/features/media_diary/preview/preview_screen.dart';
import 'package:interactive_diary/generated/l10n.dart';
import 'package:nartus_storage/nartus_storage.dart';
import 'package:nartus_ui_package/nartus_ui.dart';
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
    return Stream.value(VideoEvent(eventType: VideoEventType.completed));
  }

  @override
  Future<void> pause(int textureId) async {}

  @override
  Future<void> dispose(int textureId) async {}
}

void main() {
  testWidgets(
      '[GIVEN] User is in Camera Screen'
      '[WHEN]  User finished capturing media (take picture, record video, choose media from library), '
      '[THEN]  User will see 2 buttons (back, save) in the screen',
      (WidgetTester widgetTester) async {
    const PreviewScreen screen =
        PreviewScreen(LatLng(lat: 0.0, long: 0.0), '', MediaType.picture);

    await widgetTester.wrapAndPump(screen);

    expect(find.byType(CircleButton), findsOneWidget);
    expect(find.byType(NartusButton), findsOneWidget);
    expect(find.text(S.current.save), findsOneWidget);
  });

  testWidgets(
      '[GIVEN] User is in Preview Screen'
      '[WHEN]  User tap on CLOSE button, '
      '[THEN]  User will be redirected back to previous screen (Camera Screen)',
      (WidgetTester widgetTester) async {
    File file = File('sample.jgp');
    file.createSync();

    const PreviewScreen screen = PreviewScreen(
        LatLng(lat: 0.0, long: 0.0), 'sample.jgp', MediaType.picture);

    await widgetTester.wrapAndPump(screen, useRouter: true);
    await widgetTester.pumpAndSettle();

    file = File('sample.jgp');
    // verify that file still exist
    expect(file.existsSync(), true);
    await widgetTester.tap(find.bySemanticsLabel(S.current.close));
    await widgetTester.pumpAndSettle();
    expect(find.byType(PreviewScreen), findsNothing);

    // verify that file is deleted
    file = File('sample.jgp');
    expect(file.existsSync(), false);
  });

  testWidgets(
      'given media is type Picture, '
      'when user in Preview Screen, '
      'then Image is displayed', (widgetTester) async {
    const Widget widget =
        PreviewScreen(LatLng(lat: 0.0, long: 0.0), 'path', MediaType.picture);

    await widgetTester.wrapAndPump(widget);

    expect(find.byType(Image), findsOneWidget);
    expect(find.byType(VideoPreview), findsNothing);
  });

  testWidgets(
      'given media is type Video, '
      'when user in Preview Screen, '
      'then VideoPlayer is displayed', (widgetTester) async {
    VideoPlayerPlatform.instance = MockVideoPlayerPlatform();

    const Widget widget =
        PreviewScreen(LatLng(lat: 0.0, long: 0.0), 'path', MediaType.video);

    await widgetTester.wrapAndPump(widget);

    expect(find.byType(Image), findsNothing);
    expect(find.byType(VideoPreview), findsOneWidget);
  });
}
