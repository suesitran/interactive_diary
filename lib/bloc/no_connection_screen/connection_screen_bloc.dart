import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:nartus_connectivity/nartus_connectivity.dart';
import 'package:nartus_connectivity/src/nartus_connectivity_plus_impl.dart';
part 'connection_screen_event.dart';
part 'connection_screen_state.dart';

class ConnectionScreenBloc
    extends Bloc<ConnectionScreenEvent, ConnectionScreenState> {
  final ConnectivityService _connectivity;
  ConnectionScreenBloc({ConnectivityService? connectivity})
      : _connectivity = connectivity ?? ConnectivityPlusServiceImpl(),
        super(
          ConnectionScreenInitial(),
        ) {
    on<ChangeConnectConnectivityEvent>((event, emit) async {
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
