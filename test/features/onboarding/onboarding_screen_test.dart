import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:interactive_diary/features/onboarding/first_onboarding_screen.dart';
import 'package:interactive_diary/features/onboarding/onboarding_screen.dart';
import 'package:interactive_diary/features/onboarding/second_onboarding_screen.dart';

import '../../widget_tester_extension.dart';

void main() {
  testWidgets('verify the page view of onboarding', (widgetTester) async {
    final Widget widget = OnboardingScreen();

    await widgetTester.wrapAndPump(widget);

    // verify there's a page view in this page
    expect(find.byType(PageView), findsOneWidget);

    // verify page 1 is visible
    expect(find.byType(FirstOnboardingScreen), findsOneWidget);
    expect(find.text('Get Started'), findsOneWidget);

    // verify swiping is not available
    // swipe left
    await widgetTester.drag(find.byType(PageView), const Offset(500, 0));
    // verify page 1 is still visible
    expect(find.byType(FirstOnboardingScreen), findsOneWidget);
    expect(find.text('Get Started'), findsOneWidget);

    // swipe right
    await widgetTester.drag(find.byType(PageView), const Offset(-500, 0));
    // verify page 1 is still visible
    expect(find.byType(FirstOnboardingScreen), findsOneWidget);
    expect(find.text('Get Started'), findsOneWidget);

    // click on Get Started button
    await widgetTester.tap(find.text('Get Started'));
    // allow animation
    await widgetTester.pumpAndSettle(const Duration(milliseconds: 201));
    // verify page 1 is not visible
    expect(find.byType(FirstOnboardingScreen), findsNothing);
    expect(find.byType(SecondOnboardingScreen), findsOneWidget);
  });
}
