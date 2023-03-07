import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:geocoding/geocoding.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:nartus_geocoder/nartus_geocoder.dart';
import 'nartus_geocoder_test.mocks.dart';

@GenerateMocks([GeocoderService])
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  final MockGeocoderService mockGeocoder = MockGeocoderService();

  group("description", () {
    test('Test with default location', () async {
      Placemark placemarkDefault = Placemark(
        name: 'Ben Thanh Market',
        street: 'Phan Chu Trinh',
        isoCountryCode: 'VN',
        country: 'Vietnam',
        administrativeArea: 'Ho Chi Minh City',
        locality: 'District 1',
        subLocality: 'Ho Chi Minh City',
        thoroughfare: 'Phan Chu Trinh',
      );

      when(
        mockGeocoder.getCurrentPlaceCoding(10.7725, 106.6980),
      ).thenAnswer((_) => Future.value(placemarkDefault));
      final futurePlacemart =
          await mockGeocoder.getCurrentPlaceCoding(10.7725, 106.6980);
      expect(futurePlacemart, placemarkDefault);
    });
  });
}
