import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:camera/camera.dart';
import 'package:equatable/equatable.dart';
import 'package:interactive_diary/features/media_diary/_shared/constant/media_type.dart';

part 'camera_setup_state.dart';

class CameraSetupCubit extends Cubit<CameraSetupState> {
  CameraSetupCubit() : super(CameraSetupInitial());

  void takePhoto(CameraController controller) async {
    _deleteMediaIfNeeded();

    emit(const CameraMediaStart(MediaType.picture));

    XFile picture = await controller.takePicture();

    emit(CameraMediaReady(picture.path, MediaType.picture));
  }

  void recordVideo(CameraController controller) async {
    _deleteMediaIfNeeded();

    await controller.prepareForVideoRecording();
    await controller.startVideoRecording();
    emit(const CameraMediaStart(MediaType.video));
  }

  void stopRecordVideo(CameraController controller) async {
    if (!controller.value.isRecordingVideo) {
      return;
    }

    XFile file = await controller.stopVideoRecording();

    emit(CameraMediaReady(file.path, MediaType.video));
  }

  void _deleteMediaIfNeeded() {
    if (state is CameraMediaReady) {
      // retake picture, delete old one
      File file = File((state as CameraMediaReady).path);
      if (file.existsSync()) {
        file.deleteSync();
      }
    }
  }
}
