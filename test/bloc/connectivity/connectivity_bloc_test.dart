import 'package:bloc_test/bloc_test.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:interactive_diary/bloc/connectivity/connectivity_bloc.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'connectivity_bloc_test.mocks.dart';
import 'package:nartus_connectivity/src/nartus_connectivity_plus_impl.dart';

@GenerateMocks(<Type>[ConnectivityPlusServiceImpl])
void main() {
  final MockConnectivityPlusServiceImpl service =
      MockConnectivityPlusServiceImpl();
  group('event check connectivity', () {
    blocTest(
      'There is network connection, then return true',
      build: () => ConnectivityBloc(connectivity: service),
      setUp: (() => when(service.isConnected).thenAnswer((_) async => true)),
      act: (ConnectivityBloc bloc) => bloc.add(ConnectedConnectivityEvent()),
      expect: () => <TypeMatcher<ConnectedState>>[isA<ConnectedState>()],
    );
    blocTest(
      'There is not network connection, then return false',
      build: () => ConnectivityBloc(connectivity: service),
      setUp: (() => when(service.isConnected).thenAnswer((_) async => false)),
      act: (ConnectivityBloc bloc) => bloc.add(ConnectedConnectivityEvent()),
      expect: () => <TypeMatcher<DisconnectedState>>[isA<DisconnectedState>()],
    );
  });
  group('event change connectivity', () {
    Stream<bool> value;
    blocTest(
      'There is not network connection, turn on wifi, then return true',
      build: () => ConnectivityBloc(connectivity: service),
      setUp: (() {
        when(service.onConnectivityChange)
            .thenAnswer((Invocation value) => Stream.value(true));
      }),
      act: (ConnectivityBloc bloc) =>
          bloc.add(ChangeConnectConnectivityEvent()),
      expect: () =>
          <TypeMatcher<ChangeConnectedState>>[isA<ChangeConnectedState>()],
    );
    blocTest(
      'There is network connection, turn off wifi, then return false',
      build: () => ConnectivityBloc(connectivity: service),
      setUp: (() {
        when(service.onConnectivityChange)
            .thenAnswer((Invocation value) => Stream.value(false));
      }),
      act: (ConnectivityBloc bloc) =>
          bloc.add(ChangeConnectConnectivityEvent()),
      expect: () =>
          <TypeMatcher<ChangeDisonnectedState>>[isA<ChangeDisonnectedState>()],
    );
  });
}
