import 'package:mockito/annotations.dart';
import 'package:nartus_remote_config/remote_config_manager.dart';

@GenerateMocks([RemoteConfigManager])
void main() {
  // blocTest(
  //   'validate app config initalise',
  //   build: () => AppConfigBloc(),
  //   act: (bloc) => bloc.add(AppRequestInitialise()),
  //   expect: () => [isA<AppConfigInitialised>()],
  //   verify: (bloc) => verify(manager.init()).called(1),
  // );
}
