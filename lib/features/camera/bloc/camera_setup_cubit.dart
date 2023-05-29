import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:camera/camera.dart';
import 'package:equatable/equatable.dart';

part 'camera_setup_state.dart';

class CameraSetupCubit extends Cubit<CameraSetupState> {
  CameraSetupCubit() : super(CameraSetupInitial());

  List<CameraDescription> cameras = [];
  void initCameraController() async {
     cameras = await availableCameras();

     if (cameras.isEmpty) {
       // TODO handle when device has no camera
       return;
     }

    // start with back camera
     CameraController controller = CameraController(_findBackCamera(cameras), ResolutionPreset.max);
     try {
       await controller.initialize();

       emit(CameraControllerReady(controller));
     } on CameraException catch (e) {
       // TODO handle when camera fails to initialise
     }
  }

  void takePhoto() async {
    if (state is! CameraControllerReady) {
      // it should never happen
      return;
    }

    CameraController controller = (state as CameraControllerReady).controller;

    XFile picture = await controller.takePicture();

    print('picture ${picture.path}');
    await controller.dispose();

    emit(CameraPictureReady(picture.path));
  }

  CameraDescription _findFrontCamera(List<CameraDescription> cameras) => cameras.firstWhere((element) => element.lensDirection == CameraLensDirection.front, orElse: () => cameras.first,);
  CameraDescription _findBackCamera(List<CameraDescription> cameras) => cameras.firstWhere((element) => element.lensDirection == CameraLensDirection.back, orElse: () => cameras.first,);
}
