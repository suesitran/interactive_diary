part of '../../storage_service.dart';

class CloudStorageServiceImpl extends StorageService {
  CloudStorageServiceImpl() : super._(StorageType.cloud);

  @override
  Future<bool> deleteDiary(
      {required String countryCode,
      required String postalCode,
      required int timestamp}) {
    // TODO: implement deleteDiary
    throw UnimplementedError();
  }

  @override
  Future<bool> deleteUser(String uid) {
    // TODO: implement deleteUser
    throw UnimplementedError();
  }

  @override
  Future<DiaryCollection> readDiaryForMonth(
      {required String? countryCode,
      required String? postalCode,
      required DateTime month}) {
    // TODO: implement readDiaryForMonth
    throw UnimplementedError();
  }

  @override
  Future<Diary?> getDiary(
      {required DateTime dateTime,
      required String? countryCode,
      required String? postalCode}) {
    // TODO: implement getDiary
    throw UnimplementedError();
  }

  @override
  Future<void> saveDiary(Diary diary) {
    // TODO: implement saveDiary
    throw UnimplementedError();
  }

  @override
  Future<void> saveUserDetail(User user) {
    // TODO: implement saveUserDetail
    throw UnimplementedError();
  }

  @override
  Future<bool> updateUserDetail(User user) {
    // TODO: implement updateUserDetail
    throw UnimplementedError();
  }

  @override
  Future<User> getUserDetail(String uid) {
    // TODO: implement getUserDetail
    throw UnimplementedError();
  }

  @override
  Future<String> saveMedia(String temporaryPath) {
    // TODO: implement saveMedia
    throw UnimplementedError();
  }
}
