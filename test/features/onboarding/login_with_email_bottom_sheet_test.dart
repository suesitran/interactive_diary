import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:interactive_diary/features/onboarding/login_with_email_bottom_sheet.dart';
import 'package:nartus_ui_package/nartus_ui.dart';

import '../../widget_tester_extension.dart';

void main() {
  testWidgets(
      'GIVEN android device '
      'WHEN login with email bottom sheet opened '
      'THEN the corresponding UI is displayed',
      (WidgetTester widgetTester) async {
    // given
    debugDefaultTargetPlatformOverride = TargetPlatform.android;
    const loginWithEmailBottomSheet = LoginWithEmailBottomSheet();

    // when
    await widgetTester.wrapAndPump(loginWithEmailBottomSheet);

    // then
    expect(find.text('Login with email'), findsOneWidget);
    expect(find.text('Your email'), findsOneWidget);
    expect(find.text('Enter your email'), findsOneWidget);
    expect(find.text('Password'), findsOneWidget);
    expect(find.text('Enter password'), findsOneWidget);
    expect(find.text('Forgot Password?'), findsOneWidget);
    expect(find.text('or login with'), findsOneWidget);
    expect(find.text('Login'), findsOneWidget);
    expect(find.byType(SvgPicture), findsNWidgets(3));
    expect(find.byType(TextField), findsNWidgets(2));
    expect(find.byType(NartusButton), findsNWidgets(3));

    debugDefaultTargetPlatformOverride = null;
  });

  testWidgets(
      'GIVEN android iOS '
      'WHEN login with email bottom sheet opened '
      'THEN the corresponding UI is displayed',
      (WidgetTester widgetTester) async {
    // given
    debugDefaultTargetPlatformOverride = TargetPlatform.iOS;
    const loginWithEmailBottomSheet = LoginWithEmailBottomSheet();

    // when
    await widgetTester.wrapAndPump(loginWithEmailBottomSheet);

    // then
    expect(find.text('Login with email'), findsOneWidget);
    expect(find.text('Your email'), findsOneWidget);
    expect(find.text('Enter your email'), findsOneWidget);
    expect(find.text('Password'), findsOneWidget);
    expect(find.text('Enter password'), findsOneWidget);
    expect(find.text('Forgot Password?'), findsOneWidget);
    expect(find.text('or login with'), findsOneWidget);
    expect(find.text('Login'), findsOneWidget);
    expect(find.byType(SvgPicture), findsNWidgets(4));
    expect(find.byType(TextField), findsNWidgets(2));
    expect(find.byType(NartusButton), findsNWidgets(4));

    debugDefaultTargetPlatformOverride = null;
  });
}
