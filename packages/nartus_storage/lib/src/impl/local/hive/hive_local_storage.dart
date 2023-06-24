// ignore_for_file: depend_on_referenced_packages, implementation_imports
import 'dart:io';
import 'dart:typed_data';

import 'package:hive_flutter/adapters.dart';
import 'package:intl/intl.dart';
import 'package:nartus_storage/nartus_storage.dart';
import 'package:nartus_storage/src/impl/local/hive/hive_adapters.dart';
import 'package:path_provider/path_provider.dart';
import 'package:hive/src/box/default_key_comparator.dart';
import 'package:hive/src/box/default_compaction_strategy.dart';

import 'package:nartus_storage/src/exceptions/storage_exception.dart';

/// Actual implementation of local storage using Hive database
class HiveLocalStorage {
  final String _monthNameFormat = 'MMyyyy';

  final String _userBox = 'user';

  final HiveHelper _hiveHelper;
  HiveLocalStorage({HiveHelper? hiveHelper})
      : _hiveHelper = hiveHelper ?? HiveHelper() {
    _hiveHelper.init();
  }

  Future<bool> deleteDiary(
      {required String countryCode,
      required String postalCode,
      required int timestamp}) async {
    final Directory directory = await getApplicationSupportDirectory();

    final String monthCollectionName = _getCollectionName(timestamp);

    final BoxCollection collection = await _hiveHelper.open(
        _getLocationGroup(countryCode, postalCode),
        <String>{monthCollectionName},
        path: directory.path);

    CollectionBox<HiveDiary> diaryCollection =
        await collection.openBox<HiveDiary>(monthCollectionName);

    // find this diary in the box
    final String key = timestamp.toString();
    final HiveDiary? fromBox = await diaryCollection.get(key);

    bool result = false;
    if (fromBox != null) {
      await diaryCollection.delete(key);

      result = true;
    }

    collection.close();

    // diary not found in box, nothing to delete
    return result;
  }

  Future<DiaryCollection> readDiaryForMonth(
      {required String countryCode,
      required String postalCode,
      required DateTime month}) async {
    final Directory directory = await getApplicationSupportDirectory();

    final String monthCollectionName =
        _getCollectionName(month.millisecondsSinceEpoch);

    final BoxCollection collection = await _hiveHelper.open(
        _getLocationGroup(countryCode, postalCode),
        <String>{monthCollectionName},
        path: directory.path);

    CollectionBox<HiveDiary> diaryCollection =
        await collection.openBox<HiveDiary>(monthCollectionName);

    final Map<String, HiveDiary> allDiaries =
        await diaryCollection.getAllValues();

    final List<HiveDiary> diaries = allDiaries.values.toList()
      ..sort((HiveDiary a, HiveDiary b) => b.timestamp.compareTo(a.timestamp));

    final DiaryCollection result = DiaryCollection(
        month: monthCollectionName,
        diaries:
            diaries.map((HiveDiary e) => e.toDiary(directory.path)).toList());

    collection.close();

    return result;
  }

  Future<Diary?> getDiary(
      {required int dateTime,
      required String countryCode,
      required String postalCode,
      required DateTime month}) async {
    final Directory directory = await getApplicationSupportDirectory();

    final String monthCollectionName =
        _getCollectionName(month.millisecondsSinceEpoch);

    final BoxCollection collection = await _hiveHelper.open(
        _getLocationGroup(countryCode, postalCode),
        <String>{monthCollectionName},
        path: directory.path);

    CollectionBox<HiveDiary> diaryCollection =
        await collection.openBox<HiveDiary>(monthCollectionName);

    final Map<String, HiveDiary> allDiaries =
        await diaryCollection.getAllValues();

    Diary? diary;
    try {
      diary = allDiaries.values
          .toList()
          .firstWhere((HiveDiary d) => d.timestamp == dateTime)
          .toDiary(directory.path);
    } catch (e) {
      diary = null;
    }

    collection.close();

    return diary;
  }

  Future<void> saveDiary(Diary diary) async {
    final Directory directory = await getApplicationSupportDirectory();

    // save diary into month collection
    final String monthCollectionName = _getCollectionName(diary.timestamp);
    final BoxCollection collection = await _hiveHelper.open(
        _getLocationGroup(diary.countryCode, diary.postalCode),
        <String>{monthCollectionName},
        path: directory.path);

    // put this diary into collection
    CollectionBox<HiveDiary> diaries =
        await collection.openBox<HiveDiary>(monthCollectionName);

    diaries.put(diary.timestamp.toString(), HiveDiary.fromDiary(diary));

    collection.close();
  }

