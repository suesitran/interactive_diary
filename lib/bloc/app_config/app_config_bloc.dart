import 'dart:async';

import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'app_config_event.dart';
part 'app_config_state.dart';

class AppConfigBloc extends Bloc<AppConfigEvent, AppConfigState> {
  AppConfigBloc() : super(AppConfigInitial()) {
    on<AppConfigEvent>((AppConfigEvent event, Emitter<AppConfigState> emit) {});
  }

  void initialise() async {
    // init remote config
    await _initRemoteConfig();

    // TODO add other initialise here
  }

  Future<void> _initRemoteConfig() async {
    final FirebaseRemoteConfig remoteConfig = FirebaseRemoteConfig.instance;
    await remoteConfig.setConfigSettings(RemoteConfigSettings(
      fetchTimeout: const Duration(minutes: 1),
      minimumFetchInterval: const Duration(hours: 1),
    ));

    remoteConfig.addListener(() {
      // TODO get value from Remote Config and use it here
      _onDebugOptionChanged(remoteConfig.getBool('debug_options'));
    });

    await remoteConfig.fetchAndActivate();
  }

  void _onDebugOptionChanged(bool debugOptions) {
    // TODO handle debug option change
  }
}
