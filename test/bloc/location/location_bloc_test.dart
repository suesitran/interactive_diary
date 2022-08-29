import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:interactive_diary/bloc/location/location_bloc.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:nartus_location/nartus_location.dart';
import 'package:location/location.dart';
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
        act: (LocationBloc bloc) => bloc.add(RequestCurrentLocationEvent()),
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
        act: (LocationBloc bloc) => bloc.add(RequestCurrentLocationEvent()),
        expect: () =>
            <TypeMatcher<LocationState>>[isA<LocationServiceDisableState>()]);

    blocTest(
        'When location service throws LocationPermissionNotGrantedException, then state is LocationPermissionNotGrantedState',
        setUp: () => when(service.getCurrentLocation())
            .thenThrow(LocationPermissionNotGrantedException()),
        build: () => LocationBloc(locationService: service),
        act: (LocationBloc bloc) => bloc.add(RequestCurrentLocationEvent()),
        expect: () => <TypeMatcher<LocationState>>[
              isA<LocationPermissionNotGrantedState>()
            ]);

    blocTest(
        'when location service returns invalid lat and long, then state is UnknownLocationErrorState',
        setUp: () => when(service.getCurrentLocation())
            .thenThrow(LocationDataCorruptedException()),
        build: () => LocationBloc(locationService: service),
        act: (LocationBloc bloc) => bloc.add(RequestCurrentLocationEvent()),
        expect: () =>
            <TypeMatcher<LocationState>>[isA<UnknownLocationErrorState>()]);
  });
  group('Test event and states request Permission', () {
    blocTest(
        'when request Permission returns granted, then get current location from service',
        build: () => LocationBloc(locationService: service),
        setUp: () {
          when(service.requestPermission()).thenAnswer(
              (realInvocation) => Future.value(PermissionStatus.granted));
          when(service.getCurrentLocation()).thenAnswer(
              (_) => Future<LocationDetails>.value(LocationDetails(0.0, 0.0)));
        },
        act: (LocationBloc bloc) => bloc.add(RequestPermissionLocationEvent()),
        expect: () => <TypeMatcher<LocationState>>[isA<LocationReadyState>()]);

    blocTest(
        'when request Permission returns denied,  then state is LocationPermissionDeniedState',
        build: () => LocationBloc(locationService: service),
        setUp: () => when(service.requestPermission()).thenAnswer(
            (realInvocation) => Future.value(PermissionStatus.denied)),
        act: (LocationBloc bloc) => bloc.add(RequestPermissionLocationEvent()),
        expect: () =>
            <TypeMatcher<LocationState>>[isA<LocationPermissionDeniedState>()]);
    blocTest(
        'when request Permission returns deniedForever, then state is LocationPermissionDeniedState',
        build: () => LocationBloc(locationService: service),
        setUp: () => when(service.requestPermission()).thenAnswer(
            (realInvocation) => Future.value(PermissionStatus.deniedForever)),
        act: (LocationBloc bloc) => bloc.add(RequestPermissionLocationEvent()),
        expect: () =>
            <TypeMatcher<LocationState>>[isA<LocationPermissionDeniedState>()]);
  });
}
