import 'package:flutter_test/flutter_test.dart';
import 'package:nartus_storage/nartus_storage.dart';
import 'package:path_provider_platform_interface/path_provider_platform_interface.dart';

import 'src/impl/local/hive/fake_path_provider_platform_interface.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  PathProviderPlatform.instance = FakePathProviderPlatform();

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
