import 'dart:io';

import 'package:hive_flutter/adapters.dart';
import 'package:intl/intl.dart';
import 'package:nartus_storage/nartus_storage.dart';
import 'package:nartus_storage/src/impl/local/hive/hive_adapters.dart';
import 'package:path_provider/path_provider.dart';

/// Actual implementation of local storage using Hive database
class HiveLocalStorage {
  final String _diariesByMonthCollection = 'diariesByMonth';
  final String _monthNameFormat = 'MMyyyy';

  final String _userBox = 'user';

  HiveLocalStorage() {
    _init();
  }

  Future<void> _init() async {
    final Directory directory = await getApplicationSupportDirectory();
    await Hive.initFlutter(directory.path);

    Hive.registerAdapter(HiveDiaryAdapter());
    Hive.registerAdapter(HiveLatLngAdapter());
    Hive.registerAdapter(HiveTextDiaryAdapter());
    Hive.registerAdapter(HiveImageDiaryAdapter());
    Hive.registerAdapter(HiveVideoDiaryAdapter());
    Hive.registerAdapter(HiveUserAdapter());
  }

  Future<bool> deleteDiary(int timestamp) async {
    final Directory directory = await getApplicationSupportDirectory();

    final String monthCollectionName = _getCollectionName(timestamp);

    final BoxCollection collection = await BoxCollection.open(
        _diariesByMonthCollection, <String>{monthCollectionName},
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

  Future<DiaryCollection> readDiaryForMonth(DateTime month) async {
    final Directory directory = await getApplicationSupportDirectory();

    final String monthCollectionName =
        _getCollectionName(month.millisecondsSinceEpoch);

    final BoxCollection collection = await BoxCollection.open(
        _diariesByMonthCollection, <String>{monthCollectionName},
        path: directory.path);

    CollectionBox<HiveDiary> diaryCollection =
        await collection.openBox<HiveDiary>(monthCollectionName);

    final Map<String, HiveDiary> allDiaries =
        await diaryCollection.getAllValues();

    final List<HiveDiary> diaries = allDiaries.values.toList();

    final DiaryCollection result = DiaryCollection(
        month: monthCollectionName,
        diaries: diaries.map((HiveDiary e) => e.toDiary()).toList());

    collection.close();

    return result;
  }

  Future<void> saveDiary(Diary diary) async {
    final Directory directory = await getApplicationSupportDirectory();

    // save diary into month collection
    final String monthCollectionName = _getCollectionName(diary.timestamp);
    final BoxCollection collection = await BoxCollection.open(
        _diariesByMonthCollection, <String>{monthCollectionName},
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

  Future<bool> deleteUser(String uid) async {
    final Directory directory = await getApplicationSupportDirectory();

    final Box<HiveUser> userBox =
        await Hive.openBox(_userBox, path: directory.path);

    bool result = false;

    HiveUser? user = userBox.get(uid);

    if (user != null) {
      result = true;
      await userBox.delete(uid);
    }

    return result;
  }

  Future<void> saveUserDetail(User user) async {
    final Directory directory = await getApplicationSupportDirectory();

    final Box<HiveUser> userBox =
        await Hive.openBox(_userBox, path: directory.path);

    HiveUser? hiveUser = userBox.get(user.uid);

    if (hiveUser != null) {
      throw HiveError(
          'User is available in storage. Please use update user detail');
    }

    await userBox.put(user.uid, HiveUser.fromUser(user));
  }

  Future<bool> updateUserDetail(User user) async {
    final Directory directory = await getApplicationSupportDirectory();

    final Box<HiveUser> userBox =
        await Hive.openBox(_userBox, path: directory.path);

    bool result = false;

    HiveUser? hiveUser = userBox.get(user.uid);

    if (hiveUser != null) {
      result = true;
      await userBox.delete(user.uid);
    }

    return result;
  }

  Future<User> getUserDetail(String uid) async {
    final Directory directory = await getApplicationSupportDirectory();

    final Box<HiveUser> userBox =
        await Hive.openBox(_userBox, path: directory.path);

    HiveUser? hiveUser = userBox.get(uid);

    if (hiveUser == null) {
      throw HiveError('User with $uid is not found in database');
    }

    return hiveUser.toUser();
  }
}
