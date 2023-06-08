import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:nartus_app_settings/nartus_app_settings.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  const MethodChannel methodChannel =
      MethodChannel('plugins.flutter.io/shared_preferences');

  test(
      'given shared preference has no data, when check isAppFirstLaunch, then return true',
      () async {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(methodChannel, (MethodCall methodCall) async {
      expect(methodCall.method, 'getAll');
      return {};
    });

    AppSettings appSettings = AppSettings.newInstance();

    bool isFirstLaunch = await appSettings.isAppFirstLaunch();

    expect(isFirstLaunch, true);
  });
}
