import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:interactive_diary/features/home/bloc/location_bloc.dart';
import 'package:interactive_diary/service_locator/service_locator.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:nartus_geocoder/nartus_geocoder.dart' as gc;
import 'package:nartus_location/nartus_location.dart';

import 'location_bloc_test.mocks.dart';

@GenerateMocks(<Type>[LocationService, gc.GeocoderService])
void main() {
  final MockLocationService locationService = MockLocationService();
  final MockGeocoderService geocoderService = MockGeocoderService();
  TestWidgetsFlutterBinding.ensureInitialized();

  setUpAll(() {
    ServiceLocator.instance.registerSingleton<LocationService>(locationService);
    ServiceLocator.instance
        .registerSingleton<gc.GeocoderService>(geocoderService);
  });

  setUp(() {
    when(locationService.getCurrentLocation()).thenAnswer(
        (_) => Future<LocationDetails>.value(LocationDetails(0.0, 0.0)));
    when(geocoderService.getCurrentPlaceCoding(any, any)).thenAnswer(
        (realInvocation) => Future.value(gc.LocationDetail('', '')));
  });

  group('event request current location', () {
    tearDown(() => reset(locationService));

    blocTest(
        'given location is ready, when RequestCurrentLocationEvent, then return LocationDetails',
        build: () => LocationBloc(),
        setUp: () => when(locationService.getCurrentLocation()).thenAnswer(
            (_) => Future<LocationDetails>.value(LocationDetails(0.0, 0.0))),
        act: (LocationBloc bloc) => bloc.requestCurrentLocation(),
        expect: () => <TypeMatcher<LocationState>>[isA<LocationReadyState>()]);

    blocTest(
        'given location permission denied, when RequestCurrentLocationEvent, then state is LocationPermissionDeniedState',
        build: () => LocationBloc(),
        setUp: () => when(locationService.getCurrentLocation())
            .thenThrow(LocationPermissionDeniedException()),
        act: (LocationBloc bloc) => bloc.requestCurrentLocation(),
        expect: () =>
            <TypeMatcher<LocationState>>[isA<LocationPermissionDeniedState>()]);

    blocTest(
        'given location permission denied forever, when RequestCurrentLocationEvent, then state is LocationPermissionDeniedForeverState',
        build: () => LocationBloc(),
        setUp: () => when(locationService.getCurrentLocation())
            .thenThrow(LocationPermissionDeniedForeverException()),
        act: (LocationBloc bloc) => bloc.requestCurrentLocation(),
        expect: () => <TypeMatcher<LocationState>>[
              isA<LocationPermissionDeniedForeverState>()
            ]);

    blocTest(
        'given location locationService throws error, when RequestCurrentLocationEvent, then state is UnknownLocationErrorState',
        build: () => LocationBloc(),
        setUp: () =>
            when(locationService.getCurrentLocation()).thenThrow(Exception()),
        act: (LocationBloc bloc) => bloc.requestCurrentLocation(),
        expect: () =>
            <TypeMatcher<LocationState>>[isA<UnknownLocationErrorState>()]);
  });

  group('Show dialog to request permission', () {
    tearDown(() => reset(locationService));

    blocTest(
        'given permission is granted, when ShowDialogRequestPermissionEvent, then return location details',
        build: () => LocationBloc(),
        setUp: () {
          when(locationService.requestPermission()).thenAnswer((_) =>
              Future<PermissionStatusDiary>.value(
                  PermissionStatusDiary.granted));
          when(locationService.getCurrentLocation()).thenAnswer(
              (_) => Future<LocationDetails>.value(LocationDetails(0.0, 0.0)));
        },
        act: (LocationBloc bloc) => bloc.showDialogRequestPermissionEvent(),
        expect: () => <TypeMatcher<LocationState>>[isA<LocationReadyState>()]);

    blocTest(
        'given permission is denied, when ShowDialogRequestPermissionEvent, then state is LocationPermissionDeniedState',
        build: () => LocationBloc(),
        setUp: () => when(locationService.requestPermission()).thenAnswer((_) =>
            Future<PermissionStatusDiary>.value(PermissionStatusDiary.denied)),
        act: (LocationBloc bloc) => bloc.showDialogRequestPermissionEvent(),
        expect: () =>
            <TypeMatcher<LocationState>>[isA<LocationPermissionDeniedState>()]);

    blocTest(
        'given permission is denied forever, when ShowDialogRequestPermissionEvent, then state is LocationPermissionDeniedForeverState',
        build: () => LocationBloc(),
        setUp: () => when(locationService.requestPermission()).thenAnswer((_) =>
            Future<PermissionStatusDiary>.value(
                PermissionStatusDiary.deniedForever)),
        act: (LocationBloc bloc) => bloc.showDialogRequestPermissionEvent(),
        expect: () => <TypeMatcher<LocationState>>[
              isA<LocationPermissionDeniedForeverState>()
            ]);
  });

  group('other events', () {
    tearDown(() => reset(locationService));
    blocTest('verify default location',
        build: () => LocationBloc(),
        act: (LocationBloc bloc) => bloc.requestDefaultLocation(),
        expect: () => <TypeMatcher<LocationState>>[isA<LocationReadyState>()]);

    blocTest(
        'when open app settings, then state is AwaitLocationPermissionFromAppSettingState',
        build: () => LocationBloc(),
        act: (LocationBloc bloc) => bloc.openAppSettings(),
        setUp: () => when(locationService.requestOpenAppSettings())
            .thenAnswer((_) => Future<bool>.value(true)),
        expect: () {
          verify(locationService.requestOpenAppSettings()).called(1);
          return <TypeMatcher<LocationState>>[
            isA<AwaitLocationPermissionFromAppSettingState>()
          ];
        });

    blocTest(
        'when return from app settings, then request current location again',
        build: () => LocationBloc(),
        setUp: () => when(locationService.getCurrentLocation()).thenAnswer(
            (_) => Future<LocationDetails>.value(LocationDetails(0.0, 0.0))),
        act: (LocationBloc bloc) => bloc.onReturnFromSettings(),
        expect: () {
          verify(locationService.getCurrentLocation()).called(1);
          return <TypeMatcher<LocationState>>[isA<LocationReadyState>()];
        });

    blocTest(
      'when event is OpenLocationServiceEvent, then request service from location service, and emit AwaitLocationServiceSettingState',
      build: () => LocationBloc(),
      setUp: () => when(locationService.requestService())
          .thenAnswer((Invocation realInvocation) => Future<bool>.value(true)),
      act: (LocationBloc bloc) => bloc.openLocationServiceSetting(),
      verify: (LocationBloc bloc) =>
          verify(locationService.requestService()).called(1),
      expect: () =>
          <TypeMatcher<LocationState>>[isA<AwaitLocationServiceSettingState>()],
    );
  });
}
