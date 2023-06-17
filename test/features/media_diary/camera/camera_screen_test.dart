import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:interactive_diary/features/media_diary/_shared/constant/media_type.dart';
import 'package:interactive_diary/features/media_diary/_shared/widgets/buttons.dart';
import 'package:interactive_diary/features/media_diary/camera/bloc/camera_setup_cubit.dart';
import 'package:interactive_diary/features/media_diary/camera/bloc/media_permission_cubit.dart';
import 'package:interactive_diary/features/media_diary/camera/camera_screen.dart';
import 'package:interactive_diary/generated/l10n.dart';
import 'package:interactive_diary/service_locator/service_locator.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:nartus_media/nartus_media.dart';
import 'package:nartus_storage/nartus_storage.dart';
import 'package:network_image_mock/network_image_mock.dart';

import '../../../widget_tester_extension.dart';
import 'camera_screen_test.mocks.dart';

@GenerateMocks([NartusMediaService, CameraSetupCubit, MediaPermissionCubit])
void main() {
  final MockNartusMediaService nartusMediaService = MockNartusMediaService();
  final MockCameraSetupCubit cameraSetupCubit = MockCameraSetupCubit();
  final MockMediaPermissionCubit mediaPermissionCubit =
      MockMediaPermissionCubit();

  setUpAll(() {
    ServiceLocator.instance
        .registerSingleton<NartusMediaService>(nartusMediaService);

    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(
            const MethodChannel('plugins.flutter.io/camera'),
            (MethodCall methodCall) async {
      expect(methodCall.method, 'availableCameras');

      // return 1 back camera
      return [
        {'name': 'sample', 'lensFacing': 'back', 'sensorOrientation': 0}
      ];
    });
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
          '[THEN]  User will see 3 buttons (close, gallery, flip camera) in the screen',
          (WidgetTester widgetTester) async {
        const CameraScreen screen = CameraScreen(
          latLng: LatLng(lat: 0.0, long: 0.0),
        );

        await widgetTester.wrapAndPump(screen);

        expect(find.byType(CircleButton), findsNWidgets(3));
      });

      testWidgets(
          '[GIVEN] User is in Camera Screen'
          '[WHEN]  User tap on CLOSE button, '
          '[THEN]  User will be redirected back to previous screen (Home Screen)',
          (WidgetTester widgetTester) async {
        const CameraScreen screen = CameraScreen(
          latLng: LatLng(lat: 0.0, long: 0.0),
        );

        await widgetTester.wrapAndPump(screen, useRouter: true);
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
        when(cameraSetupCubit.takePhoto(any)).thenAnswer((realInvocation) {});

        when(cameraSetupCubit.state).thenReturn(CameraSetupInitial());
        when(cameraSetupCubit.stream)
            .thenAnswer((realInvocation) => Stream.value(CameraSetupInitial()));

        const CameraPreviewBody screen = CameraPreviewBody();

        await widgetTester.multiBlocWrapAndPump([
          BlocProvider<CameraSetupCubit>(
            create: (context) => cameraSetupCubit,
          ),
          BlocProvider<MediaPermissionCubit>(
            create: (context) => mediaPermissionCubit,
          )
        ], screen, useRouter: true);

        await widgetTester.pumpAndSettle();
        await widgetTester
            .tap(find.bySemanticsLabel(S.current.captureMediaButton));
        when(cameraSetupCubit.state)
            .thenReturn(const CameraMediaReady('path', MediaType.picture));
        when(cameraSetupCubit.stream).thenAnswer((realInvocation) =>
            Stream.value(const CameraMediaReady('path', MediaType.picture)));
        await widgetTester.pumpAndSettle();

        verify(cameraSetupCubit.takePhoto(any)).called(1);
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

      const CameraScreen widget = CameraScreen(
        latLng: LatLng(lat: 0.0, long: 0.0),
      );

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

      const CameraScreen widget = CameraScreen(
        latLng: LatLng(lat: 0.0, long: 0.0),
      );

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
      when(nartusMediaService.requestMediaPermission())
          .thenAnswer((realInvocation) => Future.value(MediaPermission.denied));

      const CameraScreen widget = CameraScreen(
        latLng: LatLng(lat: 0.0, long: 0.0),
      );

      await mockNetworkImagesFor(() => widgetTester.wrapAndPump(widget,
          useRouter: true, targetRoute: '/addMedia/photoAlbum'));

      await widgetTester
          .tap(find.bySemanticsLabel(S.current.openDeviceGallery));
      await widgetTester.pumpAndSettle();

      // expect to not see dummy route
      expect(find.text('/addMedia/photoAlbum'), findsNothing);
      verify(nartusMediaService.requestMediaPermission()).called(1);
    });

    testWidgets(
        'given photo permission is denied, and request permission is denied'
        'when tap on photo album button,'
        'then do not go to photo album', (widgetTester) async {
      // given
      when(nartusMediaService.checkMediaPermission())
          .thenAnswer((realInvocation) => Future.value(MediaPermission.denied));
      when(nartusMediaService.requestMediaPermission())
          .thenAnswer((realInvocation) => Future.value(MediaPermission.denied));

      const CameraScreen widget = CameraScreen(
        latLng: LatLng(lat: 0.0, long: 0.0),
      );

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
      when(nartusMediaService.requestMediaPermission()).thenAnswer(
          (realInvocation) => Future.value(MediaPermission.granted));

      const CameraScreen widget = CameraScreen(
        latLng: LatLng(lat: 0.0, long: 0.0),
      );

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

      const CameraScreen widget = CameraScreen(
        latLng: LatLng(lat: 0.0, long: 0.0),
      );

      await mockNetworkImagesFor(() => widgetTester.wrapAndPump(widget,
          useRouter: true, targetRoute: '/addMedia/photoAlbum'));

      await widgetTester
          .tap(find.bySemanticsLabel(S.current.openDeviceGallery));
      await widgetTester.pumpAndSettle();

      // expect to not see dummy route
      expect(find.text('/addMedia/photoAlbum'), findsNothing);
      expect(find.byType(CameraScreen), findsOneWidget);

      verifyNever(nartusMediaService.requestMediaPermission());
    });
  });
}
