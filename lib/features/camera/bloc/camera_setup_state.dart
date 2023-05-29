part of 'camera_setup_cubit.dart';

abstract class CameraSetupState extends Equatable {
  const CameraSetupState();
}

class CameraSetupInitial extends CameraSetupState {
  @override
  List<Object> get props => [];
}

class CameraControllerReady extends CameraSetupState {
  final CameraController controller;

  const CameraControllerReady(this.controller);

  @override
  List<Object?> get props => [controller];
}

class CameraPictureReady extends CameraSetupState {
  final String path;

  const CameraPictureReady(this.path);

  @override
  List<Object?> get props => [path];
}
