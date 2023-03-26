import 'package:flutter_test/flutter_test.dart';
import 'package:geocoding/geocoding.dart';
import 'package:nartus_geocoder/nartus_geocoder.dart';

class MockGeocoderData extends GeocodingPlatform {
  List<Placemark> _mockData = [];

  set mockData(List<Placemark> data) {
    _mockData = data;
  }

  @override
  Future<List<Placemark>> placemarkFromCoordinates(
    double latitude,
    double longitude, {
    String? localeIdentifier,
  }) {
    return Future.value(_mockData);
  }
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  final MockGeocoderData geocoding = MockGeocoderData();

  setUpAll(() {
    GeocodingPlatform.instance = geocoding;
  });

  test(
      'given service returns blank, when getCurrentPlaceCoding, then throw Exception',
      () async {
    geocoding.mockData = [];

    GeocoderService service = GeocoderService();
    expect(() async => await service.getCurrentPlaceCoding(1.0, 2.0),
        throwsA(isA<GetAddressFailedException>()));
  });

  test(
    'given service return invalid data, when getCurrentPlaceCoding, then throw exception',
    () {
      geocoding.mockData = [Placemark()];

      GeocoderService service = GeocoderService();
      expect(() async => await service.getCurrentPlaceCoding(1.0, 2.0),
          throwsA(isA<GetAddressFailedException>()));
    },
  );

  test(
    'given service return data with at least 1 field, when getCurrentPlaceCoding, then return data',
    () async {
      geocoding.mockData = [Placemark(name: 'name')];

      GeocoderService service = GeocoderService();
      final LocationDetail result =
          await service.getCurrentPlaceCoding(1.0, 2.0);
      expect(result.business, 'name');
    },
  );
}
