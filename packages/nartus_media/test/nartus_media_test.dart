import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:nartus_media/nartus_media.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  Map<String, dynamic> androidDeviceInfo (int version) => {
  'version': {
  'baseOS': 'baseOS',
  'codename': 'codename',
  'incremental': 'incremental',
  'previewSdkInt': version,
  'release': 'release',
  'sdkInt': version,
  'securityPatch': 'securityPatch',
  },
  'board': 'board',
  'bootloader': 'bootloader',
  'brand': 'brand',
  'device': 'device',
  'display': 'display',
  'fingerprint': 'fingerprint',
  'hardware': 'hardware',
  'host': 'host',
  'id': 'id',
  'manufacturer': 'manufacturer',
  'model': 'model',
  'product': 'product',
  'supported32BitAbis': [],
  'supported64BitAbis': [],
  'supportedAbis': [],
  'tags': 'tags',
  'type': 'type',
  'isPhysicalDevice': true,
  'systemFeatures': [],
  'displayMetrics': {
    'widthPx': 600.0,
    'heightPx': 600.0,
    'xDpi': 280.0,
    'yDpi': 280.0,
  },
  'serialNumber': 'serialNumber',
  };

  group('checkPermissionGroup', () {
    test('given device is Android with SDK less than 32, when checkMediaPermission, then check storage permission', () async {
      // device is Android
      debugDefaultTargetPlatformOverride = TargetPlatform.android;
      const MethodChannel('dev.fluttercommunity.plus/device_info')
          .setMockMethodCallHandler((MethodCall methodCall) async {
        expect(methodCall.method, 'getDeviceInfo');

        return androidDeviceInfo(31);
      });

      const MethodChannel('flutter.baseflow.com/permissions/methods')
          .setMockMethodCallHandler((MethodCall methodCall) async {
        expect(methodCall.method, 'checkPermissionStatus');

        // argument is 15 - storage
        expect(methodCall.arguments, 15);

        // return denied
        return 0;
      });

      final NartusMediaService service = NartusMediaService();

      MediaPermission permission = await service.checkMediaPermission();

      expect(permission, MediaPermission.denied);

      debugDefaultTargetPlatformOverride = null;
    });

    test('given device is Android with SDK more than 32, when checkMediaPermission, then check photo permission', () async {
      // device is Android
      debugDefaultTargetPlatformOverride = TargetPlatform.android;
      const MethodChannel('dev.fluttercommunity.plus/device_info')
          .setMockMethodCallHandler((MethodCall methodCall) async {
        expect(methodCall.method, 'getDeviceInfo');

        return androidDeviceInfo(33);
      });

      const MethodChannel('flutter.baseflow.com/permissions/methods')
          .setMockMethodCallHandler((MethodCall methodCall) async {
        expect(methodCall.method, 'checkPermissionStatus');

        // argument is 9 - Photo
        expect(methodCall.arguments, 9);

        // return denied
        return 0;
      });

      final NartusMediaService service = NartusMediaService();

      MediaPermission permission = await service.checkMediaPermission();

      expect(permission, MediaPermission.denied);

      debugDefaultTargetPlatformOverride = null;
    });

    test('given device is iOS, when checkMediaPermission, then check photo permission', () async {
      // device is Android
      debugDefaultTargetPlatformOverride = TargetPlatform.iOS;
      const MethodChannel('dev.fluttercommunity.plus/device_info')
          .setMockMethodCallHandler((MethodCall methodCall) async {
        throw Exception('This method must not be called');
      });

      const MethodChannel('flutter.baseflow.com/permissions/methods')
          .setMockMethodCallHandler((MethodCall methodCall) async {
        expect(methodCall.method, 'checkPermissionStatus');

        // argument is 9 - Photo
        expect(methodCall.arguments, 9);

        // return denied
        return 0;
      });

      final NartusMediaService service = NartusMediaService();

      MediaPermission permission = await service.checkMediaPermission();

      expect(permission, MediaPermission.denied);

      debugDefaultTargetPlatformOverride = null;
    });
  });

  group('requestPermission group', () {
    test('given device is Android with SDK less than 32, when requestPermissions, then request storage permission', () async {
      // device is Android
      debugDefaultTargetPlatformOverride = TargetPlatform.android;
      const MethodChannel('dev.fluttercommunity.plus/device_info')
          .setMockMethodCallHandler((MethodCall methodCall) async {
        expect(methodCall.method, 'getDeviceInfo');

        return androidDeviceInfo(31);
      });

      const MethodChannel('flutter.baseflow.com/permissions/methods')
          .setMockMethodCallHandler((MethodCall methodCall) async {
        expect(methodCall.method, 'requestPermissions');

        // argument is 15 - storage
        expect(methodCall.arguments, [15]);

        // return denied
        return {15: 0};
      });

      final NartusMediaService service = NartusMediaService();

      MediaPermission permission = await service.requestMediaPermission();

      expect(permission, MediaPermission.denied);

      debugDefaultTargetPlatformOverride = null;
    });

    test('given device is Android with SDK more than 32, when requestPermissions, then request photo permission', () async {
      // device is Android
      debugDefaultTargetPlatformOverride = TargetPlatform.android;
      const MethodChannel('dev.fluttercommunity.plus/device_info')
          .setMockMethodCallHandler((MethodCall methodCall) async {
        expect(methodCall.method, 'getDeviceInfo');

        return androidDeviceInfo(33);
      });

      const MethodChannel('flutter.baseflow.com/permissions/methods')
          .setMockMethodCallHandler((MethodCall methodCall) async {
        expect(methodCall.method, 'requestPermissions');

        // argument is 9 - Photo
        expect(methodCall.arguments, [9]);

        // return denied
        return {9: 0};
      });

      final NartusMediaService service = NartusMediaService();

      MediaPermission permission = await service.requestMediaPermission();

      expect(permission, MediaPermission.denied);

      debugDefaultTargetPlatformOverride = null;
    });

    test('given device is iOS, when requestPermissions, then request photo permission', () async {
      // device is Android
      debugDefaultTargetPlatformOverride = TargetPlatform.iOS;
      const MethodChannel('dev.fluttercommunity.plus/device_info')
          .setMockMethodCallHandler((MethodCall methodCall) async {
        throw Exception('This method must not be called');
      });

      const MethodChannel('flutter.baseflow.com/permissions/methods')
          .setMockMethodCallHandler((MethodCall methodCall) async {
        expect(methodCall.method, 'requestPermissions');

        // argument is 9 - Photo
        expect(methodCall.arguments, [9]);

        // return denied
        return {9: 0};
      });

      final NartusMediaService service = NartusMediaService();

      MediaPermission permission = await service.requestMediaPermission();

      expect(permission, MediaPermission.denied);

      debugDefaultTargetPlatformOverride = null;
    });
  });
}
