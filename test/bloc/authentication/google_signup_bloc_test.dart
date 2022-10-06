import 'package:bloc_test/bloc_test.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:interactive_diary/bloc/authentication/signup/google_signup_bloc.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:nartus_authentication/nartus_authentication.dart';

import '../../mock_firebase.dart';
import 'google_signup_bloc_test.mocks.dart';

@GenerateMocks(<Type>[AuthenticationService])
void main() {
  setupFirebaseAuthMocks();
  final AuthenticationService service = MockAuthenticationService();

  setUpAll(() async {
    await Firebase.initializeApp();
  });

  group('Test event and states', () {
    blocTest(
        'when receive event SignUpByGoogleEvent and signin succeed, '
        'then emit Succeed state',
        build: () => GoogleSignupBloc(authenticationService: service),
        setUp: () {
          when(service.signinGoogle()).thenAnswer(
              (_) => Future<UserDetail>.value(UserDetail(name: 'asdas')));
        },
        act: (GoogleSignupBloc bloc) => bloc.add(SignUpByGoogleEvent()),
        expect: () => <TypeMatcher<GoogleSignupState>>[
              isA<GoogleSigningUpState>(),
              isA<GoogleSignupSucceedState>()
            ]);

    blocTest(
        'when receive event SignUpByGoogleEvent but signin failed due to user canceled, '
        'then emit initial state',
        build: () => GoogleSignupBloc(authenticationService: service),
        setUp: () {
          when(service.signinGoogle()).thenAnswer(
              (_) => throw AuthenticateFailedException.userCancelled());
        },
        act: (GoogleSignupBloc bloc) => bloc.add(SignUpByGoogleEvent()),
        expect: () => <TypeMatcher<GoogleSignupState>>[
              isA<GoogleSigningUpState>(),
              isA<GoogleSignupInitialState>()
            ]);

    blocTest(
        'when receive event SignUpByGoogleEvent but signin failed due to unknown error, '
        'then emit initial state',
        build: () => GoogleSignupBloc(authenticationService: service),
        setUp: () {
          when(service.signinGoogle())
              .thenAnswer((_) => throw AuthenticateFailedException.unknown());
        },
        act: (GoogleSignupBloc bloc) => bloc.add(SignUpByGoogleEvent()),
        expect: () => <TypeMatcher<GoogleSignupState>>[
              isA<GoogleSigningUpState>(),
              isA<GoogleSignupFailedState>()
            ]);
  });
}
