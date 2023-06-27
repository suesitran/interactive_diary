import 'package:flutter_test/flutter_test.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:nartus_storage/nartus_storage.dart';
import 'package:nartus_storage/src/impl/local/hive/hive_local_storage.dart';

import 'local_storage_service_impl_test.mocks.dart';

@GenerateMocks(<Type>[HiveLocalStorage])
void main() {
  final HiveLocalStorage storage = MockHiveLocalStorage();

  test(
      'when deleteUser with uid, then call hiveStorage to remove user with uid',
      () {
    LocalStorageServiceImpl localStorageServiceImpl =
        LocalStorageServiceImpl(storage: storage);

    when(storage.deleteUser('uid'))
        .thenAnswer((Invocation realInvocation) => Future<bool>.value(true));
    localStorageServiceImpl.deleteUser('uid');

    verify(storage.deleteUser('uid')).called(1);
  });

  test(
      'when read diary collection for month, then call hiveStorage to query data',
      () {
    LocalStorageServiceImpl localStorageServiceImpl =
        LocalStorageServiceImpl(storage: storage);

    final DateTime dateTime = DateTime(2022, 10, 20);
    when(storage.readDiaryForMonth(
            month: dateTime, countryCode: 'AU', postalCode: '2345'))
        .thenAnswer((Invocation realInvocation) =>
            Future<DiaryCollection>.value(
                const DiaryCollection(month: '102022', diaries: <Diary>[])));
    localStorageServiceImpl.readDiaryForMonth(
        month: dateTime, countryCode: 'AU', postalCode: '2345');

    verify(storage.readDiaryForMonth(
            month: dateTime, countryCode: 'AU', postalCode: '2345'))
        .called(1);
  });

  test('when get diary, then call hiveStorage to query data', () {
    LocalStorageServiceImpl localStorageServiceImpl =
        LocalStorageServiceImpl(storage: storage);

    final DateTime dateTime = DateTime(2022, 10, 20, 0, 0, 0, 0);
    when(storage.getDiary(
            dateTime: dateTime.millisecondsSinceEpoch,
            month: dateTime,
            countryCode: 'AU',
            postalCode: '2345'))
        .thenAnswer((Invocation realInvocation) => Future<Diary?>.value(Diary(
            timestamp: 1666224000000,
            countryCode: 'AU',
            postalCode: '2345',
            addressLine: '123 heaven street',
            latLng: const LatLng(lat: 0.0, long: 0.0),
            title: 'title',
            contents: <Content>[],
            update: 1666224000000)));
    localStorageServiceImpl.getDiary(
        dateTime: dateTime, countryCode: 'AU', postalCode: '2345');

    verify(storage.getDiary(
            dateTime: dateTime.millisecondsSinceEpoch,
            month: dateTime,
            countryCode: 'AU',
            postalCode: '2345'))
        .called(1);
  });

  test('when save diary, then call hiveStorage to save data', () {
    LocalStorageServiceImpl localStorageServiceImpl =
        LocalStorageServiceImpl(storage: storage);

    Diary diary = Diary(
        timestamp: 123456,
        countryCode: 'AU',
        postalCode: '2345',
        addressLine: '123 heaven street',
        latLng: const LatLng(long: 0.0, lat: 0.0),
        title: 'title',
        contents: <Content>[TextDiary(description: 'description')],
        update: 123456);
    when(storage.saveDiary(diary)).thenAnswer((Invocation realInvocation) =>
        Future<DiaryCollection>.value(
            const DiaryCollection(month: '102022', diaries: <Diary>[])));
    localStorageServiceImpl.saveDiary(diary);

    verify(storage.saveDiary(diary)).called(1);
  });

  test('when delete diary, then call hiveStorage to delete data', () {
    LocalStorageServiceImpl localStorageServiceImpl =
        LocalStorageServiceImpl(storage: storage);

    when(storage.deleteDiary(
            timestamp: 123456, countryCode: 'AU', postalCode: '2345'))
        .thenAnswer((Invocation realInvocation) => Future<bool>.value(true));
    localStorageServiceImpl.deleteDiary(
        timestamp: 123456, countryCode: 'AU', postalCode: '2345');

    verify(storage.deleteDiary(
            timestamp: 123456, countryCode: 'AU', postalCode: '2345'))
        .called(1);
  });

  test('when save user, then call hiveStorage to save data', () {
    LocalStorageServiceImpl localStorageServiceImpl =
        LocalStorageServiceImpl(storage: storage);

    User user =
        const User(uid: 'uid', firstName: 'firstName', lastName: 'lastName');
    when(storage.saveUserDetail(user))
        .thenAnswer((Invocation realInvocation) => Future<bool>.value(true));
    localStorageServiceImpl.saveUserDetail(user);

    verify(storage.saveUserDetail(user)).called(1);
  });

  test('when update user, then call hiveStorage to update data', () {
    LocalStorageServiceImpl localStorageServiceImpl =
        LocalStorageServiceImpl(storage: storage);

    User user =
        const User(uid: 'uid', firstName: 'firstName', lastName: 'lastName');
    when(storage.updateUserDetail(user))
        .thenAnswer((Invocation realInvocation) => Future<bool>.value(true));
    localStorageServiceImpl.updateUserDetail(user);

    verify(storage.updateUserDetail(user)).called(1);
  });

  test('when delete user, then call hiveStorage to delete data', () {
    LocalStorageServiceImpl localStorageServiceImpl =
        LocalStorageServiceImpl(storage: storage);

    when(storage.deleteUser('uid'))
        .thenAnswer((Invocation realInvocation) => Future<bool>.value(true));
    localStorageServiceImpl.deleteUser('uid');

    verify(storage.deleteUser('uid')).called(1);
  });

  test(
      'given hive throw exception, when save user data, then throw storage exception',
      () {
    LocalStorageServiceImpl localStorageServiceImpl =
        LocalStorageServiceImpl(storage: storage);

    User user =
        const User(uid: 'uid', firstName: 'firstName', lastName: 'lastName');
    when(storage.saveUserDetail(user)).thenThrow(HiveError('error'));

    expect(() => localStorageServiceImpl.saveUserDetail(user),
        throwsA(isA<StorageException>()));
  });

  test(
      'given hive throw exception, when get user data, then throw storage exception',
      () {
    LocalStorageServiceImpl localStorageServiceImpl =
        LocalStorageServiceImpl(storage: storage);

    when(storage.getUserDetail('uid')).thenThrow(HiveError('error'));

    expect(() => localStorageServiceImpl.getUserDetail('uid'),
        throwsA(isA<StorageException>()));
  });
}
