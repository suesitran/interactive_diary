import 'package:flutter_test/flutter_test.dart';
import 'package:nartus_storage/nartus_storage.dart';

void main() {
  // Cloud storage is not implemented yet, expect all methods to throw UnimplementedError
  test('expect all methods to throw UnimplementedError', () {
    CloudStorageServiceImpl cloudStorageServiceImpl = CloudStorageServiceImpl();

    expect(
        () async => await cloudStorageServiceImpl.deleteDiary(
            timestamp: 1234567, countryCode: 'AU', postalCode: '2345'),
        throwsA(isA<UnimplementedError>()));
    expect(() async => await cloudStorageServiceImpl.deleteUser('uid'),
        throwsA(isA<UnimplementedError>()));
    expect(
        () async => await cloudStorageServiceImpl.readDiaryForMonth(
            month: DateTime(2022, 10, 11),
            countryCode: 'AU',
            postalCode: '2345'),
        throwsA(isA<UnimplementedError>()));
    expect(
        () async => await cloudStorageServiceImpl.getDiary(
            dateTime: DateTime(2022, 10, 11),
            countryCode: 'AU',
            postalCode: '2345'),
        throwsA(isA<UnimplementedError>()));
    expect(
        () async => await cloudStorageServiceImpl.saveDiary(Diary(
            timestamp: 12345677,
            countryCode: 'AU',
            postalCode: '2345',
            addressLine: '123 heaven street',
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
    expect(() async => await cloudStorageServiceImpl.saveMedia('path'),
        throwsA(isA<UnimplementedError>()));
  });
}
