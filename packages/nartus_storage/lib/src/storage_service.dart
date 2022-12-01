import 'package:nartus_storage/src/data/diary.dart';
import 'package:nartus_storage/src/data/user.dart';
import 'package:nartus_storage/src/impl/local/hive/hive_local_storage.dart';

part 'impl/local/local_storage_service_impl.dart';
part 'impl/cloud/cloud_storage_service_impl.dart';

enum Type { local, cloud }

class StorageException implements Exception {
  final String message;

  StorageException(this.message);
}

abstract class StorageService {
  StorageService._(this.type);

  factory StorageService(Type type) {
    switch (type) {
      case Type.local:
        return LocalStorageServiceImpl();
      case Type.cloud:
        return CloudStorageServiceImpl();
    }
  }

  /// implementation
  final Type type;

  /// Diary implementation
  Future<void> saveDiary(Diary diary);

  Future<DiaryCollection> readDiaryForMonth(DateTime month);

  Future<bool> deleteDiary(int timestamp);

  /// user implementation
  Future<void> saveUserDetail(User user);

  Future<User> getUserDetail(String uid);

  Future<bool> deleteUser(String uid);

  Future<bool> updateUserDetail(User user);
}
