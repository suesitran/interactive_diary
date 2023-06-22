import 'package:flutter/foundation.dart';
import 'package:nartus_media/src/data/permissions.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:device_info_plus/device_info_plus.dart';

class NartusMediaService {
  Future<MediaPermission> checkMediaPermission() async {
    PermissionStatus status;
    if (defaultTargetPlatform == TargetPlatform.android) {
      final androidInfo = await DeviceInfoPlugin().androidInfo;
      if (androidInfo.version.sdkInt <= 32) {
        status = await Permission.storage.status;
      } else {
        status = await Permission.photos.status;
      }
    } else {
      status = await Permission.photos.status;
    }

    return _toMediaPermission(status);
  }

  Future<MediaPermission> requestMediaPermission() async {
    PermissionStatus status;
    if (defaultTargetPlatform == TargetPlatform.android) {
      final androidInfo = await DeviceInfoPlugin().androidInfo;

      if (androidInfo.version.sdkInt <= 32) {
        status = await Permission.storage.request();
      } else {
        status = await Permission.photos.request();
      }
    } else {
      status = await Permission.photos.request();
    }

    return _toMediaPermission(status);
  }

  Future<MediaPermission> checkCameraPermission() async {
    PermissionStatus status = await Permission.camera.status;

    return _toMediaPermission(status);
  }

  Future<MediaPermission> requestCameraPermission() async {
    PermissionStatus status = await Permission.camera.request();

    return _toMediaPermission(status);
  }

  MediaPermission _toMediaPermission(PermissionStatus status) {
    switch (status) {
      case PermissionStatus.granted:
        return MediaPermission.granted;
      case PermissionStatus.limited:
        return MediaPermission.limited;
      case PermissionStatus.restricted:
      case PermissionStatus.provisional:
        return MediaPermission.granted;
      case PermissionStatus.denied:
        return MediaPermission.denied;
      case PermissionStatus.permanentlyDenied:
        return MediaPermission.deniedForever;
    }
  }

  Future<void> openSettings() => openAppSettings();

  // TODO add other video and photo handler here
}
