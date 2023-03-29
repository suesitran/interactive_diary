import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:interactive_diary/features/onboarding/second_onboarding_screen.dart';
import 'package:nartus_ui_package/widgets/buttons/nartus_button.dart';
import 'package:flutter/foundation.dart';

import '../../widget_tester_extension.dart';

void main() {
  testWidgets('Verify UI of Second Onboarding Screen - ios devices',
      (WidgetTester widgetTester) async {
    // Set platform to iOS
    debugDefaultTargetPlatformOverride = TargetPlatform.iOS;

    const SecondOnboardingScreen widget = SecondOnboardingScreen();

    await widgetTester.wrapAndPump(widget);

    expect(find.byType(PageView), findsOneWidget);

    // expect(find.byType(DotsIndicator), findsOneWidget);

    // expect(find.byType(SvgPicture), findsNWidgets(5));
    //
    // expect(find.byType(NartusButton), findsNWidgets(2));
    //
    // expect(find.text('Keep all your diaries private'), findsOneWidget);
    // expect(find.bySemanticsLabel('Keep all your diaries private'), findsOneWidget);
    //
    // expect(find.text('Continue with Email'), findsOneWidget);
    // expect(find.bySemanticsLabel(', Continue with Email'), findsOneWidget);
    //
    // expect(find.text('Continue as guest'), findsOneWidget);
    // expect(find.bySemanticsLabel('Continue as guest'), findsOneWidget);
    //
    // expect(find.bySemanticsLabel('Continue with Google'), findsOneWidget);
    // expect(find.bySemanticsLabel('Continue with Facebook'), findsOneWidget);
    // expect(find.bySemanticsLabel('Continue with Apple'), findsOneWidget);
    //
    // debugDefaultTargetPlatformOverride = null;
  });

  testWidgets('Verify UI of Second Onboarding Screen - android devices',
      (WidgetTester widgetTester) async {
    // Set platform to iOS
    debugDefaultTargetPlatformOverride = TargetPlatform.android;

    const SecondOnboardingScreen widget = SecondOnboardingScreen();

    await widgetTester.wrapAndPump(widget);

    expect(find.byType(PageView), findsOneWidget);

    expect(find.byType(DotsIndicator), findsOneWidget);

    expect(find.byType(SvgPicture), findsNWidgets(4));

    expect(find.byType(NartusButton), findsNWidgets(2));

    expect(find.text('Keep all your diaries private'), findsOneWidget);
    expect(
        find.bySemanticsLabel('Keep all your diaries private'), findsOneWidget);

    expect(find.text('Continue with Email'), findsOneWidget);
    expect(find.bySemanticsLabel(', Continue with Email'), findsOneWidget);

    expect(find.text('Continue as guest'), findsOneWidget);
    expect(find.bySemanticsLabel('Continue as guest'), findsOneWidget);

    expect(find.bySemanticsLabel('Continue with Google'), findsOneWidget);
    expect(find.bySemanticsLabel('Continue with Facebook'), findsOneWidget);

    debugDefaultTargetPlatformOverride = null;
  });
}