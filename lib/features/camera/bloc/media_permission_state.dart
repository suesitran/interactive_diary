part of 'media_permission_cubit.dart';

abstract class MediaPermissionState extends Equatable {
  const MediaPermissionState();
}

class MediaPermissionInitial extends MediaPermissionState {
  @override
  List<Object> get props => [];
}

class StartCheckingMediaPermission extends MediaPermissionState {
  @override
  List<Object?> get props => [];
}

class MediaPermissionGranted extends MediaPermissionState {
  @override
  List<Object?> get props => [];
}

class RequestMediaPermission extends MediaPermissionState {
  @override
  List<Object?> get props => [];
}

class MediaPermissionDenied extends MediaPermissionState {
  @override
  List<Object?> get props => [];
}

class MediaPermissionDeniedForever extends MediaPermissionState {
  @override
  List<Object?> get props => [];
}
