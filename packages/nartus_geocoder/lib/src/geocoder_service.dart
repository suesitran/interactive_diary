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

    print('name: ${info.name}');
        print('street: ${info.street}');
            print('isoCountryCode: ${info.isoCountryCode}');
                print('country: ${info.country}');
                    print('postalCode: ${info.postalCode}');
                        print('administrativeArea: ${info.administrativeArea}');
                            print('subAdministrativeArea: ${info.subAdministrativeArea}');
                                print('locality: ${info.locality}');
    print('subLocality: ${info.subLocality}');
    print('thoroughfare: ${info.thoroughfare}');
    print('subThoroughfare: ${info.subThoroughfare}');

    return LocationDetail(
      address: _computeAddress(info),
        business: info.name,
    countryCode: info.isoCountryCode ?? info.country,
    postalCode: info.postalCode ?? info.administrativeArea ?? info.subAdministrativeArea);
  }

  String _computeAddress(Placemark place) =>
      '${place.street}, ${place.subLocality}, ${place.subAdministrativeArea}, ${place.administrativeArea}, ${place.country}';
}
