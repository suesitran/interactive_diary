import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:nartus_connectivity/nartus_connectivity.dart';

part 'connection_screen_event.dart';
part 'connection_screen_state.dart';

class ConnectionScreenBloc
    extends Bloc<ConnectionScreenEvent, ConnectionScreenState> {
  final ConnectivityService _connectivity;
  ConnectionScreenBloc({ConnectivityService? connectivity})
      : _connectivity = connectivity ?? ConnectivityService(ImplType.connectivityPlus),
        super(
          ConnectionScreenInitial(),
        ) {
    on<ChangeConnectConnectivityEvent>((ChangeConnectConnectivityEvent event, Emitter<ConnectionScreenState> emit) async {
      await _changeConnectionStatus(emit);
    });
  }

  Future<void> _changeConnectionStatus(
      Emitter<ConnectionScreenState> emit) async {
    await emit.forEach(_connectivity.onConnectivityChange,
        onData: (bool value) {
      if (value == true) {
        return ChangeConnectedState();
      } else {
        return ChangeDisonnectedState();
      }
    });
  }
}
