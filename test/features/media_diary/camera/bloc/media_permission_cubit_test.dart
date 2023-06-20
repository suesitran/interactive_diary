import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:interactive_diary/features/media_diary/camera/bloc/media_permission_cubit.dart';
import 'package:interactive_diary/service_locator/service_locator.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:nartus_media/nartus_media.dart';

import 'media_permission_cubit_test.mocks.dart';

@GenerateMocks([NartusMediaService])
void main() {
  final MockNartusMediaService mediaService = MockNartusMediaService();

  setUpAll(() {
    ServiceLocator.instance.registerSingleton<NartusMediaService>(mediaService);
  });

  blocTest(
    'given media permission is granted,'
    'when checkMediaPermission,'
    'then return MediaPermissionGranted',
    build: () => MediaPermissionCubit(),
    setUp: () {
      when(mediaService.checkMediaPermission()).thenAnswer(
          (realInvocation) => Future.value(MediaPermission.granted));
    },
    act: (bloc) => bloc.checkMediaPermission(),
    expect: () =>
        [isA<StartCheckingMediaPermission>(), isA<MediaPermissionGranted>()],
    tearDown: () => reset(mediaService),
  );

  blocTest(
    'given media permission is limited,'
    'when checkMediaPermission,'
    'then return MediaPermissionGranted',
    build: () => MediaPermissionCubit(),
    setUp: () {
      when(mediaService.checkMediaPermission()).thenAnswer(
          (realInvocation) => Future.value(MediaPermission.limited));
    },
    act: (bloc) => bloc.checkMediaPermission(),
    expect: () =>
        [isA<StartCheckingMediaPermission>(), isA<MediaPermissionGranted>()],
    tearDown: () => reset(mediaService),
  );

  blocTest(
    'given media permission is denied,'
    'when checkMediaPermission,'
    'then return MediaPermissionDenied',
    build: () => MediaPermissionCubit(),
    setUp: () {
      when(mediaService.checkMediaPermission())
          .thenAnswer((realInvocation) => Future.value(MediaPermission.denied));
    },
    act: (bloc) => bloc.checkMediaPermission(),
    expect: () =>
        [isA<StartCheckingMediaPermission>(), isA<RequestMediaPermission>()],
    tearDown: () => reset(mediaService),
  );

  blocTest(
    'given media permission is denied forever,'
    'when checkMediaPermission,'
    'then return MediaPermissionDenied',
    build: () => MediaPermissionCubit(),
    setUp: () {
      when(mediaService.checkMediaPermission()).thenAnswer(
          (realInvocation) => Future.value(MediaPermission.deniedForever));
    },
    act: (bloc) => bloc.checkMediaPermission(),
    expect: () => [
      isA<StartCheckingMediaPermission>(),
      isA<MediaPermissionDeniedForever>()
    ],
    tearDown: () => reset(mediaService),
  );

  blocTest(
    'given media permission is granted,'
    'when requestMediaPermission,'
    'then return MediaPermissionGranted',
    build: () => MediaPermissionCubit(),
    setUp: () {
      when(mediaService.requestMediaPermission()).thenAnswer(
          (realInvocation) => Future.value(MediaPermission.granted));
    },
    act: (bloc) => bloc.requestMediaPermission(),
    expect: () => [isA<MediaPermissionGranted>()],
    tearDown: () => reset(mediaService),
  );

  blocTest(
    'given media permission is limited,'
    'when requestMediaPermission,'
    'then return MediaPermissionGranted',
    build: () => MediaPermissionCubit(),
    setUp: () {
      when(mediaService.requestMediaPermission()).thenAnswer(
          (realInvocation) => Future.value(MediaPermission.limited));
    },
    act: (bloc) => bloc.requestMediaPermission(),
    expect: () => [isA<MediaPermissionGranted>()],
    tearDown: () => reset(mediaService),
  );

  blocTest(
    'given media permission is denied,'
    'when requestMediaPermission,'
    'then return MediaPermissionDenied',
    build: () => MediaPermissionCubit(),
    setUp: () {
      when(mediaService.requestMediaPermission())
          .thenAnswer((realInvocation) => Future.value(MediaPermission.denied));
    },
    act: (bloc) => bloc.requestMediaPermission(),
    expect: () => [isA<MediaPermissionDenied>()],
    tearDown: () => reset(mediaService),
  );

  blocTest(
    'given media permission is denied forever,'
    'when requestMediaPermission,'
    'then return MediaPermissionDenied',
    build: () => MediaPermissionCubit(),
    setUp: () {
      when(mediaService.requestMediaPermission()).thenAnswer(
          (realInvocation) => Future.value(MediaPermission.deniedForever));
    },
    act: (bloc) => bloc.requestMediaPermission(),
    expect: () => [isA<MediaPermissionDeniedForever>()],
    tearDown: () => reset(mediaService),
  );

  blocTest(
    'when openSetting,'
    'then open app setting',
    build: () => MediaPermissionCubit(),
    act: (bloc) => bloc.openSettings(),
    verify: (bloc) => verify(mediaService.openSettings()).called(1),
    tearDown: () => reset(mediaService),
  );
}
