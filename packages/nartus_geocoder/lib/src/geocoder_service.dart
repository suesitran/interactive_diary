part of "../nartus_geocoder.dart";

class GeocoderService {
  Future<LocationDetail> getCurrentPlaceCoding(
      double latitude, double longitude) async {
    // TODO update locale when we have more than 1 language
    final List<Placemark> places = await GeocodingPlatform.instance
        .placemarkFromCoordinates(latitude, longitude, localeIdentifier: 'en');

    if (places.isEmpty) {
      throw GetAddressFailedException();
    }

    Placemark info = places.first;

    if (info.name == null &&
        info.street == null &&
        info.isoCountryCode == null &&
        info.country == null &&
        info.postalCode == null &&
        info.administrativeArea == null &&
        info.subAdministrativeArea == null &&
        info.locality == null &&
        info.subLocality == null &&
        info.thoroughfare == null &&
        info.subThoroughfare == null) {
      // data is null, this placemark is invalid
      throw GetAddressFailedException();
    }

    return LocationDetail(
        address: _computeAddress(info),
        business: info.name,
        countryCode: info.isoCountryCode ?? info.country,
        postalCode: info.postalCode ??
            info.administrativeArea ??
            info.subAdministrativeArea);
  }

  String _computeAddress(Placemark place) => [
        place.street,
        place.subAdministrativeArea ??
            place.subLocality ??
            place.subThoroughfare,
        place.administrativeArea ?? place.locality ?? place.thoroughfare,
        place.postalCode,
        place.country
      ].where((element) => element?.isNotEmpty == true).join(', ');
}
