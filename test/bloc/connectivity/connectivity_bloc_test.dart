import 'package:bloc_test/bloc_test.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:interactive_diary/bloc/connectivity/connectivity_bloc.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:nartus_connectivity/nartus_connectivity.dart';

import 'connectivity_bloc_test.mocks.dart';

@GenerateMocks(<Type>[ConnectivityService])
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  final MockConnectivityService service = MockConnectivityService();
  group('event change connectivity', () {
    blocTest(
      'There is no network connection, turn on wifi, then return true',
      build: () => ConnectivityBloc(connectivity: service),
      setUp: () {
        when(service.onConnectivityChange)
            .thenAnswer((Invocation value) => Stream<bool>.value(true));
      },
      act: (ConnectivityBloc bloc) => bloc.add(WatchConnectivityEvent()),
      expect: () => [isA<ConnectedState>()],
    );
    blocTest(
      'There is network connection, turn off wifi, then return false',
      build: () => ConnectivityBloc(connectivity: service),
      setUp: () {
        when(service.onConnectivityChange)
            .thenAnswer((Invocation value) => Stream<bool>.value(false));
      },
      act: (ConnectivityBloc bloc) => bloc.add(WatchConnectivityEvent()),
      expect: () => [isA<DisconnectedState>()],
    );
  });

  test('verify all Events has no prop', () {
    final ConnectivityEvent connectivityEvent = ConnectivityEvent();
    expect(connectivityEvent.props.length, 0);

    final WatchConnectivityEvent changeConnectConnectivityEvent =
        WatchConnectivityEvent();
    expect(changeConnectConnectivityEvent.props.length, 0);
  });

  blocTest(
      'given network connection available, when check connectivity event, then return true',
      build: () => ConnectivityBloc(connectivity: service),
      setUp: () =>
          when(service.isConnected).thenAnswer((_) => Future.value(true)),
      act: (bloc) => bloc.add(CheckConnectivityEvent()),
      expect: () => [isA<ConnectedState>()]);

  blocTest(
      'given network connection not available, when check connectivity event, then return false',
      build: () => ConnectivityBloc(connectivity: service),
      setUp: () =>
          when(service.isConnected).thenAnswer((_) => Future.value(false)),
      act: (bloc) => bloc.add(CheckConnectivityEvent()),
      expect: () => [isA<DisconnectedState>()]);
}
