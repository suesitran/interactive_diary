part of 'camera_permission_bloc.dart';

abstract class CameraPermissionState extends Equatable {
  const CameraPermissionState();
}

class CameraPermissionInitial extends CameraPermissionState {
  @override
  List<Object> get props => [];
}

class CameraPermissionGranted extends CameraPermissionState {
  @override
  List<Object?> get props => [];
}

class CameraPermissionValidationStart extends CameraPermissionState {
  @override
  List<Object?> get props => [];
}

class CameraPermissionRequestStart extends CameraPermissionState {
  @override
  List<Object?> get props => [];
}

class CameraPermissionDeniedForever extends CameraPermissionState {
  @override
  List<Object?> get props => [];
}

class CameraPermissionDenied extends CameraPermissionState {
  @override
  List<Object?> get props => [];
}
