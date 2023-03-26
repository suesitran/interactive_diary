import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:interactive_diary/service_locator/service_locator.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:nartus_remote_config/remote_config_manager.dart';
import 'package:shake/shake.dart';

part 'app_config_event.dart';
part 'app_config_state.dart';

class AppConfigBloc extends Bloc<AppConfigEvent, AppConfigState> {

  ShakeDetector? detector;

  AppConfigBloc()
      : super(AppConfigInitial()) {
    on<AppRequestInitialise>(_initialise);

    on<AnnounceShakeAction>((event, emit) {
      emit(ShakeDetected(DateTime.now().millisecondsSinceEpoch));
    },);
  }

  void _initialise(AppConfigEvent event, Emitter<AppConfigState> emit) async {
    // init Date formatting
    initializeDateFormatting();

    RemoteConfigManager remoteConfigManager = ServiceLocator.instance.get<RemoteConfigManager>();
    bool debugOption = remoteConfigManager.getValue(RemoteConfigKey.debugOption);

    if (debugOption) {
      detector = ShakeDetector.waitForStart(onPhoneShake: () {
        add(AnnounceShakeAction());
      },);
      detector?.startListening();
    }
    // inform UI
    emit(AppConfigInitialised());
  }

  @override
  Future<void> close() {
    detector?.stopListening();
    return super.close();
  }
}
