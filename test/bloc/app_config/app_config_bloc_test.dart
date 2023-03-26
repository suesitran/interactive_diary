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
  final MockRemoteConfigManager remoteConfigManager = MockRemoteConfigManager();

  setUpAll(() {
    ServiceLocator.instance.registerSingleton<RemoteConfigManager>(remoteConfigManager);
  });

  setUp(() {
    when(remoteConfigManager.getValue(RemoteConfigKey.debugOption)).thenReturn(false);
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
}
