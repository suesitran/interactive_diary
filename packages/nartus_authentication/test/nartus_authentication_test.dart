import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:nartus_authentication/nartus_authentication.dart';

import 'nartus_authentication_test.mocks.dart';

@GenerateMocks([GoogleSignIn, FirebaseAuth])
void main() {
  final GoogleSignIn googleSignIn = MockGoogleSignIn();
  final FirebaseAuth firebaseAuth = MockFirebaseAuth();
  final AuthenticationService authService = AuthenticationService(
      googleSignIn: googleSignIn, firebaseAuth: firebaseAuth);

  group('test user canceled login flow', () {
    test(
        'given user signing in by google, when user cancel login, then throw AuthenticateFailedException.userCancelled',
        () async {
      when(googleSignIn.signIn()).thenAnswer((realInvocation) =>
          throw PlatformException(code: 'sign_in_canceled'));

      expect(() => authService.signinGoogle(),
          throwsA(isA<AuthenticateFailedException>()));
    });

    test(
        'given user signing in by google, when user cancel login, then throw AuthenticateFailedException.userCancelled',
        () async {
      when(googleSignIn.signIn())
          .thenAnswer((realInvocation) => Future.value(null));

      expect(() => authService.signinGoogle(),
          throwsA(isA<AuthenticateFailedException>()));
    });
  });
}
