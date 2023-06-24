part of '../../storage_service.dart';

class LocalStorageServiceImpl extends StorageService {
  LocalStorageServiceImpl({HiveLocalStorage? storage})
      : _hiveLocalStorage = storage ?? HiveLocalStorage(),
        super._(StorageType.local);

  final HiveLocalStorage _hiveLocalStorage;

  @override
  Future<bool> deleteDiary(
          {required String countryCode,
          required String postalCode,
          required int timestamp}) =>
      _hiveLocalStorage.deleteDiary(
          countryCode: countryCode,
          postalCode: postalCode,
          timestamp: timestamp);

  @override
  Future<DiaryCollection> readDiaryForMonth(
          {required String? countryCode,
          required String? postalCode,
          required DateTime month}) =>
      _hiveLocalStorage.readDiaryForMonth(
          countryCode: countryCode ?? defaultCountryCode,
          postalCode: postalCode ?? defaultPostalCode,
          month: month);

  @override
  Future<Diary?> getDiary(
          {required DateTime dateTime,
          required String? countryCode,
          required String? postalCode}) =>
      _hiveLocalStorage.getDiary(
          dateTime: dateTime.millisecondsSinceEpoch,
          countryCode: countryCode ?? defaultCountryCode,
          postalCode: postalCode ?? defaultPostalCode,
          month: dateTime);

  @override
  Future<void> saveDiary(Diary diary) => _hiveLocalStorage.saveDiary(diary);

  @override
  Future<bool> deleteUser(String uid) => _hiveLocalStorage.deleteUser(uid);

  @override
  Future<void> saveUserDetail(User user) async {
    try {
      await _hiveLocalStorage.saveUserDetail(user);
    } catch (e) {
      throw StorageException('Failed to save user detail');
    }
  }

  @override
  Future<bool> updateUserDetail(User user) =>
      _hiveLocalStorage.updateUserDetail(user);

  @override
  Future<String> saveMedia(String temporaryPath) =>
      _hiveLocalStorage.saveMedia(temporaryPath);
  @override
  Future<User> getUserDetail(String uid) {
    try {
      return _hiveLocalStorage.getUserDetail(uid);
    } catch (e) {
      throw StorageException('Failed to get user with uid $uid');
    }
  }
}
