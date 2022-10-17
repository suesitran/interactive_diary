import 'dart:async';

abstract class ConnectivityService {
  /// Public accessible methods
  Future<bool> get isConnected;

  Stream<bool> get onConnectivityChange;
}
