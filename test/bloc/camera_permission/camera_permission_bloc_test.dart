import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:interactive_diary/bloc/camera_permission/camera_permission_bloc.dart';
import 'package:interactive_diary/service_locator/service_locator.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:nartus_media/nartus_media.dart';

import 'camera_permission_bloc_test.mocks.dart';

@GenerateMocks([NartusMediaService])
void main() {
  final MockNartusMediaService mediaService = MockNartusMediaService();

  setUpAll(() {
    ServiceLocator.instance.registerSingleton<NartusMediaService>(mediaService);
  });

  blocTest(
    'given media permission granted, '
    'when validate camera permission, '
    'then return CameraPermissionGranted state',
    build: () => CameraPermissionBloc(),
    setUp: () {
      when(mediaService.checkCameraPermission()).thenAnswer(
          (realInvocation) => Future.value(MediaPermission.granted));
    },
    act: (bloc) => bloc.add(ValidateCameraPermissionEvent()),
    expect: () => [
      isA<CameraPermissionValidationStart>(),
      isA<CameraPermissionGranted>()
    ],
  );

  blocTest(
    'given media permission is limited,'
    'when validate camera permission,'
    'then return CameraPermissionGranted',
    build: () => CameraPermissionBloc(),
    setUp: () {
      when(mediaService.checkCameraPermission()).thenAnswer(
          (realInvocation) => Future.value(MediaPermission.limited));
    },
    act: (bloc) => bloc.add(ValidateCameraPermissionEvent()),
    expect: () => [
      isA<CameraPermissionValidationStart>(),
      isA<CameraPermissionGranted>()
    ],
  );

  blocTest(
    'given media permission is denied,'
    'when validate camera permission,'
    'then return CameraPermissionDenied',
    build: () => CameraPermissionBloc(),
    setUp: () {
      when(mediaService.checkCameraPermission())
          .thenAnswer((realInvocation) => Future.value(MediaPermission.denied));
    },
    act: (bloc) => bloc.add(ValidateCameraPermissionEvent()),
    expect: () =>
        [isA<CameraPermissionValidationStart>(), isA<CameraPermissionDenied>()],
  );

  blocTest(
    'given media permission is denied forever,'
    'when validate camera permission,'
    'then return CameraPermissionDeniedForever',
    build: () => CameraPermissionBloc(),
    setUp: () {
      when(mediaService.checkCameraPermission()).thenAnswer(
          (realInvocation) => Future.value(MediaPermission.deniedForever));
    },
    act: (bloc) => bloc.add(ValidateCameraPermissionEvent()),
    expect: () => [
      isA<CameraPermissionValidationStart>(),
      isA<CameraPermissionDeniedForever>()
    ],
  );

  ////
  blocTest(
    'given media permission granted, '
    'when request camera permission, '
    'then return CameraPermissionGranted state',
    build: () => CameraPermissionBloc(),
    setUp: () {
      when(mediaService.requestCameraPermission()).thenAnswer(
          (realInvocation) => Future.value(MediaPermission.granted));
    },
    act: (bloc) => bloc.add(RequestCameraPermissionEvent()),
    expect: () =>
        [isA<CameraPermissionRequestStart>(), isA<CameraPermissionGranted>()],
  );

  blocTest(
    'given media permission is limited,'
    'when request camera permission,'
    'then return CameraPermissionGranted',
    build: () => CameraPermissionBloc(),
    setUp: () {
      when(mediaService.requestCameraPermission()).thenAnswer(
          (realInvocation) => Future.value(MediaPermission.limited));
    },
    act: (bloc) => bloc.add(RequestCameraPermissionEvent()),
    expect: () =>
        [isA<CameraPermissionRequestStart>(), isA<CameraPermissionGranted>()],
  );

  blocTest(
    'given media permission is denied,'
    'when request camera permission,'
    'then return CameraPermissionDenied',
    build: () => CameraPermissionBloc(),
    setUp: () {
      when(mediaService.requestCameraPermission())
          .thenAnswer((realInvocation) => Future.value(MediaPermission.denied));
    },
    act: (bloc) => bloc.add(RequestCameraPermissionEvent()),
    expect: () =>
        [isA<CameraPermissionRequestStart>(), isA<CameraPermissionDenied>()],
  );

  blocTest(
    'given media permission is denied forever,'
    'when request camera permission,'
    'then return CameraPermissionDeniedForever',
    build: () => CameraPermissionBloc(),
    setUp: () {
      when(mediaService.requestCameraPermission()).thenAnswer(
          (realInvocation) => Future.value(MediaPermission.deniedForever));
    },
    act: (bloc) => bloc.add(RequestCameraPermissionEvent()),
    expect: () => [
      isA<CameraPermissionRequestStart>(),
      isA<CameraPermissionDeniedForever>()
    ],
  );

  test('verify  camera permission state', () {
    final CameraPermissionInitial initial = CameraPermissionInitial();
    expect(initial.props.length, 0);

    final CameraPermissionGranted granted = CameraPermissionGranted();
    expect(granted.props.length, 0);

    final CameraPermissionValidationStart validationStart =
        CameraPermissionValidationStart();
    expect(validationStart.props.length, 0);

    final CameraPermissionRequestStart requestStart =
        CameraPermissionRequestStart();
    expect(requestStart.props.length, 0);

    final CameraPermissionDeniedForever deniedForever =
        CameraPermissionDeniedForever();
    expect(deniedForever.props.length, 0);

    final CameraPermissionDenied denied = CameraPermissionDenied();
    expect(denied.props.length, 0);
  });
}
