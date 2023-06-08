part of "../nartus_geocoder.dart";

class LocationDetail {
  final String address;
  final String? business;
  final String? countryCode;
  final String? postalCode;

  LocationDetail(
      {required this.address,
      required this.countryCode,
      required this.postalCode,
      required this.business});
}
