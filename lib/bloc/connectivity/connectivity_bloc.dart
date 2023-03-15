import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:nartus_connectivity/nartus_connectivity.dart';

part 'connectivity_event.dart';
part 'connectivity_state.dart';

class ConnectivityBloc extends Bloc<ConnectivityEvent, ConnectivityState> {
  final ConnectivityService _connectivity;
  ConnectivityBloc({ConnectivityService? connectivity})
      : _connectivity =
            connectivity ?? ConnectivityService(ImplType.connectivityPlus),
        super(ConnectivityState()) {
    on<WatchConnectivityEvent>(
        (ConnectivityEvent event, Emitter<ConnectivityState> emit) async {
      await _changeConnectionStatus(emit);
    });
  }

  Future<void> _changeConnectionStatus(Emitter<ConnectivityState> emit) async {
    await emit.forEach(_connectivity.onConnectivityChange,
        onData: (bool value) {
      if (value == true) {
        return ConnectedState();
      } else {
        return DisconnectedState();
      }
    });
  }
}
