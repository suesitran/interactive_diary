import 'dart:math';

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:interactive_diary/features/home/bloc/load_diary_cubit.dart';
import 'package:interactive_diary/features/home/data/diary_display_content.dart';
import 'package:interactive_diary/service_locator/service_locator.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:nartus_storage/nartus_storage.dart';
import 'load_diary_cubit_test.mocks.dart';

@GenerateMocks([StorageService])
void main() {
  final MockStorageService storageService = MockStorageService();

  setUpAll(() {
    ServiceLocator.instance.registerSingleton<StorageService>(storageService);
  });

  setUp(() {});

  tearDown(() {
    reset(storageService);
  });

  blocTest(
    'verify initial state, no emit',
    build: () => LoadDiaryCubit(),
    expect: () => [],
    verify: (bloc) {
      LoadDiaryState state = bloc.state;

      expect(state, isA<LoadDiaryInitial>());
    },
  );

  blocTest(
    'given diary collection is blank, when load diary, then emit state with empty list',
    build: () => LoadDiaryCubit(),
    setUp: () {
      when(storageService.readDiaryForMonth(any)).thenAnswer((realInvocation) =>
          Future.value(const DiaryCollection(month: 'month', diaries: [])));
    },
    act: (bloc) => bloc.loadDiary(),
    expect: () => [isA<LoadDiaryCompleted>()],
    verify: (bloc) {
      LoadDiaryState state = bloc.state;
      expect(state, isA<LoadDiaryCompleted>());
      expect((state as LoadDiaryCompleted).contents.length, 0);
    },
  );

  blocTest('given diary collection has 1 text diary, when load diary, then verify content of text diary', build: () => LoadDiaryCubit(),
  setUp: () {
    when(storageService.readDiaryForMonth(any)).thenAnswer((realInvocation) => Future.value(DiaryCollection(month: 'month', diaries: [
      Diary(
        title: 'title',
        latLng: const LatLng(lat: 0.0, long: 0.0),
        timestamp: 123456789,
        update: 123456789, contents: [
          TextDiary(description: '[{"insert":"description\\n"}]')
      ]
      )
    ])));
  },
    act: (bloc) => bloc.loadDiary(),
    expect: () => [isA<LoadDiaryCompleted>()],
    verify: (bloc) {
      LoadDiaryCompleted state = bloc.state as LoadDiaryCompleted;

      expect(state.contents.length, 1);

      DiaryDisplayContent contents = state.contents.first;
      expect(contents.plainText, 'description');
    },
  );
}
