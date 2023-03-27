import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:interactive_diary/bloc/app_config/app_config_bloc.dart';
import 'package:interactive_diary/service_locator/service_locator.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:nartus_remote_config/remote_config_manager.dart';

import '../../service_locator/service_locator_test.mocks.dart';

@GenerateMocks([RemoteConfigManager])
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  final MockRemoteConfigManager remoteConfigManager = MockRemoteConfigManager();

  setUpAll(() {
    ServiceLocator.instance
        .registerSingleton<RemoteConfigManager>(remoteConfigManager);
  });

  setUp(() {
    when(remoteConfigManager.getValue(RemoteConfigKey.debugOption))
        .thenReturn(false);
  });

  tearDown(() {
    reset(remoteConfigManager);
  });

  blocTest(
    'validate app config initialise',
    build: () => AppConfigBloc(),
    act: (bloc) => bloc.add(AppRequestInitialise()),
    expect: () => [isA<AppConfigInitialised>()],
  );

  blocTest(
    'given remote configs return debug_options false, when initialise, then do not initialise detector',
    build: () => AppConfigBloc(),
    setUp: () {
      when(remoteConfigManager.getValue(any)).thenReturn(false);
    },
    act: (bloc) => bloc.add(AppRequestInitialise()),
    expect: () => [isA<AppConfigInitialised>()],
    verify: (bloc) {
      expect(bloc.detector, isNull);
    },
  );

  blocTest(
    'given remote configs return debug_options trie, when initialise, then initialise detector',
    build: () => AppConfigBloc(),
    setUp: () {
      when(remoteConfigManager.getValue(any)).thenReturn(true);
    },
    act: (bloc) => bloc.add(AppRequestInitialise()),
    expect: () => [isA<AppConfigInitialised>()],
    verify: (bloc) {
      expect(bloc.detector, isNotNull);
    },
  );

  blocTest(
    'given shack detector is registered, when shake detected, then announce ShakeDetected',
    build: () => AppConfigBloc(),
    setUp: () {
      when(remoteConfigManager.getValue(any)).thenReturn(true);
    },
    act: (bloc) => bloc.add(AnnounceShakeAction()),
    expect: () => [isA<ShakeDetected>()],
  );

  test(
    'verify app config states',
    () {
      AppConfigInitial appConfigInitial = AppConfigInitial();
      expect(appConfigInitial.props.length, 0);

      AppConfigInitialised appConfigInitialised = AppConfigInitialised();
      expect(appConfigInitialised.props.length, 0);

      ShakeDetected shakeDetected = ShakeDetected(100);
      expect(shakeDetected.props.length, 1);
      expect(shakeDetected.props.first, 100);
    },
  );
}
