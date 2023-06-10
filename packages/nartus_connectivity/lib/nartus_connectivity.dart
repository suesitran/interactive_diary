import 'dart:async';
import 'dart:io';

import 'package:nartus_connectivity/src/connectivity_plus_impl/connectivity_plus_impl.dart';

enum ImplType { connectivityPlus }

class ConnectivityService {
  final ImplType type;
  ConnectivityService(this.type) {
    switch (type) {
      case ImplType.connectivityPlus:
        _streamSubscription = _connectivityPlusImpl.onConnectivityChange
            .listen((connected) async {
          _connectivityWatcher.add(await isConnected);
        });
        break;
    }
  }

  final ConnectivityPlusImpl _connectivityPlusImpl = ConnectivityPlusImpl();

  final StreamController<bool> _connectivityWatcher = StreamController();

  late final StreamSubscription<bool> _streamSubscription;

  Future<bool> get isConnected async {
    if (type == ImplType.connectivityPlus) {
      bool connected = await _connectivityPlusImpl.isConnected;

      if (connected) {
        // need to ping google to know if there's really internet connection
        try {
          final result = await InternetAddress.lookup('google.com');
          return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
        } on SocketException catch (_) {}
      }

      return false;
    }

    throw UnimplementedError(
        'Only type ImplType.connectivityPlus is supported.');
  }

  Stream<bool> get onConnectivityChange => _connectivityWatcher.stream;

  Future<void> dispose() async {
    await _streamSubscription.cancel();
  }
}
