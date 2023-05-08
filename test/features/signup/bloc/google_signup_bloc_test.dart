import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:interactive_diary/features/signup/bloc/google_signup_bloc.dart';
import 'package:interactive_diary/service_locator/service_locator.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:nartus_authentication/nartus_authentication.dart';

import '../../../mock_firebase.dart';
import 'google_signup_bloc_test.mocks.dart';

@GenerateMocks(<Type>[AuthenticationService])
void main() {
  setupFirebaseAuthMocks();
  final MockAuthenticationService service = MockAuthenticationService();

  setUpAll(() => ServiceLocator.instance
      .registerSingleton<AuthenticationService>(service));

  group('Test event and states', () {
    blocTest(
        'when receive event SignUpByGoogleEvent and signin succeed, '
        'then emit Succeed state',
        build: () => GoogleSignupBloc(),
        setUp: () {
          when(service.signinGoogle()).thenAnswer(
              (_) => Future<UserDetail>.value(UserDetail(name: 'asdas')));
        },
        act: (GoogleSignupBloc bloc) => bloc.signUpGoogle(),
        expect: () => <TypeMatcher<GoogleSignupState>>[
              isA<GoogleSigningUpState>(),
              isA<GoogleSignupSucceedState>()
            ]);

    blocTest(
        'when receive event SignUpByGoogleEvent but signin failed due to user canceled, '
        'then emit initial state',
        build: () => GoogleSignupBloc(),
        setUp: () {
          when(service.signinGoogle()).thenAnswer(
              (_) => throw AuthenticateFailedException.userCancelled());
        },
        act: (GoogleSignupBloc bloc) => bloc.signUpGoogle(),
        expect: () => <TypeMatcher<GoogleSignupState>>[
              isA<GoogleSigningUpState>(),
              isA<GoogleSignupInitialState>()
            ]);

    blocTest(
        'when receive event SignUpByGoogleEvent but signin failed due to unknown error, '
        'then emit initial state',
        build: () => GoogleSignupBloc(),
        setUp: () {
          when(service.signinGoogle())
              .thenAnswer((_) => throw AuthenticateFailedException.unknown());
        },
        act: (GoogleSignupBloc bloc) => bloc.signUpGoogle(),
        expect: () => <TypeMatcher<GoogleSignupState>>[
              isA<GoogleSigningUpState>(),
              isA<GoogleSignupFailedState>()
            ]);
  });
}
