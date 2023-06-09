import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_core_platform_interface/firebase_core_platform_interface.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:nartus_connectivity/nartus_connectivity.dart';
import 'package:nartus_remote_config/remote_config_manager.dart';

import 'remote_config_manager_test.mocks.dart';

@GenerateMocks([FirebaseRemoteConfig, ConnectivityService])
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setupFirebaseCoreMocks();

  Firebase.initializeApp();

  final MockFirebaseRemoteConfig remoteConfig = MockFirebaseRemoteConfig();
  final MockConnectivityService connectivityService = MockConnectivityService();

  setUp(() {
    when(remoteConfig.fetchAndActivate()).thenAnswer((_) => Future.value(true));
    when(connectivityService.isConnected).thenAnswer((_) => Future.value(true));
    when(connectivityService.onConnectivityChange)
        .thenAnswer((realInvocation) => const Stream.empty());
  });

  tearDown(() {
    reset(remoteConfig);
    reset(connectivityService);
  });

  test(
      'test getValue - when debug option remote config is true, then return true',
      () async {
    RemoteConfigManager manager = RemoteConfigManager(
        remoteConfig: remoteConfig, connectivityService: connectivityService);

    await manager.init();

    when(remoteConfig.getBool('debug_options')).thenReturn(true);
    final result = manager.getValue(RemoteConfigKey.debugOption);

    expect(result, true);
  });

  test(
      'test getValue - when debug option remote config is false, then return false',
      () async {
    RemoteConfigManager manager = RemoteConfigManager(
        remoteConfig: remoteConfig, connectivityService: connectivityService);

    await manager.init();

    when(remoteConfig.getBool('debug_options')).thenReturn(false);
    final result = manager.getValue(RemoteConfigKey.debugOption);

    expect(result, false);
  });

  test(
      'when connectivity is not connected, then do not fetch and activate remote config',
      () async {
    when(connectivityService.isConnected)
        .thenAnswer((realInvocation) => Future.value(false));

    RemoteConfigManager manager = RemoteConfigManager(
        remoteConfig: remoteConfig, connectivityService: connectivityService);

    await manager.init();

    verifyNever(remoteConfig.fetchAndActivate());
  });

  test('when onConnectivityChange return false, do nothing', () async {
    when(connectivityService.onConnectivityChange)
        .thenAnswer((realInvocation) => Stream.value(false));

    RemoteConfigManager manager = RemoteConfigManager(
        remoteConfig: remoteConfig, connectivityService: connectivityService);

    await manager.init();

    verify(remoteConfig.setConfigSettings(any)).called(1);
    verify(remoteConfig.addListener(any)).called(1);
    verifyNever(remoteConfig.fetch());
  });

  test(
      'when onConnectivityChange return true, then fetch data from remote config',
      () async {
    when(connectivityService.onConnectivityChange)
        .thenAnswer((realInvocation) => Stream.value(true));

    RemoteConfigManager manager = RemoteConfigManager(
        remoteConfig: remoteConfig, connectivityService: connectivityService);

    await manager.init();

    verify(remoteConfig.fetchAndActivate()).called(1);

    // wait for stream to be triggered
    await Future.delayed(const Duration(seconds: 1));
    verify(remoteConfig.fetch()).called(1);
  });
}
