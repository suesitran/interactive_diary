
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:interactive_diary/bloc/authentication/signup/google_signup_bloc.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:nartus_authentication/nartus_authentication.dart';

import 'google_signup_bloc_test.mocks.dart';

@GenerateMocks(<Type>[AuthenticationService])
void main() {
  final AuthenticationService service = MockAuthenticationService();

  group('Test event and states', () {
    blocTest(
      'when receive event SignUpByGoogleEvent and signin succeed, then emit Succeed state',
      build: () => GoogleSignupBloc(authenticationService: service),
      setUp: () {
        when(service.signinGoogle()).thenAnswer(
          (_) => Future<AUser>.value(AUser(name: 'asdas')));
      },
      act: (GoogleSignupBloc bloc) => bloc.add(SignUpByGoogleEvent()),
      expect: () => <TypeMatcher<GoogleSignupState>>[isA<GoogleSignupSucceed>()]);

    blocTest(
      'when receive event SignUpByGoogleEvent but signin failed, then emit Failed state',
      build: () => GoogleSignupBloc(authenticationService: service),
      setUp: () {
        when(service.signinGoogle()).thenAnswer(
          (_) => throw AuthenticateFailedException.userCancelled());
      },
      act: (GoogleSignupBloc bloc) => bloc.add(SignUpByGoogleEvent()),
      expect: () => <TypeMatcher<GoogleSignupState>>[isA<GoogleSignupFailed>()]);
  });

  // group('Test error and state', () {
  //   blocTest(
  //       'When location service throws LocationServiceDisableException, then state is LocationServiceDisableState',
  //       setUp: () {
  //         when(service.getCurrentLocation())
  //             .thenThrow(LocationServiceDisableException());
  //       },
  //       build: () => LocationBloc(locationService: service),
  //       act: (LocationBloc bloc) => bloc.add(RequestCurrentLocationEvent()),
  //       expect: () =>
  //       <TypeMatcher<LocationState>>[isA<LocationServiceDisableState>()]);
  //
  //   blocTest(
  //       'When location service throws LocationPermissionNotGrantedException, then state is LocationPermissionNotGrantedState',
  //       setUp: () => when(service.getCurrentLocation())
  //           .thenThrow(LocationPermissionNotGrantedException()),
  //       build: () => LocationBloc(locationService: service),
  //       act: (LocationBloc bloc) => bloc.add(RequestCurrentLocationEvent()),
  //       expect: () => <TypeMatcher<LocationState>>[
  //         isA<LocationPermissionNotGrantedState>()
  //       ]);
  //
  //   blocTest(
  //       'when location service returns invalid lat and long, then state is UnknownLocationErrorState',
  //       setUp: () => when(service.getCurrentLocation())
  //           .thenThrow(LocationDataCorruptedException()),
  //       build: () => LocationBloc(locationService: service),
  //       act: (LocationBloc bloc) => bloc.add(RequestCurrentLocationEvent()),
  //       expect: () =>
  //       <TypeMatcher<LocationState>>[isA<UnknownLocationErrorState>()]);
  // });
}