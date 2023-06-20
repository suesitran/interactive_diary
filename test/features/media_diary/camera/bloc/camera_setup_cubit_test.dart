import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:interactive_diary/features/media_diary/_shared/constant/media_type.dart';
import 'package:interactive_diary/features/media_diary/camera/bloc/camera_setup_cubit.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'camera_setup_cubit_test.mocks.dart';

@GenerateMocks([CameraController, XFile])
void main() {
  final MockCameraController cameraController = MockCameraController();
  final MockXFile xFile = MockXFile();

  blocTest<CameraSetupCubit, CameraSetupState>(
    'given media file exists, when take picture, then delete media file',
    build: () => CameraSetupCubit(),
    setUp: () {
      when(cameraController.takePicture())
          .thenAnswer((realInvocation) => Future.value(xFile));
      when(xFile.path).thenAnswer((realInvocation) => 'sample');

      File file = File('sampleFile.jpg');
      file.createSync();
    },
    seed: () => const CameraMediaReady('sampleFile.jpg', MediaType.picture),
    act: (bloc) => bloc.takePhoto(cameraController),
    verify: (bloc) {
      File file = File('sampleFile.jpg');
      expect(file.existsSync(), false);
    },
    expect: () => [isA<CameraMediaStart>(), isA<CameraMediaReady>()],
  );
}
