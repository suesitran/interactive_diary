import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nartus_storage/nartus_storage.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  const MethodChannel channel =
      MethodChannel('plugins.flutter.io/path_provider_macos');

  channel.setMockMethodCallHandler((MethodCall methodCall) async {
    return '/';
  });

  test('use LocalStorageServiceImpl when StorageService type is local', () {
    StorageService service = StorageService(StorageType.local);

    expect(service.type, StorageType.local);
    expect(service, isA<LocalStorageServiceImpl>());
  });

  test('use CloudStorageServiceImpl when StorageService type is cloud', () {
    StorageService service = StorageService(StorageType.cloud);

    expect(service.type, StorageType.cloud);
    expect(service, isA<CloudStorageServiceImpl>());
  });
}
