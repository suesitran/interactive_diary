import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:interactive_diary/service_locator/service_locator.dart';
import 'package:nartus_media/nartus_media.dart';

part 'media_permission_state.dart';

class MediaPermissionCubit extends Cubit<MediaPermissionState> {
  MediaPermissionCubit() : super(MediaPermissionInitial());

  final NartusMediaService mediaService = ServiceLocator.instance.get<NartusMediaService>();

  Future<void> checkMediaPermission() async {
    emit(StartCheckingMediaPermission());
    MediaPermission permission = await mediaService.checkMediaPermission();

    _handlePermission(permission);
  }

  void requestMediaPermission() async {
    MediaPermission permission = await mediaService.requestMediaPermission();

    _handlePermission(permission);
  }

  void openSettings() => mediaService.openSettings();

  void _handlePermission(MediaPermission permission) {
    switch(permission) {
      case MediaPermission.granted:
      case MediaPermission.limited:
        if (!isClosed) {
          emit(GoToPhotoAlbum());
        }
        break;
      case MediaPermission.deniedForever:
        if (!isClosed) {
          emit(PermissionDeniedForever());
        }
        break;
      default:
        if (!isClosed) {
          emit(RequestMediaPermission());
        }
    }
  }
}
