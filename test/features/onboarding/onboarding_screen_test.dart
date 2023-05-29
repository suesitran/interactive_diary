import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:interactive_diary/bloc/app_config/app_config_bloc.dart';
import 'package:interactive_diary/features/onboarding/first_onboarding_screen.dart';
import 'package:interactive_diary/features/onboarding/onboarding_screen.dart';
import 'package:interactive_diary/features/onboarding/second_onboarding_screen.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../widget_tester_extension.dart';
import 'onboarding_screen_test.mocks.dart';

@GenerateMocks([AppConfigBloc])
void main() {
  final MockAppConfigBloc appConfigBloc = MockAppConfigBloc();

  setUp(() {
    when(appConfigBloc.state)
        .thenAnswer((realInvocation) => AppConfigInitial());
    when(appConfigBloc.stream)
        .thenAnswer((realInvocation) => Stream.value(AppConfigInitial()));
  });

  tearDown(() {
    reset(appConfigBloc);
  });

  testWidgets('verify the page view of onboarding', (widgetTester) async {
    final Widget widget = OnboardingScreen();

    await widgetTester.blocWrapAndPump<AppConfigBloc>(appConfigBloc, widget);

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

    // drag until Get Started is visible
    await widgetTester.dragUntilVisible(find.text('Get Started'),
        find.byType(SingleChildScrollView), const Offset(0, 100));
    // click on Get Started button
    await widgetTester.tap(find.text('Get Started'));
    // allow animation
    await widgetTester.pumpAndSettle(const Duration(milliseconds: 201));
    // verify page 1 is not visible
    expect(find.byType(FirstOnboardingScreen), findsNothing);
    expect(find.byType(SecondOnboardingScreen), findsOneWidget);
  });
}
