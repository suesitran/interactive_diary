import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:nartus_connectivity/src/connectivity_plus_impl/connectivity_plus_impl.dart';

import 'nartus_connectivity_test.mocks.dart';

@GenerateMocks([Connectivity])
void main() {
  final Connectivity connectivity = MockConnectivity();

  test(
      'given current connectivity is none, '
      'when get isConnected, '
      'then return false', () async {
    when(connectivity.checkConnectivity())
        .thenAnswer((realInvocation) => Future.value(ConnectivityResult.none));
    when(connectivity.onConnectivityChanged)
        .thenAnswer((realInvocation) => Stream.value(ConnectivityResult.none));

    final ConnectivityPlusImpl service =
        ConnectivityPlusImpl(connectivity: connectivity);

    final result = await service.isConnected;

    expect(result, false);
  });

  test(
      'given current connectivity is bluetooth, '
      'when get isConnected, '
      'then return true', () async {
    when(connectivity.checkConnectivity()).thenAnswer(
        (realInvocation) => Future.value(ConnectivityResult.bluetooth));
    when(connectivity.onConnectivityChanged)
        .thenAnswer((realInvocation) => Stream.value(ConnectivityResult.none));

    final ConnectivityPlusImpl service =
        ConnectivityPlusImpl(connectivity: connectivity);

    final result = await service.isConnected;

    expect(result, true);
  });

  test(
      'given current connectivity is wifi, '
      'when get isConnected, '
      'then return true', () async {
    when(connectivity.checkConnectivity())
        .thenAnswer((realInvocation) => Future.value(ConnectivityResult.wifi));
    when(connectivity.onConnectivityChanged)
        .thenAnswer((realInvocation) => Stream.value(ConnectivityResult.none));

    final ConnectivityPlusImpl service =
        ConnectivityPlusImpl(connectivity: connectivity);

    final result = await service.isConnected;

    expect(result, true);
  });

  test(
      'given current connectivity is ethernet, '
      'when get isConnected, '
      'then return true', () async {
    when(connectivity.checkConnectivity()).thenAnswer(
        (realInvocation) => Future.value(ConnectivityResult.ethernet));
    when(connectivity.onConnectivityChanged)
        .thenAnswer((realInvocation) => Stream.value(ConnectivityResult.none));

    final ConnectivityPlusImpl service =
        ConnectivityPlusImpl(connectivity: connectivity);

    final result = await service.isConnected;

    expect(result, true);
  });

  test(
      'given current connectivity is mobile, '
      'when get isConnected, '
      'then return true', () async {
    when(connectivity.checkConnectivity()).thenAnswer(
        (realInvocation) => Future.value(ConnectivityResult.mobile));
    when(connectivity.onConnectivityChanged)
        .thenAnswer((realInvocation) => Stream.value(ConnectivityResult.none));

    final ConnectivityPlusImpl service =
        ConnectivityPlusImpl(connectivity: connectivity);

    final result = await service.isConnected;

    expect(result, true);
  });

  test(
      'given current connectivity is none, '
      'when connectivity change to bluetooth, '
      'then emit true to connectivity change stream', () async {
    when(connectivity.checkConnectivity())
        .thenAnswer((realInvocation) => Future.value(ConnectivityResult.none));
    when(connectivity.onConnectivityChanged).thenAnswer(
        (realInvocation) => Stream.value(ConnectivityResult.bluetooth));

    final ConnectivityPlusImpl service =
        ConnectivityPlusImpl(connectivity: connectivity);

    expect(service.onConnectivityChange, emitsInOrder([true]));
  });

  test(
      'given current connectivity is none, '
      'when connectivity change to wifi, '
      'then emit true to connectivity change stream', () async {
    when(connectivity.checkConnectivity())
        .thenAnswer((realInvocation) => Future.value(ConnectivityResult.none));
    when(connectivity.onConnectivityChanged)
        .thenAnswer((realInvocation) => Stream.value(ConnectivityResult.wifi));

    final ConnectivityPlusImpl service =
        ConnectivityPlusImpl(connectivity: connectivity);

    expect(service.onConnectivityChange, emitsInOrder([true]));
  });

  test(
      'given current connectivity is none, '
      'when connectivity change to ethernet, '
      'then emit true to connectivity change stream', () async {
    when(connectivity.checkConnectivity())
        .thenAnswer((realInvocation) => Future.value(ConnectivityResult.none));
    when(connectivity.onConnectivityChanged).thenAnswer(
        (realInvocation) => Stream.value(ConnectivityResult.ethernet));

    final ConnectivityPlusImpl service =
        ConnectivityPlusImpl(connectivity: connectivity);

    expect(service.onConnectivityChange, emitsInOrder([true]));
  });

  test(
      'given current connectivity is none, '
      'when connectivity change to mobile, '
      'then emit true to connectivity change stream', () async {
    when(connectivity.checkConnectivity())
        .thenAnswer((realInvocation) => Future.value(ConnectivityResult.none));
    when(connectivity.onConnectivityChanged).thenAnswer(
        (realInvocation) => Stream.value(ConnectivityResult.mobile));

    final ConnectivityPlusImpl service =
        ConnectivityPlusImpl(connectivity: connectivity);

    expect(service.onConnectivityChange, emitsInOrder([true]));
  });

  test(
      'given current connectivity is bluetooth, '
      'when connectivity change to none, '
      'then emit false to connectivity change stream', () async {
    when(connectivity.checkConnectivity()).thenAnswer(
        (realInvocation) => Future.value(ConnectivityResult.bluetooth));
    when(connectivity.onConnectivityChanged)
        .thenAnswer((realInvocation) => Stream.value(ConnectivityResult.none));

    final ConnectivityPlusImpl service =
        ConnectivityPlusImpl(connectivity: connectivity);

    expect(service.onConnectivityChange, emitsInOrder([false]));
  });

  test(
      'given current connectivity is wifi, '
      'when connectivity change to none, '
      'then emit false to connectivity change stream', () async {
    when(connectivity.checkConnectivity())
        .thenAnswer((realInvocation) => Future.value(ConnectivityResult.wifi));
    when(connectivity.onConnectivityChanged)
        .thenAnswer((realInvocation) => Stream.value(ConnectivityResult.none));

    final ConnectivityPlusImpl service =
        ConnectivityPlusImpl(connectivity: connectivity);

    expect(service.onConnectivityChange, emitsInOrder([false]));
  });

  test(
      'given current connectivity is ethernet, '
      'when connectivity change to none, '
      'then emit false to connectivity change stream', () async {
    when(connectivity.checkConnectivity()).thenAnswer(
        (realInvocation) => Future.value(ConnectivityResult.ethernet));
    when(connectivity.onConnectivityChanged)
        .thenAnswer((realInvocation) => Stream.value(ConnectivityResult.none));

    final ConnectivityPlusImpl service =
        ConnectivityPlusImpl(connectivity: connectivity);

    expect(service.onConnectivityChange, emitsInOrder([false]));
  });

  test(
      'given current connectivity is mobile, '
      'when connectivity change to none, '
      'then emit false to connectivity change stream', () async {
    when(connectivity.checkConnectivity()).thenAnswer(
        (realInvocation) => Future.value(ConnectivityResult.mobile));
    when(connectivity.onConnectivityChanged)
        .thenAnswer((realInvocation) => Stream.value(ConnectivityResult.none));

    final ConnectivityPlusImpl service =
        ConnectivityPlusImpl(connectivity: connectivity);

    expect(service.onConnectivityChange, emitsInOrder([false]));
  });

  test(
      'given current connectivity is mobile, '
      'when connectivity change to wifi, '
      'then do not emit changes to stream', () async {
    when(connectivity.checkConnectivity()).thenAnswer(
        (realInvocation) => Future.value(ConnectivityResult.mobile));
    when(connectivity.onConnectivityChanged)
        .thenAnswer((realInvocation) => Stream.value(ConnectivityResult.wifi));

    final ConnectivityPlusImpl service =
        ConnectivityPlusImpl(connectivity: connectivity);

    expect(service.onConnectivityChange, emitsInOrder([]));
  });

  test(
      'given current connectivity is mobile, '
      'when connectivity change to bluetooth, '
      'then do not emit changes to stream', () async {
    when(connectivity.checkConnectivity()).thenAnswer(
        (realInvocation) => Future.value(ConnectivityResult.mobile));
    when(connectivity.onConnectivityChanged).thenAnswer(
        (realInvocation) => Stream.value(ConnectivityResult.bluetooth));

    final ConnectivityPlusImpl service =
        ConnectivityPlusImpl(connectivity: connectivity);

    expect(service.onConnectivityChange, emitsInOrder([]));
  });

  test(
      'given current connectivity is mobile, '
      'when connectivity change to ethernet, '
      'then do not emit changes to stream', () async {
    when(connectivity.checkConnectivity()).thenAnswer(
        (realInvocation) => Future.value(ConnectivityResult.mobile));
    when(connectivity.onConnectivityChanged).thenAnswer(
        (realInvocation) => Stream.value(ConnectivityResult.ethernet));

    final ConnectivityPlusImpl service =
        ConnectivityPlusImpl(connectivity: connectivity);

    expect(service.onConnectivityChange, emitsInOrder([]));
  });

  test(
      'given connectivity switches multiple times, '
      'when listening on stream, '
      'then only emits value when Connectivity change to none', () async {
    when(connectivity.checkConnectivity())
        .thenAnswer((realInvocation) => Future.value(ConnectivityResult.wifi));
    when(connectivity.onConnectivityChanged).thenAnswer((realInvocation) =>
        Stream.fromIterable([
          ConnectivityResult.ethernet,
          ConnectivityResult.mobile,
          ConnectivityResult.none
        ]));

    final ConnectivityPlusImpl service =
        ConnectivityPlusImpl(connectivity: connectivity);

    expect(service.onConnectivityChange, emitsInOrder([false]));
  });
}
