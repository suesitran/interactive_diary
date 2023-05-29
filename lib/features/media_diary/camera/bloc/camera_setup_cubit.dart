import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:camera/camera.dart';
import 'package:equatable/equatable.dart';

part 'camera_setup_state.dart';

class CameraSetupCubit extends Cubit<CameraSetupState> {
  CameraSetupCubit() : super(CameraSetupInitial());

  void takePhoto(CameraController controller) async {
    if (state is CameraPictureReady) {
      // retake picture, delete old one
      File file = File((state as CameraPictureReady).path);
      if (file.existsSync()) {
        file.deleteSync();
      }
    }

    emit(CameraPictureStart());

    XFile picture = await controller.takePicture();

    emit(CameraPictureReady(picture.path));
  }
}
