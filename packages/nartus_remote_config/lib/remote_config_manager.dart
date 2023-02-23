import 'dart:async';

import 'package:firebase_remote_config/firebase_remote_config.dart';

enum RemoteConfigKey {
  debugOption('debug_option', false);

  final String name;
  final dynamic defaultValue;

  const RemoteConfigKey(this.name, this.defaultValue);
}

class RemoteConfigManager {
  final StreamController<Map<RemoteConfigKey, dynamic>>
      _remoteConfigUpdateStream =
      StreamController<Map<RemoteConfigKey, dynamic>>.broadcast();

  Stream<Map<RemoteConfigKey, dynamic>> get remoteConfigStream =>
      _remoteConfigUpdateStream.stream;

  final FirebaseRemoteConfig _remoteConfig;

  RemoteConfigManager({FirebaseRemoteConfig? remoteConfig})
      : _remoteConfig = remoteConfig ?? FirebaseRemoteConfig.instance;

  Future<void> init() async {
    await _remoteConfig.setConfigSettings(RemoteConfigSettings(
      fetchTimeout: const Duration(minutes: 1),
      minimumFetchInterval: const Duration(hours: 1),
    ));

    _remoteConfig.addListener(_onRemoteConfigValueUpdate);

    await _remoteConfig.fetchAndActivate();
  }

  void _onRemoteConfigValueUpdate() {
    final Map<RemoteConfigKey, dynamic> map = {};

    for (RemoteConfigKey key in RemoteConfigKey.values) {
      map.putIfAbsent(key, () => getValue(key));
    }
    _remoteConfigUpdateStream.add(map);
  }

  dynamic getValue(RemoteConfigKey key) {
    if (key.defaultValue is bool) {
      return _remoteConfig.getBool(key.name);
    } else if (key.defaultValue is int) {
      return _remoteConfig.getInt(key.name);
    } else if (key.defaultValue is double) {
      return _remoteConfig.getDouble(key.name);
    } else if (key.defaultValue is String) {
      return _remoteConfig.getString(key.name);
    }

    throw UnsupportedError(
        'Remote config value not supported ${key.defaultValue}');
  }
}
