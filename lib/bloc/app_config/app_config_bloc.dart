import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:nartus_remote_config/remote_config_manager.dart';

part 'app_config_event.dart';
part 'app_config_state.dart';

class AppConfigBloc extends Bloc<AppConfigEvent, AppConfigState> {
  final RemoteConfigManager _remoteConfigManager;
  AppConfigBloc({RemoteConfigManager? remoteConfigManager}) :
        _remoteConfigManager = remoteConfigManager ?? RemoteConfigManager(),
        super(AppConfigInitial()) {
    on<AppRequestInitialise>(_initialise);
  }

  void _initialise(AppConfigEvent event, Emitter<AppConfigState> emit) async {
    // init Date formatting
    initializeDateFormatting();

    // await _remoteConfigManager.init();

    // inform UI
    emit(AppConfigInitialised());
  }



  void _onDebugOptionChanged(bool debugOptions) {
    // TODO handle debug option change
  }
}
