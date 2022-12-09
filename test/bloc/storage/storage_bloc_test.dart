import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:interactive_diary/bloc/storage/storage_bloc.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:nartus_storage/nartus_storage.dart';

import 'storage_bloc_test.mocks.dart';

@GenerateMocks(<Type>[StorageService])
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  final MockStorageService storageService = MockStorageService();

  group('Test RequestSaveTextDiaryEvent', () {
    tearDown(() => reset(storageService));

    blocTest<StorageBloc, StorageState>(
      'given ',
      build: () => StorageBloc(storageService: storageService),
      act: (StorageBloc bloc) => bloc.add(const RequestSaveTextDiaryEvent(
          title: 'title',
          textContent: 'textContent',
          latLng: LatLng(lat: 0.0, long: 0.0))),
      setUp: () => when(storageService.saveDiary(argThat(isA<Diary>())))
          .thenAnswer((_) => Future<void>.value(null)),
      seed: () => StorageInitial(),
      expect: () =>
          <TypeMatcher<StorageState>>[isA<StorageSaveTextDiarySuccess>()],
      verify: (StorageBloc bloc) =>
          verify(storageService.saveDiary(argThat(isA<Diary>()))),
    );
  });
}
