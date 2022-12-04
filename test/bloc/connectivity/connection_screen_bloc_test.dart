import 'package:bloc_test/bloc_test.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:interactive_diary/bloc/no_connection_screen/connection_screen_bloc.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:nartus_connectivity/nartus_connectivity.dart';
import 'package:nartus_connectivity/src/nartus_connectivity_plus_impl.dart';
// import 'connectivity_bloc_test.mocks.dart';

@GenerateMocks(<Type>[ConnectivityService])
void main() {
  final ConnectivityService service = ConnectivityPlusServiceImpl();
  group('event change connectivity', () {
    Stream<bool> value;
    blocTest(
      'There is not network connection, turn on wifi, then return true',
      build: () => ConnectionScreenBloc(connectivity: service),
      setUp: (() {
        when(service.onConnectivityChange)
            .thenAnswer((Invocation value) => Stream.value(true));
      }),
      act: (ConnectionScreenBloc bloc) =>
          bloc.add(ChangeConnectConnectivityEvent()),
      expect: () =>
          <TypeMatcher<ChangeConnectedState>>[isA<ChangeConnectedState>()],
    );
    blocTest(
      'There is network connection, turn off wifi, then return false',
      build: () => ConnectionScreenBloc(connectivity: service),
      setUp: (() {
        when(service.onConnectivityChange)
            .thenAnswer((Invocation value) => Stream.value(false));
      }),
      act: (ConnectionScreenBloc bloc) =>
          bloc.add(ChangeConnectConnectivityEvent()),
      expect: () =>
          <TypeMatcher<ChangeDisonnectedState>>[isA<ChangeDisonnectedState>()],
    );
  });
}
