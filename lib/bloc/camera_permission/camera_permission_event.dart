part of 'camera_permission_bloc.dart';

abstract class CameraPermissionEvent extends Equatable {
  const CameraPermissionEvent();
}

class ValidateCameraPermissionEvent extends CameraPermissionEvent {
  @override
  List<Object?> get props => [];
}

class RequestCameraPermissionEvent extends CameraPermissionEvent {
  @override
  List<Object?> get props => [];
}
