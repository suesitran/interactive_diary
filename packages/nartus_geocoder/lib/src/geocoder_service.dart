part of "../nartus_geocoder.dart";

class GeocoderService {
  Future<LocationDetail> getCurrentPlaceCoding(
      double latitude, double longitude) async {
    // TODO update locale when we have more than 1 language
    final List<Placemark> places = await GeocodingPlatform.instance
        .placemarkFromCoordinates(latitude, longitude, localeIdentifier: 'en');
    if (places.isNotEmpty) {
      Placemark info = places.first;

      return LocationDetail(_computeAddress(info), info.name);
    }
    throw GetAddressFailedException();
  }

  String _computeAddress(Placemark place) => '${place.street}, ${place.subLocality}, ${place.subAdministrativeArea}, ${place.administrativeArea}, ${place.country}';
}