  String _getCollectionName(int millisecondsSinceEpoch) {
    DateTime dateTime =
        DateTime.fromMillisecondsSinceEpoch(millisecondsSinceEpoch);

    DateFormat dateFormat = DateFormat(_monthNameFormat);

    return dateFormat.format(dateTime);
  }

  String _getLocationGroup(String countryCode, String postalCode) =>
      '$countryCode-$postalCode';

  Future<bool> deleteUser(String uid) async {
    final Directory directory = await getApplicationSupportDirectory();

    final Box<HiveUser> userBox =
        await _hiveHelper.openBox(_userBox, path: directory.path);

    bool result = false;

    HiveUser? user = userBox.get(uid);

    if (user != null) {
      result = true;
      await userBox.delete(uid);
    }

    await userBox.close();

    return result;
  }

  Future<void> saveUserDetail(User user) async {
    final Directory directory = await getApplicationSupportDirectory();

    final Box<HiveUser> userBox =
        await _hiveHelper.openBox(_userBox, path: directory.path);

    HiveUser? hiveUser = userBox.get(user.uid);

    if (hiveUser != null) {
      await userBox.close();

      throw HiveError(
          'User is available in storage. Please use update user detail');
    }

    await userBox.put(user.uid, HiveUser.fromUser(user));

    await userBox.close();
  }

  Future<bool> updateUserDetail(User user) async {
    final Directory directory = await getApplicationSupportDirectory();

    final Box<HiveUser> userBox =
        await _hiveHelper.openBox(_userBox, path: directory.path);

    bool result = false;

    HiveUser? hiveUser = userBox.get(user.uid);

    if (hiveUser != null) {
      result = true;
      await userBox.put(user.uid, HiveUser.fromUser(user));
    }

    await userBox.close();
    return result;
  }

  Future<User> getUserDetail(String uid) async {
    final Directory directory = await getApplicationSupportDirectory();

    final Box<HiveUser> userBox =
        await _hiveHelper.openBox(_userBox, path: directory.path);

    HiveUser? hiveUser = userBox.get(uid);

    await userBox.close();

    if (hiveUser == null) {
      throw HiveError('User with $uid is not found in database');
    }
    return hiveUser.toUser();
  }

  Future<String> saveMedia(String temporaryPath) async {
    final Directory directory = await getApplicationSupportDirectory();
    String fileName = temporaryPath.split('/').last;

    File old = File(temporaryPath);

    if (!old.existsSync()) {
      throw FileNotFoundExcception();
    }

    old.copySync('${directory.path}/$fileName');

    return fileName;
  }
}

class HiveHelper {
  Future<void> init() async {
    final Directory directory = await getApplicationSupportDirectory();
    await Hive.initFlutter(directory.path);

    Hive.registerAdapter(HiveDiaryAdapter());
    Hive.registerAdapter(HiveLatLngAdapter());
    Hive.registerAdapter(HiveTextDiaryAdapter());
    Hive.registerAdapter(HiveImageDiaryAdapter());
    Hive.registerAdapter(HiveVideoDiaryAdapter());
    Hive.registerAdapter(HiveUserAdapter());
  }

  Future<BoxCollection> open(
    String name,
    Set<String> boxNames, {
    String? path,
    HiveCipher? key,
  }) =>
      BoxCollection.open(name, boxNames, path: path, key: key);

  Future<Box<E>> openBox<E>(
    String name, {
    HiveCipher? encryptionCipher,
    KeyComparator? keyComparator,
    CompactionStrategy? compactionStrategy,
    bool crashRecovery = true,
    String? path,
    Uint8List? bytes,
    String? collection,
  }) {
    return Hive.openBox(name,
        encryptionCipher: encryptionCipher,
        keyComparator: keyComparator ?? defaultKeyComparator,
        compactionStrategy: compactionStrategy ?? defaultCompactionStrategy,
        crashRecovery: crashRecovery,
        path: path,
        bytes: bytes,
        collection: collection);
  }
}
