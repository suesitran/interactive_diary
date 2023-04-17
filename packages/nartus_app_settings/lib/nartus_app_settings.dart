library nartus_app_settings;

import 'package:shared_preferences/shared_preferences.dart';

part 'src/nartus_app_settings_impl.dart';

abstract class AppSettings {
  AppSettings();

  factory AppSettings.newInstance() => _AppSettingsImpl();

  Future<bool> isAppFirstLaunch();

  Future<void> registerAppLaunched();
}
