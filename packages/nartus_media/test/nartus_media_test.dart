import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:nartus_media/nartus_media.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  Map<String, dynamic> androidDeviceInfo(int version) => {
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

  group('Media checkPermissionGroup', () {
    test(
        'given device is Android with SDK less than 32, when checkMediaPermission, then check storage permission',
        () async {
      // device is Android
      debugDefaultTargetPlatformOverride = TargetPlatform.android;
      TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
          .setMockMethodCallHandler(
              const MethodChannel('dev.fluttercommunity.plus/device_info'),
              (MethodCall methodCall) async {
        expect(methodCall.method, 'getDeviceInfo');

        return androidDeviceInfo(31);
      });

      TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
          .setMockMethodCallHandler(
              const MethodChannel('flutter.baseflow.com/permissions/methods'),
              (MethodCall methodCall) async {
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

    test(
        'given device is Android with SDK more than 32, when checkMediaPermission, then check photo permission',
        () async {
      // device is Android
      debugDefaultTargetPlatformOverride = TargetPlatform.android;
      TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
          .setMockMethodCallHandler(
              const MethodChannel('dev.fluttercommunity.plus/device_info'),
              (MethodCall methodCall) async {
        expect(methodCall.method, 'getDeviceInfo');

        return androidDeviceInfo(33);
      });

      TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
          .setMockMethodCallHandler(
              const MethodChannel('flutter.baseflow.com/permissions/methods'),
              (MethodCall methodCall) async {
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

    test(
        'given device is iOS, when checkMediaPermission, then check photo permission',
        () async {
      // device is Android
      debugDefaultTargetPlatformOverride = TargetPlatform.iOS;
      TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
          .setMockMethodCallHandler(
              const MethodChannel('dev.fluttercommunity.plus/device_info'),
              (MethodCall methodCall) async {
        throw Exception('This method must not be called');
      });

      TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
          .setMockMethodCallHandler(
              const MethodChannel('flutter.baseflow.com/permissions/methods'),
              (MethodCall methodCall) async {
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

  group('media requestPermission group', () {
    test(
        'given device is Android with SDK less than 32, when requestPermissions, then request storage permission',
        () async {
      // device is Android
      debugDefaultTargetPlatformOverride = TargetPlatform.android;
      TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
          .setMockMethodCallHandler(
              const MethodChannel('dev.fluttercommunity.plus/device_info'),
              (MethodCall methodCall) async {
        expect(methodCall.method, 'getDeviceInfo');

        return androidDeviceInfo(31);
      });

      TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
          .setMockMethodCallHandler(
              const MethodChannel('flutter.baseflow.com/permissions/methods'),
              (MethodCall methodCall) async {
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

    test(
        'given device is Android with SDK more than 32, when requestPermissions, then request photo permission',
        () async {
      // device is Android
      debugDefaultTargetPlatformOverride = TargetPlatform.android;

      TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
          .setMockMethodCallHandler(
              const MethodChannel('dev.fluttercommunity.plus/device_info'),
              (MethodCall methodCall) async {
        expect(methodCall.method, 'getDeviceInfo');

        return androidDeviceInfo(33);
      });

      TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
          .setMockMethodCallHandler(
              const MethodChannel('flutter.baseflow.com/permissions/methods'),
              (MethodCall methodCall) async {
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

    test(
        'given device is iOS, when requestPermissions, then request photo permission',
        () async {
      // device is Android
      debugDefaultTargetPlatformOverride = TargetPlatform.iOS;

      TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
          .setMockMethodCallHandler(
              const MethodChannel('dev.fluttercommunity.plus/device_info'),
              (MethodCall methodCall) async {
        throw Exception('This method must not be called');
      });

      TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
          .setMockMethodCallHandler(
              const MethodChannel('flutter.baseflow.com/permissions/methods'),
              (MethodCall methodCall) async {
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

  group('Camera check permission group', () {
    test(
        'given permission is granted, when checkCameraPermission, then return MediaPermission.granted',
        () async {
      // given

      TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
          .setMockMethodCallHandler(
              const MethodChannel('flutter.baseflow.com/permissions/methods'),
              (MethodCall methodCall) async {
        expect(methodCall.method, 'checkPermissionStatus');

        // argument is 1 - camera
        expect(methodCall.arguments, 1);

        // return granted
        return 1;
      });

      // when
      final NartusMediaService service = NartusMediaService();

      MediaPermission permission = await service.checkCameraPermission();

      // then
      expect(permission, MediaPermission.granted);
    });

    test(
        'given permission is limited, when checkCameraPermission, then return MediaPermission.limited',
        () async {
      // given
      TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
          .setMockMethodCallHandler(
              const MethodChannel('flutter.baseflow.com/permissions/methods'),
              (MethodCall methodCall) async {
        expect(methodCall.method, 'checkPermissionStatus');

        // argument is 1 - camera
        expect(methodCall.arguments, 1);

        // return limited
        return 3;
      });

      // when
      final NartusMediaService service = NartusMediaService();

      MediaPermission permission = await service.checkCameraPermission();

      // then
      expect(permission, MediaPermission.limited);
    });

    test(
        'given permission is restricted, when checkCameraPermission, then return MediaPermission.denied',
        () async {
      // given
      TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
          .setMockMethodCallHandler(
              const MethodChannel('flutter.baseflow.com/permissions/methods'),
              (MethodCall methodCall) async {
        expect(methodCall.method, 'checkPermissionStatus');

        // argument is 1 - camera
        expect(methodCall.arguments, 1);

        // return restricted
        return 2;
      });

      // when
      final NartusMediaService service = NartusMediaService();

      MediaPermission permission = await service.checkCameraPermission();

      // then
      expect(permission, MediaPermission.denied);
    });

    test(
        'given permission is denied, when checkCameraPermission, then return MediaPermission.denied',
        () async {
      // given
      TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
          .setMockMethodCallHandler(
              const MethodChannel('flutter.baseflow.com/permissions/methods'),
              (MethodCall methodCall) async {
        expect(methodCall.method, 'checkPermissionStatus');

        // argument is 1 - camera
        expect(methodCall.arguments, 1);

        // return denied
        return 0;
      });

      // when
      final NartusMediaService service = NartusMediaService();

      MediaPermission permission = await service.checkCameraPermission();

      // then
      expect(permission, MediaPermission.denied);
    });

    test(
        'given permission is denied forever, when checkCameraPermission, then return MediaPermission.deniedForever',
        () async {
      // given
      TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
          .setMockMethodCallHandler(
              const MethodChannel('flutter.baseflow.com/permissions/methods'),
              (MethodCall methodCall) async {
        expect(methodCall.method, 'checkPermissionStatus');

        // argument is 1 - camera
        expect(methodCall.arguments, 1);

        // return deniedforever
        return 4;
      });

      // when
      final NartusMediaService service = NartusMediaService();

      MediaPermission permission = await service.checkCameraPermission();

      // then
      expect(permission, MediaPermission.deniedForever);
    });
  });

  group('Camera request permission group', () {
    test(
        'given permission is granted, when requestCameraPermission, then return MediaPermission.granted',
        () async {
      // given
      TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
          .setMockMethodCallHandler(
              const MethodChannel('flutter.baseflow.com/permissions/methods'),
              (MethodCall methodCall) async {
        expect(methodCall.method, 'requestPermissions');

        // argument is 1 - camera
        expect(methodCall.arguments, [1]);

        // return granted
        return {1: 1};
      });

      // when
      final NartusMediaService service = NartusMediaService();

      MediaPermission permission = await service.requestCameraPermission();

      // then
      expect(permission, MediaPermission.granted);
    });

    test(
        'given permission is limited, when requestCameraPermission, then return MediaPermission.limited',
        () async {
      // given
      TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
          .setMockMethodCallHandler(
              const MethodChannel('flutter.baseflow.com/permissions/methods'),
              (MethodCall methodCall) async {
        expect(methodCall.method, 'requestPermissions');

        // argument is 1 - camera
        expect(methodCall.arguments, [1]);

        // return limited
        return {1: 3};
      });

      // when
      final NartusMediaService service = NartusMediaService();

      MediaPermission permission = await service.requestCameraPermission();

      // then
      expect(permission, MediaPermission.limited);
    });

    test(
        'given permission is restricted, when requestCameraPermission, then return MediaPermission.denied',
        () async {
      // given
      TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
          .setMockMethodCallHandler(
              const MethodChannel('flutter.baseflow.com/permissions/methods'),
              (MethodCall methodCall) async {
        expect(methodCall.method, 'requestPermissions');

        // argument is 1 - camera
        expect(methodCall.arguments, [1]);

        // return restricted
        return {1: 2};
      });

      // when
      final NartusMediaService service = NartusMediaService();

      MediaPermission permission = await service.requestCameraPermission();

      // then
      expect(permission, MediaPermission.denied);
    });

    test(
        'given permission is denied, when requestCameraPermission, then return MediaPermission.denied',
        () async {
      // given
      TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
          .setMockMethodCallHandler(
              const MethodChannel('flutter.baseflow.com/permissions/methods'),
              (MethodCall methodCall) async {
        expect(methodCall.method, 'requestPermissions');

        // argument is 1 - camera
        expect(methodCall.arguments, [1]);

        // return denied
        return {1: 0};
      });

      // when
      final NartusMediaService service = NartusMediaService();

      MediaPermission permission = await service.requestCameraPermission();

      // then
      expect(permission, MediaPermission.denied);
    });

    test(
        'given permission is denied forever, when requestCameraPermission, then return MediaPermission.deniedForever',
        () async {
      // given
      TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
          .setMockMethodCallHandler(
              const MethodChannel('flutter.baseflow.com/permissions/methods'),
              (MethodCall methodCall) async {
        expect(methodCall.method, 'requestPermissions');

        // argument is 1 - camera
        expect(methodCall.arguments, [1]);

        // return deniedforever
        return {1: 4};
      });

      // when
      final NartusMediaService service = NartusMediaService();

      MediaPermission permission = await service.requestCameraPermission();

      // then
      expect(permission, MediaPermission.deniedForever);
    });

    test(
        'given permission is provisional, when requestCameraPermission, then return MediaPermission.granted',
        () async {
      // given
      TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
          .setMockMethodCallHandler(
              const MethodChannel('flutter.baseflow.com/permissions/methods'),
              (MethodCall methodCall) async {
        expect(methodCall.method, 'requestPermissions');

        // argument is 1 - camera
        expect(methodCall.arguments, [1]);

        // return provisional
        return {1: 5};
      });

      // when
      final NartusMediaService service = NartusMediaService();

      MediaPermission permission = await service.requestCameraPermission();

      // then
      expect(permission, MediaPermission.granted);
    });
  });
}
