import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:interactive_diary/service_locator/service_locator.dart';
import 'package:nartus_connectivity/nartus_connectivity.dart';

part 'connectivity_event.dart';
part 'connectivity_state.dart';

class ConnectivityBloc extends Bloc<ConnectivityEvent, ConnectivityState> {
  final ConnectivityService _connectivity;
  ConnectivityBloc()
      : _connectivity = ServiceLocator.instance<ConnectivityService>(),
        super(ConnectivityState()) {
    on<WatchConnectivityEvent>(
        (ConnectivityEvent event, Emitter<ConnectivityState> emit) async {
      await _changeConnectionStatus(emit);
    });

    on<CheckConnectivityEvent>((event, emit) async {
      await _checkConnectivity(emit);
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

  Future<void> _checkConnectivity(Emitter<ConnectivityState> emit) async {
    bool isConnected = await _connectivity.isConnected;

    if (isConnected) {
      emit(ConnectedState());
    } else {
      emit(DisconnectedState());
    }
  }

  @override
  Future<void> close() {
    _connectivity.dispose();
    return super.close();
  }
}
