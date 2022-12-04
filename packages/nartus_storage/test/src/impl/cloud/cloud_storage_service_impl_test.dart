import 'package:flutter_test/flutter_test.dart';
import 'package:nartus_storage/nartus_storage.dart';

void main() {
  // Cloud storage is not implemented yet, expect all methods to throw UnimplementedError
  test('expect all methods to throw UnimplementedError', () {
    CloudStorageServiceImpl cloudStorageServiceImpl = CloudStorageServiceImpl();

    expect(() async => await cloudStorageServiceImpl.deleteDiary(1234567),
        throwsA(isA<UnimplementedError>()));
    expect(() async => await cloudStorageServiceImpl.deleteUser('uid'),
        throwsA(isA<UnimplementedError>()));
    expect(
        () async => await cloudStorageServiceImpl
            .readDiaryForMonth(DateTime(2022, 10, 11)),
        throwsA(isA<UnimplementedError>()));
    expect(
        () async => await cloudStorageServiceImpl.saveDiary(Diary(
            timestamp: 12345677,
            latLng: const LatLng(lat: 0.0, long: 0.0),
            title: 'title',
            contents: <Content>[],
            update: 12345678)),
        throwsA(isA<UnimplementedError>()));
    expect(
        () async => await cloudStorageServiceImpl.saveUserDetail(const User(
            uid: 'uid', firstName: 'firstName', lastName: 'lastName')),
        throwsA(isA<UnimplementedError>()));
    expect(
        () async => await cloudStorageServiceImpl.updateUserDetail(const User(
            uid: 'uid', firstName: 'firstName', lastName: 'lastName')),
        throwsA(isA<UnimplementedError>()));
    expect(() async => await cloudStorageServiceImpl.getUserDetail('uid'),
        throwsA(isA<UnimplementedError>()));
  });
}
