part of "../nartus_geocoder.dart";

class GeocoderService {
  Future<Placemark?> getCurrentPlaceCoding(
      double latitude, double longitude) async {
    List<Placemark> placemarks = await GeocodingPlatform.instance
        .placemarkFromCoordinates(latitude, longitude);
    if (placemarks.isNotEmpty) {
      return placemarks.first;
    }
    throw GetAddressFailedException();
  }
}
