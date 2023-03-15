import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:interactive_diary/service_locator/service_locator.dart';
import 'package:nartus_connectivity/nartus_connectivity.dart';

part 'connectivity_event.dart';
part 'connectivity_state.dart';

class ConnectivityBloc extends Bloc<ConnectivityEvent, ConnectivityState> {
  final ConnectivityService _connectivity;
  ConnectivityBloc({ConnectivityService? connectivity})
      : _connectivity =
            connectivity ?? ServiceLocator.instance<ConnectivityService>(),
        super(ConnectivityState()) {
    on<ConnectedConnectivityEvent>(
        (ConnectivityEvent event, Emitter<ConnectivityState> emit) async {
      await _checkConnectivity(emit);
    });

    on<ChangeConnectConnectivityEvent>(
        (ConnectivityEvent event, Emitter<ConnectivityState> emit) async {
      await _changeConnectionStatus(emit);
    });
  }

  // late StreamSubscription connectivitySubscription;

  Future<void> _checkConnectivity(Emitter<ConnectivityState> emit) async {
    await _connectivity.isConnected.then((bool value) {
      if (value == true) {
        emit(ConnectedState());
      } else {
        emit(DisconnectedState());
      }
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
