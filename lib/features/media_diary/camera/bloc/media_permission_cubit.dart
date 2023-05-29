import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:interactive_diary/service_locator/service_locator.dart';
import 'package:nartus_media/nartus_media.dart';

part 'media_permission_state.dart';

class MediaPermissionCubit extends Cubit<MediaPermissionState> {
  MediaPermissionCubit() : super(MediaPermissionInitial());

  final NartusMediaService mediaService =
      ServiceLocator.instance.get<NartusMediaService>();

  Future<void> checkMediaPermission() async {
    emit(StartCheckingMediaPermission());
    MediaPermission permission = await mediaService.checkMediaPermission();

    switch (permission) {
      case MediaPermission.granted:
      case MediaPermission.limited:
        if (!isClosed) {
          emit(MediaPermissionGranted());
        }
        break;
      case MediaPermission.deniedForever:
        if (!isClosed) {
          emit(MediaPermissionDeniedForever());
        }
        break;
      default:
        if (!isClosed) {
          emit(RequestMediaPermission());
        }
    }
  }

  void requestMediaPermission() async {
    MediaPermission permission = await mediaService.requestMediaPermission();

    switch (permission) {
      case MediaPermission.granted:
      case MediaPermission.limited:
        if (!isClosed) {
          emit(MediaPermissionGranted());
        }
        break;
      case MediaPermission.deniedForever:
        if (!isClosed) {
          emit(MediaPermissionDeniedForever());
        }
        break;
      default:
        if (!isClosed) {
          emit(MediaPermissionDenied());
        }
    }
  }

  void openSettings() => mediaService.openSettings();
}
