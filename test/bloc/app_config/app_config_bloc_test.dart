import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:interactive_diary/bloc/app_config/app_config_bloc.dart';
import 'package:mockito/annotations.dart';
import 'package:nartus_remote_config/remote_config_manager.dart';

@GenerateMocks([RemoteConfigManager])
void main() {
  blocTest(
    'validate app config initialise',
    build: () => AppConfigBloc(),
    act: (bloc) => bloc.add(AppRequestInitialise()),
    expect: () => [isA<AppConfigInitialised>()],
  );
}
