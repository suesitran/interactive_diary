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
class GoToPhotoAlbum extends MediaPermissionState {
  @override
  List<Object?> get props => [];
}

class RequestMediaPermission extends MediaPermissionState {
  @override
  List<Object?> get props => [];
}

class MediaPermissionDenied extends MediaPermissionState {
  @override
  List<Object?> get props => throw UnimplementedError();
}