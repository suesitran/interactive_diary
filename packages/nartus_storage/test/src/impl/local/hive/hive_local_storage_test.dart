// ignore_for_file: depend_on_referenced_packages
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:nartus_storage/src/data/diary.dart';
import 'package:nartus_storage/src/impl/local/hive/hive_adapters.dart';
import 'package:nartus_storage/src/impl/local/hive/hive_local_storage.dart';
import 'package:hive/src/box_collection/box_collection_stub.dart'
    as implementation;

import 'hive_local_storage_test.mocks.dart';

@GenerateMocks(<Type>[HiveHelper, CollectionBox, HiveDiary])
final CollectionBox<HiveDiary> collectionBox = MockCollectionBox<HiveDiary>();

class MockBoxCollection extends Mock implements BoxCollection {
  @override
  Future<CollectionBox<HiveDiary>> openBox<HiveDiary>(String name,
          {bool preload = false,
          implementation.CollectionBox<HiveDiary> Function(
                  String p1, BoxCollection p2)?
              boxCreator}) =>
      Future<CollectionBox<HiveDiary>>.value(
          collectionBox as CollectionBox<HiveDiary>);
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  const MethodChannel channel =
      MethodChannel('plugins.flutter.io/path_provider_macos');

  channel.setMockMethodCallHandler((MethodCall methodCall) async {
    return '/';
  });

  final HiveHelper hiveHelper = MockHiveHelper();
  final BoxCollection boxCollection = MockBoxCollection();
  final HiveDiary hiveDiary = MockHiveDiary();

  const int timestamp = 12345678;
  const String boxName = '011970';
  const String name = 'diariesByMonth';

  test(
      'given timestamp for diary not found, when delete diary, then return false',
      () async {
    when(hiveHelper.open(name, <String>{boxName}, path: '/')).thenAnswer(
        (Invocation realInvocation) =>
            Future<BoxCollection>.value(boxCollection));
    when(collectionBox.get(timestamp.toString())).thenAnswer(
        (Invocation realInvocation) => Future<HiveDiary?>.value(null));

    HiveLocalStorage hiveLocalStorage =
        HiveLocalStorage(hiveHelper: hiveHelper);

    final bool result = await hiveLocalStorage.deleteDiary(timestamp);

    expect(result, false);

    // ensure that diary is deleted in collectionBox
    verify(collectionBox.delete(timestamp.toString())).called(1);

    // ensure to close collection
    verify(boxCollection.close()).called(1);
  });

  test(
      'given timestamp for diary is found, when delete diary, then return true',
      () async {
    when(hiveHelper.open(name, <String>{boxName}, path: '/')).thenAnswer(
        (Invocation realInvocation) =>
            Future<BoxCollection>.value(boxCollection));
    when(collectionBox.get(timestamp.toString())).thenAnswer(
        (Invocation realInvocation) => Future<HiveDiary?>.value(hiveDiary));

    HiveLocalStorage hiveLocalStorage =
        HiveLocalStorage(hiveHelper: hiveHelper);

    final bool result = await hiveLocalStorage.deleteDiary(timestamp);

    expect(result, true);
    // ensure to close collection
    verify(boxCollection.close()).called(1);
  });

  test(
      'given diary for month is not available, when readDiaryForMonth, then return empty list',
      () async {
    when(hiveHelper.open(name, <String>{'112022'}, path: '/')).thenAnswer(
        (Invocation realInvocation) =>
            Future<BoxCollection>.value(boxCollection));
    when(collectionBox.getAllValues()).thenAnswer((Invocation realInvocation) =>
        Future<Map<String, HiveDiary>>.value(<String, HiveDiary>{}));

    HiveLocalStorage hiveLocalStorage =
        HiveLocalStorage(hiveHelper: hiveHelper);

    DateTime month = DateTime(2022, 11, 11);
    final DiaryCollection result =
        await hiveLocalStorage.readDiaryForMonth(month);

    expect(result.month, '112022');
    expect(result.diaries.length, 0);
  });

  test(
      'given diary for month has single entry, when readDiaryForMonth, then return list with 1 entry',
      () async {
    when(hiveHelper.open(name, <String>{'112022'}, path: '/')).thenAnswer(
        (Invocation realInvocation) =>
            Future<BoxCollection>.value(boxCollection));
    when(collectionBox.getAllValues()).thenAnswer((Invocation realInvocation) =>
        Future<Map<String, HiveDiary>>.value(
            <String, HiveDiary>{'1234566': hiveDiary}));
    when(hiveDiary.toDiary()).thenAnswer((Invocation realInvocation) => Diary(
        timestamp: timestamp,
        latLng: const LatLng(lat: 0.0, long: 0.0),
        title: 'title',
        contents: <Content>[],
        update: timestamp));

    HiveLocalStorage hiveLocalStorage =
        HiveLocalStorage(hiveHelper: hiveHelper);

    DateTime month = DateTime(2022, 11, 11);
    final DiaryCollection result =
        await hiveLocalStorage.readDiaryForMonth(month);

    expect(result.month, '112022');
    expect(result.diaries.length, 1);
  });
}
