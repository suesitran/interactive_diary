part of "../nartus_location.dart";

class LocationService {
  final Location _location;
  final Permission _permission;

  LocationService({Location? location, Permission? permission})
      : _location = location ?? Location(),
        _permission = permission ?? Permission.location;

  Future<LocationDetails> getCurrentLocation() async {
    // check if locations service is enable
    bool serviceEnable = await _location.serviceEnabled();

    if (!serviceEnable) {
      throw LocationServiceDisableException();
    }

    // check permission
    PermissionStatus permissionStatus = await _permission.status;
    switch (permissionStatus) {
      case PermissionStatus.denied:
      case PermissionStatus.limited:
      case PermissionStatus.restricted:
        throw LocationPermissionDeniedException();
      case PermissionStatus.permanentlyDenied:
        throw LocationPermissionDeniedForeverException();
      default:
        break;
    }

    // get current location
    LocationData data = await _location.getLocation();

    if (data.latitude != null && data.longitude != null) {
      return LocationDetails(data.latitude!, data.longitude!);
    }

    throw LocationDataCorruptedException();
  }

  Future<PermissionStatusDiary> checkPermission(
      {PermissionStatus? permissionStatus}) async {
    final status = permissionStatus ?? await _permission.status;

    switch (status) {
      case PermissionStatus.granted:
        return PermissionStatusDiary.granted;
      case PermissionStatus.denied:
      case PermissionStatus.restricted:
      case PermissionStatus.limited:
        return PermissionStatusDiary.denied;
      case PermissionStatus.permanentlyDenied:
        return PermissionStatusDiary.deniedForever;
      default:
        break;
    }
    return PermissionStatusDiary.denied;
  }

  Future<PermissionStatusDiary> requestPermission() async {
    PermissionStatus status = await _permission.status;

    if (status != PermissionStatus.granted) {
      status = await _permission.request();
    }

    return checkPermission(permissionStatus: status);
  }

  Future<bool> requestService() => _location.requestService();

  Future<bool> requestOpenAppSettings() => openAppSettings();
}
