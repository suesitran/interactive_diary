import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:interactive_diary/bloc/app_config/app_config_bloc.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:nartus_remote_config/remote_config_manager.dart';
import 'app_config_bloc_test.mocks.dart';

@GenerateMocks([RemoteConfigManager])
void main() {
  final MockRemoteConfigManager manager = MockRemoteConfigManager();

  blocTest(
    'validate app config initalise',
    build: () => AppConfigBloc(remoteConfigManager: manager),
    act: (bloc) => bloc.add(AppRequestInitialise()),
    expect: () => [isA<AppConfigInitialised>()],
    verify: (bloc) => verify(manager.init()).called(1),
  );
}
