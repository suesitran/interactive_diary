import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:interactive_diary/features/home/bloc/address_cubit.dart';
import 'package:interactive_diary/service_locator/service_locator.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:nartus_geocoder/nartus_geocoder.dart';

import 'address_cubit_test.mocks.dart';

@GenerateMocks([GeocoderService])
void main() {
  final MockGeocoderService geocoderService = MockGeocoderService();

  setUpAll(() => ServiceLocator.instance
      .registerSingleton<GeocoderService>(geocoderService));

  blocTest(
    'verify details when load address for any lat/lng value',
    build: () => AddressCubit(),
    setUp: () {
      when(geocoderService.getCurrentPlaceCoding(0.0, 0.0)).thenAnswer(
          (realInvocation) => Future.value(LocationDetail(
              address: 'address',
              postalCode: 'postalCode',
              countryCode: 'countryCode',
              business: 'business')));
    },
    act: (bloc) => bloc.loadAddress(const LatLng(0.0, 0.0)),
    expect: () => [isA<AddressReadyState>()],
    verify: (bloc) {
      AddressReadyState state = bloc.state as AddressReadyState;

      expect(state.business, 'business');
      expect(state.address, 'address');
      expect(state.postalCode, 'postalCode');
      expect(state.countryCode, 'countryCode');
    },
  );
}
