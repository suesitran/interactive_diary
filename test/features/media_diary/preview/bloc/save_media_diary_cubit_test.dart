import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:interactive_diary/features/media_diary/_shared/constant/media_type.dart';
import 'package:interactive_diary/features/media_diary/preview/bloc/save_media_diary_cubit.dart';
import 'package:interactive_diary/service_locator/service_locator.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:nartus_geocoder/nartus_geocoder.dart';
import 'package:nartus_storage/nartus_storage.dart';

import 'save_media_diary_cubit_test.mocks.dart';

@GenerateMocks([StorageService, GeocoderService])
void main() {
  final MockStorageService storageService = MockStorageService();
  final MockGeocoderService geocoderService = MockGeocoderService();

  const LatLng latLng = LatLng(lat: 0.0, long: 0.0);
  const String path = 'path';

  setUpAll(() {
    ServiceLocator.instance.registerSingleton<StorageService>(storageService);
    ServiceLocator.instance.registerSingleton<GeocoderService>(geocoderService);
  });

  blocTest(
    'given location detail without country code, when save diary, then save with country code Unknown',
    build: () => SaveMediaDiaryCubit(
        latLng: latLng, path: path, type: MediaType.picture),
    setUp: () {
      when(geocoderService.getCurrentPlaceCoding(0.0, 0.0)).thenAnswer(
          (realInvocation) => Future.value(LocationDetail(
              address: 'address',
              countryCode: null,
              postalCode: 'postalCode',
              business: 'business')));
    },
    act: (bloc) => bloc.save(),
    expect: () => [isA<SaveMediaDiaryStart>(), isA<SaveMediaDiaryComplete>()],
    verify: (bloc) {
      verify(storageService.saveDiary(any)).called(1);
    },
  );

  blocTest(
    'given location detail with country code, when save diary, then save with country code Unknown',
    build: () => SaveMediaDiaryCubit(
        latLng: latLng, path: path, type: MediaType.picture),
    setUp: () {
      when(geocoderService.getCurrentPlaceCoding(0.0, 0.0)).thenAnswer(
          (realInvocation) => Future.value(LocationDetail(
              address: 'address',
              countryCode: 'contryCode',
              postalCode: 'postalCode',
              business: 'business')));
    },
    act: (bloc) => bloc.save(),
    expect: () => [isA<SaveMediaDiaryStart>(), isA<SaveMediaDiaryComplete>()],
  );

  blocTest('given video content, when save diary, then save media file', build: () => SaveMediaDiaryCubit(latLng: latLng, path: path, type: MediaType.picture),
    setUp: () {
      when(geocoderService.getCurrentPlaceCoding(0.0, 0.0)).thenAnswer(
              (realInvocation) => Future.value(LocationDetail(
              address: 'address',
              countryCode: null,
              postalCode: 'postalCode',
              business: 'business')));
      when(storageService.saveMedia('path')).thenAnswer((realInvocation) => Future.value('newPath'));
    },
    act: (bloc) => bloc.save(),
    verify: (bloc) {
      verify(storageService.saveMedia('path'));
    },
  );
}
