import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:interactive_diary/features/writediary/bloc/write_diary_cubit.dart';
import 'package:interactive_diary/service_locator/service_locator.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:nartus_geocoder/nartus_geocoder.dart';
import 'package:nartus_storage/nartus_storage.dart';

import 'write_diary_cubit_test.mocks.dart';

@GenerateMocks(<Type>[StorageService, GeocoderService])
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  final MockStorageService storageService = MockStorageService();
  final MockGeocoderService geocoderService = MockGeocoderService();

  setUpAll(() {
    ServiceLocator.instance.registerSingleton<StorageService>(storageService);
    ServiceLocator.instance.registerSingleton<GeocoderService>(geocoderService);
  });

  group('Test save text diary', () {
    tearDown(() => reset(storageService));

    blocTest<WriteDiaryCubit, WriteDiaryState>(
      'given storage service, when saveDiary, then save diary to storage service',
      build: () => WriteDiaryCubit(),
      act: (WriteDiaryCubit bloc) => bloc.saveTextDiary(
          title: 'title',
          textContent: 'textContent',
          latLng: const LatLng(lat: 0.0, long: 0.0)),
      setUp: () {
        when(storageService.saveDiary(argThat(isA<Diary>())))
            .thenAnswer((_) => Future<void>.value(null));
        when(geocoderService.getCurrentPlaceCoding(any, any)).thenAnswer(
            (realInvocation) => Future.value(LocationDetail(
                address: 'address',
                countryCode: 'countryCode',
                postalCode: 'postalCode',
                business: 'business')));
      },
      seed: () => WriteDiaryInitial(),
      expect: () => <TypeMatcher<WriteDiaryState>>[
        isA<WriteDiaryStart>(),
        isA<WriteDiarySuccess>()
      ],
      verify: (WriteDiaryCubit bloc) =>
          verify(storageService.saveDiary(argThat(isA<Diary>()))),
    );
  });
}
