import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:interactive_diary/bloc/app_config/app_config_bloc.dart';
import 'package:interactive_diary/service_locator/service_locator.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:nartus_app_settings/nartus_app_settings.dart';
import 'package:nartus_remote_config/remote_config_manager.dart';

import 'app_config_bloc_test.mocks.dart';

@GenerateMocks([RemoteConfigManager, AppSettings])
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  final MockRemoteConfigManager remoteConfigManager = MockRemoteConfigManager();
  final MockAppSettings appSettings = MockAppSettings();

  setUpAll(() {
    ServiceLocator.instance
        .registerSingleton<RemoteConfigManager>(remoteConfigManager);
    ServiceLocator.instance.registerSingleton<AppSettings>(appSettings);
  });

  setUp(() {
    when(remoteConfigManager.getValue(RemoteConfigKey.debugOption))
        .thenReturn(false);
    when(appSettings.isAppFirstLaunch()).thenAnswer((_) => Future.value(true));
  });

  tearDown(() {
    reset(remoteConfigManager);
    reset(appSettings);
  });

  blocTest(
    'validate app config initialise',
    build: () => AppConfigBloc(),
    act: (bloc) => bloc.add(AppRequestInitialise()),
    expect: () => [isA<AppConfigInitialised>()],
  );

  group('test remote config', () {
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
  });

  group('test shake detector', () {
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

        AppConfigInitialised appConfigInitialised =
            AppConfigInitialised(isFirstLaunch: true);
        expect(appConfigInitialised.props.length, 1);
        expect(appConfigInitialised.props.first, true);

        ShakeDetected shakeDetected = ShakeDetected(100);
        expect(shakeDetected.props.length, 1);
        expect(shakeDetected.props.first, 100);
      },
    );
  });

  group('test app settings', () {
    blocTest(
      'given app is first launched, when initialise, then return AppConfigInitialised with isFirstLaunch = true',
      build: () => AppConfigBloc(),
      setUp: () {
        when(appSettings.isAppFirstLaunch())
            .thenAnswer((realInvocation) => Future.value(true));
      },
      act: (bloc) => bloc.add(AppRequestInitialise()),
      expect: () => [isA<AppConfigInitialised>()],
      verify: (bloc) {
        AppConfigInitialised state = bloc.state as AppConfigInitialised;

        expect(state.isFirstLaunch, true);
      },
    );

    blocTest(
      'given app is not first launched, when initialise, then return AppConfigInitialised with isFirstLaunch = false',
      build: () => AppConfigBloc(),
      setUp: () {
        when(appSettings.isAppFirstLaunch())
            .thenAnswer((realInvocation) => Future.value(false));
      },
      act: (bloc) => bloc.add(AppRequestInitialise()),
      expect: () => [isA<AppConfigInitialised>()],
      verify: (bloc) {
        AppConfigInitialised state = bloc.state as AppConfigInitialised;

        expect(state.isFirstLaunch, false);
      },
    );
  });
}
