import 'package:nartus_media/src/data/permissions.dart';
import 'package:permission_handler/permission_handler.dart';

class NartusMediaService {
  Future<MediaPermission> checkMediaPermission() async {
    PermissionStatus status = await Permission.photos.status;

    return _toMediaPermission(status);
  }

  Future<MediaPermission> requestPermission() async {
    PermissionStatus status = await Permission.photos.request();

    return _toMediaPermission(status);
  }

  MediaPermission _toMediaPermission(PermissionStatus status) {
    switch(status) {
      case PermissionStatus.granted:
        return MediaPermission.granted;
      case PermissionStatus.limited:
        return MediaPermission.limited;
      case PermissionStatus.restricted:
      case PermissionStatus.denied:
        return MediaPermission.denied;
      case PermissionStatus.permanentlyDenied:
        return MediaPermission.deniedForever;
    }
  }

  // TODO add other video and photo handler here
}