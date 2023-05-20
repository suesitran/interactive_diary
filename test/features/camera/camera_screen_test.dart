import 'package:flutter_test/flutter_test.dart';
import 'package:interactive_diary/features/camera/camera_screen.dart';
import 'package:interactive_diary/features/camera/widgets/buttons.dart';
import 'package:interactive_diary/generated/l10n.dart';
import 'package:interactive_diary/service_locator/service_locator.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:nartus_media/nartus_media.dart';
import 'package:network_image_mock/network_image_mock.dart';

import '../../widget_tester_extension.dart';
import 'camera_screen_test.mocks.dart';

@GenerateMocks([NartusMediaService])
void main() {
  final MockNartusMediaService nartusMediaService = MockNartusMediaService();

  setUpAll(() {
    ServiceLocator.instance
        .registerSingleton<NartusMediaService>(nartusMediaService);
  });

  tearDown(() {
    reset(nartusMediaService);
  });

  group(
    'test camera default UI',
    () {
      testWidgets(
          '[GIVEN] User is in the app'
          '[WHEN]  User open camera screen, '
          '[THEN]  User will see 4 buttons (close, gallery, flip camera, capture) in the screen',
          (WidgetTester widgetTester) async {
        const CameraScreen screen = CameraScreen();

        await mockNetworkImagesFor(() => widgetTester.wrapAndPump(screen));

        expect(find.byType(CircleButton), findsNWidgets(3));
      });

      testWidgets(
          '[GIVEN] User is in Camera Screen'
          '[WHEN]  User tap on CLOSE button, '
          '[THEN]  User will be redirected back to previous screen (Home Screen)',
          (WidgetTester widgetTester) async {
        const CameraScreen screen = CameraScreen();

        await mockNetworkImagesFor(
            () => widgetTester.wrapAndPump(screen, useRouter: true));

        await widgetTester.pumpAndSettle();
        await widgetTester.tap(find.bySemanticsLabel(S.current.close));
        await widgetTester.pumpAndSettle();
        expect(find.byType(CameraScreen), findsNothing);
      });

      testWidgets(
          '[GIVEN] User is in Camera Screen'
          '[WHEN]  User tap on CAPTURE button, '
          '[THEN]  User will be moved to Preview Screen',
          (WidgetTester widgetTester) async {
        const CameraScreen screen = CameraScreen();

        await mockNetworkImagesFor(
            () => widgetTester.wrapAndPump(screen, useRouter: true));

        await widgetTester.pumpAndSettle();
        await widgetTester
            .tap(find.bySemanticsLabel(S.current.captureMediaButton));
        await widgetTester.pumpAndSettle();
        expect(find.byType(CameraScreen), findsNothing);
      });
    },
  );

  group('test photo album button interaction', () {
    testWidgets(
        'given photo permission is granted,'
        'when tap on photo album button,'
        'then go to Photo album', (widgetTester) async {
      // given
      when(nartusMediaService.checkMediaPermission()).thenAnswer(
          (realInvocation) => Future.value(MediaPermission.granted));

      const CameraScreen widget = CameraScreen();

      await mockNetworkImagesFor(() => widgetTester.wrapAndPump(widget,
          useRouter: true, targetRoute: '/addMedia/photoAlbum'));

      await widgetTester
          .tap(find.bySemanticsLabel(S.current.openDeviceGallery));
      await widgetTester.pumpAndSettle();

      // expect to see dummy route
      expect(find.text('/addMedia/photoAlbum'), findsOneWidget);
      expect(find.byType(CameraScreen), findsNothing);
    });

    testWidgets(
        'given photo permission is limited,'
        'when tap on photo album button,'
        'then go to photo album', (widgetTester) async {
      // given
      when(nartusMediaService.checkMediaPermission()).thenAnswer(
          (realInvocation) => Future.value(MediaPermission.limited));

      const CameraScreen widget = CameraScreen();

      await mockNetworkImagesFor(() => widgetTester.wrapAndPump(widget,
          useRouter: true, targetRoute: '/addMedia/photoAlbum'));

      await widgetTester
          .tap(find.bySemanticsLabel(S.current.openDeviceGallery));
      await widgetTester.pumpAndSettle();

      // expect to see dummy route
      expect(find.text('/addMedia/photoAlbum'), findsOneWidget);
      expect(find.byType(CameraScreen), findsNothing);
    });

    testWidgets(
        'given photo permission is denied,'
        'when tap on photo album button,'
        'then request permission', (widgetTester) async {
      // given
      when(nartusMediaService.checkMediaPermission())
          .thenAnswer((realInvocation) => Future.value(MediaPermission.denied));
      when(nartusMediaService.requestPermission())
          .thenAnswer((realInvocation) => Future.value(MediaPermission.denied));

      const CameraScreen widget = CameraScreen();

      await mockNetworkImagesFor(() => widgetTester.wrapAndPump(widget,
          useRouter: true, targetRoute: '/addMedia/photoAlbum'));

      await widgetTester
          .tap(find.bySemanticsLabel(S.current.openDeviceGallery));
      await widgetTester.pumpAndSettle();

      // expect to not see dummy route
      expect(find.text('/addMedia/photoAlbum'), findsNothing);
      verify(nartusMediaService.requestPermission()).called(1);
    });

    testWidgets(
        'given photo permission is denied, and request permission is denied'
        'when tap on photo album button,'
        'then do not go to photo album', (widgetTester) async {
      // given
      when(nartusMediaService.checkMediaPermission())
          .thenAnswer((realInvocation) => Future.value(MediaPermission.denied));
      when(nartusMediaService.requestPermission())
          .thenAnswer((realInvocation) => Future.value(MediaPermission.denied));

      const CameraScreen widget = CameraScreen();

      await mockNetworkImagesFor(() => widgetTester.wrapAndPump(widget,
          useRouter: true, targetRoute: '/addMedia/photoAlbum'));

      await widgetTester
          .tap(find.bySemanticsLabel(S.current.openDeviceGallery));
      await widgetTester.pumpAndSettle();

      // expect to not see dummy route
      expect(find.text('/addMedia/photoAlbum'), findsNothing);
      expect(find.byType(CameraScreen), findsOneWidget);
    });

    testWidgets(
        'given photo permission is denied, and request permission is granted'
        'when tap on photo album button,'
        'then do not go to photo album', (widgetTester) async {
      // given
      when(nartusMediaService.checkMediaPermission())
          .thenAnswer((realInvocation) => Future.value(MediaPermission.denied));
      when(nartusMediaService.requestPermission()).thenAnswer(
          (realInvocation) => Future.value(MediaPermission.granted));

      const CameraScreen widget = CameraScreen();

      await mockNetworkImagesFor(() => widgetTester.wrapAndPump(widget,
          useRouter: true, targetRoute: '/addMedia/photoAlbum'));

      await widgetTester
          .tap(find.bySemanticsLabel(S.current.openDeviceGallery));
      await widgetTester.pumpAndSettle();

      // expect to see dummy route
      expect(find.text('/addMedia/photoAlbum'), findsOneWidget);
      expect(find.byType(CameraScreen), findsNothing);
    });

    testWidgets(
        'given photo permission is deniedForever,'
        'when tap on photo album button,'
        'then do not go to photo album, and do not request permission',
        (widgetTester) async {
      // given
      when(nartusMediaService.checkMediaPermission()).thenAnswer(
          (realInvocation) => Future.value(MediaPermission.deniedForever));

      const CameraScreen widget = CameraScreen();

      await mockNetworkImagesFor(() => widgetTester.wrapAndPump(widget,
          useRouter: true, targetRoute: '/addMedia/photoAlbum'));

      await widgetTester
          .tap(find.bySemanticsLabel(S.current.openDeviceGallery));
      await widgetTester.pumpAndSettle();

      // expect to not see dummy route
      expect(find.text('/addMedia/photoAlbum'), findsNothing);
      expect(find.byType(CameraScreen), findsOneWidget);

      verifyNever(nartusMediaService.requestPermission());
    });
  });
}
