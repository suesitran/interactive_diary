import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:interactive_diary/service_locator/service_locator.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:nartus_app_settings/nartus_app_settings.dart';
import 'package:nartus_remote_config/remote_config_manager.dart';
import 'package:shake/shake.dart';

part 'app_config_event.dart';
part 'app_config_state.dart';

class AppConfigBloc extends Bloc<AppConfigEvent, AppConfigState> {
  ShakeDetector? detector;
  final AppSettings _appSettings;

  AppConfigBloc()
      : _appSettings = ServiceLocator.instance<AppSettings>(),
        super(AppConfigInitial()) {
    on<AppRequestInitialise>(_initialise);

    on<AnnounceShakeAction>(
      (event, emit) {
        emit(ShakeDetected(DateTime.now().millisecondsSinceEpoch));
      },
    );

    on<CancelFirstLaunch>(_cancelFirstLaunch);
  }

  void _initialise(AppConfigEvent event, Emitter<AppConfigState> emit) async {
    // init Date formatting
    initializeDateFormatting();

    RemoteConfigManager remoteConfigManager =
        ServiceLocator.instance.get<RemoteConfigManager>();
    bool debugOption =
        remoteConfigManager.getValue(RemoteConfigKey.debugOption);

    if (debugOption) {
      detector = ShakeDetector.waitForStart(
        onPhoneShake: () {
          add(AnnounceShakeAction());
        },
      );
      detector?.startListening();
    }

    bool isAppLaunched = await _appSettings.isAppFirstLaunch();

    // inform UI
    emit(AppConfigInitialised(isFirstLaunch: isAppLaunched));
  }

  void _cancelFirstLaunch(
      AppConfigEvent event, Emitter<AppConfigState> emit) async {
    await _appSettings.registerAppLaunched();

    emit(AppFirstLaunchCleared());
  }

  @override
  Future<void> close() {
    detector?.stopListening();
    return super.close();
  }
}
