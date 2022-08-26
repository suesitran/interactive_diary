part of "../nartus_location.dart";

class LocationService {
  final Location _location;

  LocationService({Location? location}) : _location = location ?? Location();

  Future<LocationDetails> getCurrentLocation() async {
    // check if locations service is enable
    bool serviceEnable = await _location.serviceEnabled();

    if (!serviceEnable) {
      throw LocationServiceDisableException();
    }

    // check permission
    PermissionStatus permissionStatus = await _location.hasPermission();
    switch (permissionStatus) {
      case PermissionStatus.denied:
      case PermissionStatus.deniedForever:
        throw LocationPermissionNotGrantedException();
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

  Future<PermissionStatus> requestPermission() => _location.requestPermission();

  Future<bool> requestService() => _location.requestService();

  Future<PermissionStatus> permissionStatus() => _location.hasPermission();
}
