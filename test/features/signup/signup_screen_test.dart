import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:interactive_diary/bloc/authentication/signup/google_signup_bloc.dart';
import 'package:interactive_diary/features/signup/signup_screen.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../mock_firebase.dart';
import '../../widget_tester_extension.dart';
import 'signup_screen_test.mocks.dart';


@GenerateMocks(<Type>[GoogleSignupBloc])
void main() {
  setupFirebaseAuthMocks();
  final GoogleSignupBloc mockSignUpBloc = MockGoogleSignupBloc();

  setUpAll(() async {
    await Firebase.initializeApp();
  });

  group('Signup with google', () {
    testWidgets('When State is GoogleSigningUp, then the Google button is in loading status',
      (WidgetTester widgetTester) async {
        const IDSignUp screen = IDSignUp();

        when(mockSignUpBloc.state)
          .thenAnswer((_) => GoogleSigningUp());

        await widgetTester.blocWrapAndPump<GoogleSignupBloc>(mockSignUpBloc, screen);

        expect(find.byType(CircularProgressIndicator), findsOneWidget);
      });
  });
}
