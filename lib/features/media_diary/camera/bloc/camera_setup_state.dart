part of 'camera_setup_cubit.dart';

abstract class CameraSetupState extends Equatable {
  const CameraSetupState();
}

class CameraSetupInitial extends CameraSetupState {
  @override
  List<Object> get props => [];
}

class CameraMediaStart extends CameraSetupState {
  @override
  List<Object?> get props => [];
}

class CameraMediaReady extends CameraSetupState {
  final String path;
  final MediaType type;

  const CameraMediaReady(this.path, this.type);

  @override
  List<Object?> get props => [path, type];
}