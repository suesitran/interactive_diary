import 'dart:async';

import 'package:firebase_remote_config/firebase_remote_config.dart';

enum RemoteConfigKey {
  debugOption('debug_option', false);

  final String name;
  final dynamic defaultValue;

  const RemoteConfigKey(this.name, this.defaultValue);
}

class RemoteConfigManager {
  final StreamController<Map<RemoteConfigKey, dynamic>> _remoteConfigUpdateStream = StreamController<Map<RemoteConfigKey, dynamic>>.broadcast();

  Stream<Map<RemoteConfigKey, dynamic>> get remoteConfigStream => _remoteConfigUpdateStream.stream;

  Future<void> init() async {
    final FirebaseRemoteConfig remoteConfig = FirebaseRemoteConfig.instance;
    await remoteConfig.setConfigSettings(RemoteConfigSettings(
      fetchTimeout: const Duration(minutes: 1),
      minimumFetchInterval: const Duration(hours: 1),
    ));

    remoteConfig.addListener(_onRemoteConfigValueUpdate);

    await remoteConfig.fetchAndActivate();
  }

  void _onRemoteConfigValueUpdate() {
    final Map<RemoteConfigKey, dynamic> map = {};

    for (RemoteConfigKey key in RemoteConfigKey.values) {
      map.putIfAbsent(key, () => getValue(key));
    }
    _remoteConfigUpdateStream.add(map);
  }

  dynamic getValue(RemoteConfigKey key) {
    final FirebaseRemoteConfig remoteConfig = FirebaseRemoteConfig.instance;

    if (key.defaultValue is bool) {
      return remoteConfig.getBool(key.name);
    } else if (key.defaultValue is int) {
      return remoteConfig.getInt(key.name);
    } else if (key.defaultValue is double) {
      return remoteConfig.getDouble(key.name);
    } else if (key.defaultValue is String) {
      return remoteConfig.getString(key.name);
    }

    throw UnsupportedError('Remote config value not supported ${key.defaultValue}');
  }
}