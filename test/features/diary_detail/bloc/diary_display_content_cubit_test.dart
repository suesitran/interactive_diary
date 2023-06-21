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
    ServiceLocator.instance
        .registerSingleton<StorageService>(mockStorageService);
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
              countryCode: anyNamed('countryCode'),
              postalCode: anyNamed('postalCode')))
          .thenAnswer((realInvocation) => Future.value(null));
    },
    act: (cubit) => cubit.fetchDiaryDisplayContent(
        DateTime(2023, 10, 22, 10, 25), 'US', '1321412'),
    expect: () => [isA<DiaryDisplayContentNotFound>()],
    verify: (bloc) {
      DiaryDisplayContentState state = bloc.state;
      expect(state, isA<DiaryDisplayContentNotFound>());
    },
  );

  blocTest(
    'given get diary returns Text diary, then emit TextDiaryContent',
    build: () => DiaryDisplayContentCubit(),
    setUp: () {
      when(mockStorageService.getDiary(
              dateTime: anyNamed('dateTime'),
              countryCode: anyNamed('countryCode'),
              postalCode: anyNamed('postalCode')))
          .thenAnswer((realInvocation) => Future.value(Diary(
                  title: 'title',
                  countryCode: 'AU',
                  postalCode: '2345',
                  addressLine: '123 heaven street',
                  latLng: const LatLng(lat: 0.0, long: 0.0),
                  timestamp: DateTime(1970, 01, 02, 20, 17, 36, 789)
                      .toUtc()
                      .millisecondsSinceEpoch,
                  update: DateTime(1970, 01, 02, 20, 17, 36, 789)
                      .toUtc()
                      .millisecondsSinceEpoch,
                  contents: [
                    TextDiary(description: '[{"insert":"description\\n"}]')
                  ])));
    },
    act: (cubit) => cubit.fetchDiaryDisplayContent(
        DateTime(2023, 10, 22, 10, 25), 'US', '1321412'),
    expect: () => [isA<TextDiaryContent>()],
    verify: (bloc) {
      final TextDiaryContent state = bloc.state as TextDiaryContent;

      expect(state.jsonContent, '[{"insert":"description\\n"}]');
      expect(state.photoUrl, null);
      expect(state.displayName, null);
      expect(state.dateTime, DateTime(1970, 01, 02, 20, 17, 36, 789));
    },
  );

  blocTest(
    'given get diary returns Image diary, then emit ImageDiaryContent',
    build: () => DiaryDisplayContentCubit(),
    setUp: () {
      when(mockStorageService.getDiary(
              dateTime: anyNamed('dateTime'),
              countryCode: anyNamed('countryCode'),
              postalCode: anyNamed('postalCode')))
          .thenAnswer((realInvocation) => Future.value(Diary(
                  title: 'title',
                  countryCode: 'AU',
                  postalCode: '2345',
                  addressLine: '123 heaven street',
                  latLng: const LatLng(lat: 0.0, long: 0.0),
                  timestamp: DateTime(1970, 01, 02, 20, 17, 36, 789)
                      .toUtc()
                      .millisecondsSinceEpoch,
                  update: DateTime(1970, 01, 02, 20, 17, 36, 789)
                      .toUtc()
                      .millisecondsSinceEpoch,
                  contents: [
                    ImageDiary(
                        url: 'url',
                        thumbnailUrl: 'thumbnailUrl',
                        description: 'description')
                  ])));
    },
    act: (cubit) => cubit.fetchDiaryDisplayContent(
        DateTime(2023, 10, 22, 10, 25), 'US', '1321412'),
    expect: () => [isA<ImageDiaryContent>()],
    verify: (bloc) {
      final ImageDiaryContent state = bloc.state as ImageDiaryContent;

      expect(state.imagePath, 'url');
      expect(state.photoUrl, null);
      expect(state.displayName, null);
      expect(state.dateTime, DateTime(1970, 01, 02, 20, 17, 36, 789));
    },
  );

  blocTest(
    'given get diary returns Video diary, then emit VideoDiaryContent',
    build: () => DiaryDisplayContentCubit(),
    setUp: () {
      when(mockStorageService.getDiary(
              dateTime: anyNamed('dateTime'),
              countryCode: anyNamed('countryCode'),
              postalCode: anyNamed('postalCode')))
          .thenAnswer((realInvocation) => Future.value(Diary(
                  title: 'title',
                  countryCode: 'AU',
                  postalCode: '2345',
                  addressLine: '123 heaven street',
                  latLng: const LatLng(lat: 0.0, long: 0.0),
                  timestamp: DateTime(1970, 01, 02, 20, 17, 36, 789)
                      .toUtc()
                      .millisecondsSinceEpoch,
                  update: DateTime(1970, 01, 02, 20, 17, 36, 789)
                      .toUtc()
                      .millisecondsSinceEpoch,
                  contents: [
                    VideoDiary(
                        url: 'url',
                        description: 'description',
                        thumbnail: 'thumbnail')
                  ])));
    },
    act: (cubit) => cubit.fetchDiaryDisplayContent(
        DateTime(2023, 10, 22, 10, 25), 'US', '1321412'),
    expect: () => [isA<VideoDiaryContent>()],
    verify: (bloc) {
      final VideoDiaryContent state = bloc.state as VideoDiaryContent;

      expect(state.videoPath, 'url');
      expect(state.photoUrl, null);
      expect(state.displayName, null);
      expect(state.dateTime, DateTime(1970, 01, 02, 20, 17, 36, 789));
    },
  );
}
