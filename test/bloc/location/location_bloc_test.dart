import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:interactive_diary/bloc/location/location_bloc.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:nartus_location/nartus_location.dart';
import 'location_bloc_test.mocks.dart';

@GenerateMocks(<Type>[LocationService])
void main() {
  final LocationService service = MockLocationService();

  group('Test event and states', () {
    blocTest(
        'when receive event RequestCurrentLocationEvent, then get current location from service',
        build: () => LocationBloc(locationService: service),
        setUp: () {
          when(service.getCurrentLocation()).thenAnswer(
              (_) => Future<LocationDetails>.value(LocationDetails(0.0, 0.0)));
        },
        act: (LocationBloc bloc) => bloc
            .add(RequestCurrentLocationEvent(PermissionStatusDiary.granted)),
        expect: () => <TypeMatcher<LocationState>>[isA<LocationReadyState>()]);
  });

  group('Test error and state', () {
    blocTest(
        'When location service throws LocationServiceDisableException, then state is LocationServiceDisableState',
        setUp: () {
          when(service.getCurrentLocation())
              .thenThrow(LocationServiceDisableException());
        },
        build: () => LocationBloc(locationService: service),
        act: (LocationBloc bloc) =>
            bloc.add(RequestCurrentLocationEvent(PermissionStatusDiary.denied)),
        expect: () =>
            <TypeMatcher<LocationState>>[isA<LocationServiceDisableState>()]);

    blocTest(
        'When location service throws LocationPermissionNotGrantedException, then state is LocationPermissionNotGrantedState',
        setUp: () => when(service.getCurrentLocation())
            .thenThrow(LocationPermissionNotGrantedException()),
        build: () => LocationBloc(locationService: service),
        act: (LocationBloc bloc) =>
            bloc.add(RequestCurrentLocationEvent(PermissionStatusDiary.denied)),
        expect: () => <TypeMatcher<LocationState>>[
              isA<LocationPermissionNotGrantedState>()
            ]);

    blocTest(
        'When request permission location granted, then get current location from service',
        setUp: () {
          when(service.requestPermission()).thenAnswer(
              (Invocation realInvocation) =>
                  Future<PermissionStatusDiary>.value(
                      PermissionStatusDiary.granted));
          when(service.getCurrentLocation()).thenAnswer(
              (_) => Future<LocationDetails>.value(LocationDetails(0.0, 0.0)));
        },
        build: () => LocationBloc(locationService: service),
        act: (LocationBloc bloc) => bloc
            .add(RequestCurrentLocationEvent(PermissionStatusDiary.granted)),
        expect: () => <TypeMatcher<LocationState>>[isA<LocationReadyState>()]);

    blocTest(
        'When request permission location denied, then state is LocationPermissionNotGrantedState(denied), the event is RequestCurrentLocationEvent(denied)',
        setUp: () {
          when(service.requestPermission()).thenAnswer(
              (Invocation realInvocation) =>
                  Future<PermissionStatusDiary>.value(
                      PermissionStatusDiary.denied));
          when(service.getCurrentLocation())
              .thenThrow(LocationPermissionNotGrantedException());
        },
        build: () => LocationBloc(locationService: service),
        act: (LocationBloc bloc) =>
            bloc.add(RequestCurrentLocationEvent(PermissionStatusDiary.denied)),
        expect: () => <TypeMatcher<LocationState>>[
              isA<LocationPermissionNotGrantedState>()
            ]);

    blocTest(
        'When request permission location deniedForever, then state is LocationPermissionNotGrantedState(deniedForever), the event is RequestCurrentLocationEvent(deniedForever)',
        setUp: () {
          when(service.requestPermission()).thenAnswer(
              (Invocation realInvocation) =>
                  Future<PermissionStatusDiary>.value(
                      PermissionStatusDiary.deniedForever));
          when(service.getCurrentLocation())
              .thenThrow(LocationPermissionNotGrantedException());
        },
        build: () => LocationBloc(locationService: service),
        act: (LocationBloc bloc) => bloc.add(
            RequestCurrentLocationEvent(PermissionStatusDiary.deniedForever)),
        expect: () => <TypeMatcher<LocationState>>[
              isA<LocationPermissionNotGrantedState>()
            ]);

    blocTest('when user click continue button, then get default location',
        setUp: () {
          when(service.requestPermission()).thenAnswer(
              (Invocation realInvocation) =>
                  Future<PermissionStatusDiary>.value(
                      PermissionStatusDiary.defaultLocation));
          when(service.getCurrentLocation()).thenAnswer(
              (_) => Future<LocationDetails>.value(LocationDetails(0.0, 0.0)));
        },
        build: () => LocationBloc(locationService: service),
        act: (LocationBloc bloc) => bloc.add(
            RequestCurrentLocationEvent(PermissionStatusDiary.defaultLocation)),
        expect: () => <TypeMatcher<LocationState>>[isA<LocationReadyState>()]);

    blocTest(
        'when location service returns invalid lat and long, then state is UnknownLocationErrorState',
        setUp: () => when(service.getCurrentLocation())
            .thenThrow(LocationDataCorruptedException()),
        build: () => LocationBloc(locationService: service),
        act: (LocationBloc bloc) =>
            bloc.add(RequestCurrentLocationEvent(PermissionStatusDiary.denied)),
        expect: () =>
            <TypeMatcher<LocationState>>[isA<UnknownLocationErrorState>()]);
  });
}
