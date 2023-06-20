import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:location/location.dart' hide PermissionStatus;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:nartus_location/nartus_location.dart';
import 'package:permission_handler/permission_handler.dart';

import 'nartus_location_test.mocks.dart';

@GenerateMocks([Location])
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  final Location location = MockLocation();

  final LocationService service = LocationService(location: location);

  group('Test current location', () {
    test(
        'given location service disabled, when get current location, then throw LocationServiceDisableException',
        () async {
      // given
      when(location.serviceEnabled())
          .thenAnswer((realInvocation) => Future.value(false));

      // then
      expect(() => service.getCurrentLocation(),
          throwsA(isA<LocationServiceDisableException>()));
    });

    test(
        'given location permission is limited, when get current location, then throw LocationPermissionDeniedException',
        () async {
      // given
      when(location.serviceEnabled()).thenAnswer((_) => Future.value(true));

      // mock method channel to avoid mocking on extension
      // ref: https://github.com/Baseflow/flutter-permission-handler/issues/262
      TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
          .setMockMethodCallHandler(
              const MethodChannel('flutter.baseflow.com/permissions/methods'),
              (MethodCall methodCall) async {
        expect(methodCall.method, 'checkPermissionStatus');
        return 3;
      });

      // then
      expect(() => service.getCurrentLocation(),
          throwsA(isA<LocationPermissionDeniedException>()));
    });

    test(
        'given location permission is denied, when get current location, then throw LocationPermissionDeniedException',
        () async {
      // given
      when(location.serviceEnabled()).thenAnswer((_) => Future.value(true));

      // mock method channel to avoid mocking on extension
      // ref: https://github.com/Baseflow/flutter-permission-handler/issues/262
      TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
          .setMockMethodCallHandler(
              const MethodChannel('flutter.baseflow.com/permissions/methods'),
              (MethodCall methodCall) async {
        expect(methodCall.method, 'checkPermissionStatus');
        return 0;
      });
      // then
      expect(() => service.getCurrentLocation(),
          throwsA(isA<LocationPermissionDeniedException>()));
    });

    test(
        'given location permission is restricted, when get current location, then throw LocationPermissionDeniedException',
        () async {
      // given
      when(location.serviceEnabled()).thenAnswer((_) => Future.value(true));

      // mock method channel to avoid mocking on extension
      // ref: https://github.com/Baseflow/flutter-permission-handler/issues/262
      TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
          .setMockMethodCallHandler(
              const MethodChannel('flutter.baseflow.com/permissions/methods'),
              (MethodCall methodCall) async {
        expect(methodCall.method, 'checkPermissionStatus');
        return 2;
      });

      // then
      expect(() => service.getCurrentLocation(),
          throwsA(isA<LocationPermissionDeniedException>()));
    });

    test(
        'give location permission is denied forever, when get current location, then throw LocationPermissionDeniedException',
        () async {
      // given
      when(location.serviceEnabled())
          .thenAnswer((realInvocation) => Future.value(true));

      // mock method channel to avoid mocking on extension
      // ref: https://github.com/Baseflow/flutter-permission-handler/issues/262
      TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
          .setMockMethodCallHandler(
              const MethodChannel('flutter.baseflow.com/permissions/methods'),
              (MethodCall methodCall) async {
        expect(methodCall.method, 'checkPermissionStatus');
        return 4;
      });

      // then
      expect(() => service.getCurrentLocation(),
          throwsA(isA<LocationPermissionDeniedForeverException>()));
    });

    test(
        'given location data returns null latitude and longitude, when get current location, then throw LocationDataCorruptedException',
        () async {
      // given
      when(location.serviceEnabled())
          .thenAnswer((realInvocation) => Future.value(true));

      // mock method channel to avoid mocking on extension
      // ref: https://github.com/Baseflow/flutter-permission-handler/issues/262
      TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
          .setMockMethodCallHandler(
              const MethodChannel('flutter.baseflow.com/permissions/methods'),
              (MethodCall methodCall) async {
        expect(methodCall.method, 'checkPermissionStatus');
        return 1;
      });
      when(location.getLocation()).thenAnswer(
          (realInvocation) => Future.value(LocationData.fromMap({})));

      // then
      expect(() => service.getCurrentLocation(),
          throwsA(isA<LocationDataCorruptedException>()));
    });

    test(
        'given location data returns valid latitude and longitude, when get current location, then return location details with lat and long',
        () async {
      // given
      when(location.serviceEnabled())
          .thenAnswer((realInvocation) => Future.value(true));

      // mock method channel to avoid mocking on extension
      // ref: https://github.com/Baseflow/flutter-permission-handler/issues/262
      TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
          .setMockMethodCallHandler(
              const MethodChannel('flutter.baseflow.com/permissions/methods'),
              (MethodCall methodCall) async {
        expect(methodCall.method, 'checkPermissionStatus');
        return 1;
      });
      when(location.getLocation()).thenAnswer((realInvocation) => Future.value(
          LocationData.fromMap({'latitude': 100.00, 'longitude': 200.00})));

      // when
      LocationDetails result = await service.getCurrentLocation();

      // then
      expect(result.latitude, 100.00);
      expect(result.longitude, 200.00);
    });

    test(
        'when requestService, then invoke location requestService exactly once',
        () async {
      when(location.requestService())
          .thenAnswer((realInvocation) => Future.value(true));
      // when
      await service.requestService();

      verify(location.requestService()).called(1);
    });
  });

  group('Test check permission', () {
    test(
        'given PermissionStatus.granted, when checkPermission, then return PermissionStatusDiary.granted',
        () async {
      const PermissionStatus status = PermissionStatus.granted;

      // when
      final result = await service.checkPermission(permissionStatus: status);

      expect(result, PermissionStatusDiary.granted);
    });

    test(
        'given PermissionStatus.denied, when checkPermission, then return PermissionStatusDiary.denied',
        () async {
      const PermissionStatus status = PermissionStatus.denied;

      // when
      final result = await service.checkPermission(permissionStatus: status);

      expect(result, PermissionStatusDiary.denied);
    });

    test(
        'given PermissionStatus.restricted, when checkPermission, then return PermissionStatusDiary.denied',
        () async {
      const PermissionStatus status = PermissionStatus.restricted;

      // when
      final result = await service.checkPermission(permissionStatus: status);

      expect(result, PermissionStatusDiary.denied);
    });

    test(
        'given PermissionStatus.limited, when checkPermission, then return PermissionStatusDiary.denied',
        () async {
      const PermissionStatus status = PermissionStatus.limited;

      // when
      final result = await service.checkPermission(permissionStatus: status);

      expect(result, PermissionStatusDiary.denied);
    });

    test(
        'given PermissionStatus.permanentlyDenied, when checkPermission, then return PermissionStatusDiary.deniedForever',
        () async {
      const PermissionStatus status = PermissionStatus.permanentlyDenied;

      // when
      final result = await service.checkPermission(permissionStatus: status);

      expect(result, PermissionStatusDiary.deniedForever);
    });

    test(
        'given no PermissionStatus, when checkPermission, then check from Permission.status',
        () {
      // mock method channel to avoid mocking on extension
      // ref: https://github.com/Baseflow/flutter-permission-handler/issues/262
      TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
          .setMockMethodCallHandler(
              const MethodChannel('flutter.baseflow.com/permissions/methods'),
              (MethodCall methodCall) async {
        // expect to call this method from method channel
        expect(methodCall.method, 'checkPermissionStatus');
        return 1;
      });

      // when
      service.checkPermission();
    });
  });

  group('Test request permission', () {
    test(
        'given PermissionStatus.denied, when requestPermission, then call request permission from channel',
        () {
      // mock method channel to avoid mocking on extension
      // ref: https://github.com/Baseflow/flutter-permission-handler/issues/262
      TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
          .setMockMethodCallHandler(
              const MethodChannel('flutter.baseflow.com/permissions/methods'),
              (MethodCall methodCall) async {
        if (methodCall.method == 'checkPermissionStatus') {
          // given
          return 0;
        }

        expect(methodCall.method, 'requestPermissions');
        return <int, int>{3: 1};
      });

      service.requestPermission();
    });

    test(
        'given PermissionStatus.restricted, when requestPermission, then call request permission from channel',
        () {
      // mock method channel to avoid mocking on extension
      // ref: https://github.com/Baseflow/flutter-permission-handler/issues/262
      TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
          .setMockMethodCallHandler(
              const MethodChannel('flutter.baseflow.com/permissions/methods'),
              (MethodCall methodCall) async {
        if (methodCall.method == 'checkPermissionStatus') {
          // given
          return 2;
        }

        expect(methodCall.method, 'requestPermissions');
        return <int, int>{3: 1};
      });

      service.requestPermission();
    });

    test(
        'given PermissionStatus.limited, when requestPermission, then call request permission from channel',
        () {
      // mock method channel to avoid mocking on extension
      // ref: https://github.com/Baseflow/flutter-permission-handler/issues/262
      TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
          .setMockMethodCallHandler(
              const MethodChannel('flutter.baseflow.com/permissions/methods'),
              (MethodCall methodCall) async {
        if (methodCall.method == 'checkPermissionStatus') {
          // given
          return 3;
        }

        expect(methodCall.method, 'requestPermissions');
        return <int, int>{3: 1};
      });

      service.requestPermission();
    });

    test(
        'given PermissionStatus.permanentlyDenied, when requestPermission, then call request permission from channel',
        () {
      // mock method channel to avoid mocking on extension
      // ref: https://github.com/Baseflow/flutter-permission-handler/issues/262
      TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
          .setMockMethodCallHandler(
              const MethodChannel('flutter.baseflow.com/permissions/methods'),
              (MethodCall methodCall) async {
        if (methodCall.method == 'checkPermissionStatus') {
          // given
          return 4;
        }

        expect(methodCall.method, 'requestPermissions');
        return <int, int>{3: 1};
      });

      service.requestPermission();
    });
  });
}
