import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:interactive_diary/features/diary_detail/bloc/diary_display_content_cubit.dart';
import 'package:interactive_diary/service_locator/service_locator.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:nartus_storage/nartus_storage.dart';

import 'diary_display_content_cubit_test.mocks.dart';

@GenerateMocks([StorageService])
void main() {
  final MockStorageService mockStorageService = MockStorageService();

  setUpAll(() {
    ServiceLocator.instance.registerSingleton<StorageService>(
        mockStorageService);
  });

  setUp(() {});

  tearDown(() {
    reset(mockStorageService);
  });

  blocTest(
    'verify initial state, no emit',
    build: () => DiaryDisplayContentCubit(),
    expect: () => [],
    verify: (bloc) {
      DiaryDisplayContentState state = bloc.state;

      expect(state, isA<DiaryDisplayContentInitial>());
    },
  );

  blocTest(
    'given get diary returns null, then emit not found',
    build: () => DiaryDisplayContentCubit(),
    setUp: () {
      when(mockStorageService.getDiary(
          dateTime: anyNamed('dateTime'),
          month: anyNamed('month'),
          countryCode: anyNamed('countryCode'),
          postalCode: anyNamed('postalCode')))
          .thenAnswer((realInvocation) =>
          Future.value(null));
    },
    act: (cubit) => cubit.fetchDiaryDisplayContent(123434, 'US', '1321412'),
    expect: () =>
    [
      isA<DiaryDisplayContentNotFound>()
    ],
    verify: (bloc) {
      DiaryDisplayContentState state = bloc.state;
      expect(state, isA<DiaryDisplayContentNotFound>());
    },
  );

  blocTest(
    'given get diary returns diary, then emit success',
    build: () => DiaryDisplayContentCubit(),
    setUp: () {
      when(mockStorageService.getDiary(
          dateTime: anyNamed('dateTime'),
          month: anyNamed('month'),
          countryCode: anyNamed('countryCode'),
          postalCode: anyNamed('postalCode')))
          .thenAnswer((realInvocation) =>
          Future.value( Diary(
              title: 'title',
              countryCode: 'AU',
              postalCode: '2345',
              addressLine: '123 heaven street',
              latLng: const LatLng(lat: 0.0, long: 0.0),
              timestamp: 123456789,
              update: 123456789,
              contents: [
                TextDiary(description: '[{"insert":"description\\n"}]')
              ])));
      },
    act: (cubit) => cubit.fetchDiaryDisplayContent(123434, 'US', '1321412'),
    expect: () =>
    [
      isA<DiaryDisplayContentSuccess>()
    ],
    verify: (bloc) {
      DiaryDisplayContentState state = bloc.state;
      expect(state, isA<DiaryDisplayContentSuccess>());
      expect((state as DiaryDisplayContentSuccess).content.plainText, 'description');
    },
  );
}