library nartus_app_settings;

import 'package:shared_preferences/shared_preferences.dart';

part 'src/nartus_app_settings_impl.dart';

abstract class AppSettings {
  AppSettings._();

  factory AppSettings() => _AppSettingsImpl();

  Future<bool> isAppFirstLaunch();

  Future<void> registerAppLaunched();
}
