import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:interactive_diary/features/home/bloc/load_diary_cubit.dart';
import 'package:interactive_diary/features/home/data/diary_display_content.dart';
import 'package:interactive_diary/service_locator/service_locator.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:nartus_authentication/nartus_authentication.dart';
import 'package:nartus_storage/nartus_storage.dart';
import 'load_diary_cubit_test.mocks.dart';

@GenerateMocks([StorageService, AuthenticationService])
void main() {
  final MockStorageService storageService = MockStorageService();
  final MockAuthenticationService authenticationService =
      MockAuthenticationService();

  setUpAll(() {
    ServiceLocator.instance.registerSingleton<StorageService>(storageService);
    ServiceLocator.instance
        .registerSingleton<AuthenticationService>(authenticationService);
  });

  setUp(() {
    when(authenticationService.getCurrentUser())
        .thenThrow(AuthenticationException('not found'));
  });

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
      when(storageService.readDiaryForMonth(
              month: anyNamed('month'),
              countryCode: anyNamed('countryCode'),
              postalCode: anyNamed('postalCode')))
          .thenAnswer((realInvocation) =>
              Future.value(const DiaryCollection(month: 'month', diaries: [])));
    },
    act: (bloc) => bloc.loadDiary(countryCode: 'AU', postalCode: '2345'),
    expect: () => [isA<LoadDiaryCompleted>()],
    verify: (bloc) {
      LoadDiaryState state = bloc.state;
      expect(state, isA<LoadDiaryCompleted>());
      expect((state as LoadDiaryCompleted).contents.length, 0);
    },
  );

  blocTest(
    'given diary collection has 1 text diary, when load diary, then verify content of text diary',
    build: () => LoadDiaryCubit(),
    setUp: () {
      when(storageService.readDiaryForMonth(
              month: anyNamed('month'),
              countryCode: anyNamed('countryCode'),
              postalCode: anyNamed('postalCode')))
          .thenAnswer((realInvocation) =>
              Future.value(DiaryCollection(month: 'month', diaries: [
                Diary(
                    title: 'title',
                    countryCode: 'AU',
                    postalCode: '2345',
                    addressLine: '123 heaven street',
                    latLng: const LatLng(lat: 0.0, long: 0.0),
                    timestamp: 123456789,
                    update: 123456789,
                    contents: [
                      TextDiary(description: '[{"insert":"description\\n"}]')
                    ])
              ])));
    },
    act: (bloc) => bloc.loadDiary(countryCode: 'AU', postalCode: '2345'),
    expect: () => [isA<LoadDiaryCompleted>()],
    verify: (bloc) {
      LoadDiaryCompleted state = bloc.state as LoadDiaryCompleted;

      expect(state.contents.length, 1);

      DiaryDisplayContent contents = state.contents.first;
      expect(contents.plainText?.trim(), 'description');
    },
  );

  blocTest(
    'given diary collection has image diary, when load diary, then verify imageUrl is not empty',
    build: () => LoadDiaryCubit(),
    setUp: () {
      when(storageService.readDiaryForMonth(
              month: anyNamed('month'),
              countryCode: anyNamed('countryCode'),
              postalCode: anyNamed('postalCode')))
          .thenAnswer((realInvocation) =>
              Future.value(DiaryCollection(month: 'month', diaries: [
                Diary(
                    title: 'title',
                    countryCode: 'AU',
                    postalCode: '2345',
                    addressLine: '123 heaven street',
                    latLng: const LatLng(lat: 0.0, long: 0.0),
                    timestamp: 123456789,
                    update: 123456789,
                    contents: [
                      ImageDiary(
                          url: 'imageUrl',
                          thumbnailUrl: 'thumbnailUrl',
                          description: 'description')
                    ])
              ])));
    },
    act: (bloc) => bloc.loadDiary(countryCode: 'AU', postalCode: '2345'),
    expect: () => [isA<LoadDiaryCompleted>()],
    verify: (bloc) {
      LoadDiaryCompleted state = bloc.state as LoadDiaryCompleted;

      expect(state.contents.length, 1);

      DiaryDisplayContent contents = state.contents.first;
      expect(contents.mediaInfos.length, 1);
    },
  );

  blocTest(
    'given diary collection has image diary, when load diary, then verify imageUrl is not empty',
    build: () => LoadDiaryCubit(),
    setUp: () {
      when(authenticationService.getCurrentUser()).thenAnswer(
          (realInvocation) =>
              Future.value(UserDetail(name: 'name', avatarUrl: 'avatarurl')));
      when(storageService.readDiaryForMonth(
              month: anyNamed('month'),
              countryCode: anyNamed('countryCode'),
              postalCode: anyNamed('postalCode')))
          .thenAnswer((realInvocation) =>
              Future.value(DiaryCollection(month: 'month', diaries: [
                Diary(
                    title: 'title',
                    countryCode: 'AU',
                    postalCode: '2345',
                    addressLine: '123 heaven street',
                    latLng: const LatLng(lat: 0.0, long: 0.0),
                    timestamp: 123456789,
                    update: 123456789,
                    contents: [
                      ImageDiary(
                          url: 'imageUrl',
                          thumbnailUrl: 'thumbnailUrl',
                          description: 'description')
                    ])
              ])));
    },
    act: (bloc) => bloc.loadDiary(countryCode: 'AU', postalCode: '2345'),
    expect: () => [isA<LoadDiaryCompleted>()],
    verify: (bloc) {
      LoadDiaryCompleted state = bloc.state as LoadDiaryCompleted;

      expect(state.contents.length, 1);

      DiaryDisplayContent contents = state.contents.first;
      expect(contents.userDisplayName, 'name');
      expect(contents.userPhotoUrl, 'avatarurl');
    },
  );
}
