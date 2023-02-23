import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_core_platform_interface/firebase_core_platform_interface.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:nartus_remote_config/remote_config_manager.dart';

import 'remote_config_manager_test.mocks.dart';

@GenerateMocks([FirebaseRemoteConfig])
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setupFirebaseCoreMocks();

  Firebase.initializeApp();

  final MockFirebaseRemoteConfig remoteConfig = MockFirebaseRemoteConfig();

  setUp(() {
    when(remoteConfig.fetchAndActivate()).thenAnswer((_) => Future.value(true));
  });

  test('test getValue - when debug option remote config is true, then return true', () {
    RemoteConfigManager manager = RemoteConfigManager(remoteConfig: remoteConfig);

    manager.init();

    when(remoteConfig.getBool('debug_option')).thenReturn(true);
    final result = manager.getValue(RemoteConfigKey.debugOption);

    expect(result, true);
  });

  test('test getValue - when debug option remote config is false, then return false', () {
    RemoteConfigManager manager = RemoteConfigManager(remoteConfig: remoteConfig);

    manager.init();

    when(remoteConfig.getBool('debug_option')).thenReturn(false);
    final result = manager.getValue(RemoteConfigKey.debugOption);

    expect(result, false);
  });
}
