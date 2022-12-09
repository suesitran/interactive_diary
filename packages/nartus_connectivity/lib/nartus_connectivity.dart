import 'dart:async';

import 'package:nartus_connectivity/src/connectivity_plus_impl/connectivity_plus_impl.dart';

enum ImplType { connectivityPlus }

class ConnectivityService {

  final ImplType type;
  ConnectivityService(this.type);

  final ConnectivityPlusImpl _connectivityPlusImpl = ConnectivityPlusImpl();

  Future<bool> get isConnected {
    if (type == ImplType.connectivityPlus) {
      return _connectivityPlusImpl.isConnected;
    }
    throw UnimplementedError('Only type ImplType.connectivityPlus is supported.');
  }

  Stream<bool> get onConnectivityChange => _connectivityPlusImpl.onConnectivityChange;
}
