import 'package:flutter_test/flutter_test.dart';
import 'package:location/location.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:nartus_location/nartus_location.dart';

import 'nartus_location_test.mocks.dart';

@GenerateMocks([Location])
void main() {
  final Location location = MockLocation();
  final LocationService service = LocationService(location: location);

  test(
      'given location service disabled, when get current location, then throw LocationServiceDisableException',
      () async {
    // given
    when(location.serviceEnabled())
        .thenAnswer((realInvocation) => Future.value(false));

    // then
    expect(() => service.getCurrentLocation(),
        throwsA(isA<LocationServiceDisableException>()));
  });

  test('given location permission is denied, when get current location, then throw LocationPermissionNotGrantedException',() async {
    // given
    when(location.serviceEnabled()).thenAnswer((realInvocation) => Future.value(true));
    when(location.hasPermission()).thenAnswer((realInvocation) => Future.value(PermissionStatus.denied));

    // then
    expect(() => service.getCurrentLocation(), throwsA(isA<LocationPermissionNotGrantedException>()));
  });

  test('give location permission is denied forever, when get current location, then throw LocationPermissionNotGrantedException', () async {
    // given
    when(location.serviceEnabled()).thenAnswer((realInvocation) => Future.value(true));
    when(location.hasPermission()).thenAnswer((realInvocation) => Future.value(PermissionStatus.deniedForever));

    // then
    expect(() => service.getCurrentLocation(), throwsA(isA<LocationPermissionNotGrantedException>()));
  });

  test('given location data returns null latitude and longitude, when get current location, then throw LocationDataCorruptedException', () async {
    // given
    when(location.serviceEnabled()).thenAnswer((realInvocation) => Future.value(true));
    when(location.hasPermission()).thenAnswer((realInvocation) => Future.value(PermissionStatus.granted));
    when(location.getLocation()).thenAnswer((realInvocation) => Future.value(LocationData.fromMap({})));

    // then
    expect(() => service.getCurrentLocation(), throwsA(isA<LocationDataCorruptedException>()));
  });

  test('given location data returns valid latitude and longitude, when get current location, then return location details with lat and long', () async {
    // given
    when(location.serviceEnabled()).thenAnswer((realInvocation) => Future.value(true));
    when(location.hasPermission()).thenAnswer((realInvocation) => Future.value(PermissionStatus.granted));
    when(location.getLocation()).thenAnswer((realInvocation) => Future.value(LocationData.fromMap({
      'latitude': 100.00,
      'longitude': 200.00
    })));

    // when
    LocationDetails result = await service.getCurrentLocation();

    // then
    expect(result.latitude, 100.00);
    expect(result.longitude, 200.00);
  });
}
