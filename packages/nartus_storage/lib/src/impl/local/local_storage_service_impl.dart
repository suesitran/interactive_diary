part of '../../storage_service.dart';

class LocalStorageServiceImpl extends StorageService {
  LocalStorageServiceImpl({HiveLocalStorage? storage})
      : _hiveLocalStorage = storage ?? HiveLocalStorage(),
        super._(StorageType.local);

  final HiveLocalStorage _hiveLocalStorage;

  @override
  Future<bool> deleteDiary(int timestamp) =>
      _hiveLocalStorage.deleteDiary(timestamp);

  @override
  Future<DiaryCollection> readDiaryForMonth(DateTime month) =>
      _hiveLocalStorage.readDiaryForMonth(month);

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
  Future<User> getUserDetail(String uid) {
    try {
      return _hiveLocalStorage.getUserDetail(uid);
    } catch (e) {
      throw StorageException('Failed to get user with uid $uid');
    }
  }
}
