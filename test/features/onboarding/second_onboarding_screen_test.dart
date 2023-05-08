import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:interactive_diary/bloc/app_config/app_config_bloc.dart';
import 'package:interactive_diary/features/onboarding/second_onboarding_screen.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:nartus_ui_package/widgets/buttons/nartus_button.dart';
import 'package:flutter/foundation.dart';

import '../../widget_tester_extension.dart';
import 'second_onboarding_screen_test.mocks.dart';

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

  testWidgets('Verify UI of Second Onboarding Screen - ios devices',
      (WidgetTester widgetTester) async {
    // Set platform to iOS
    debugDefaultTargetPlatformOverride = TargetPlatform.iOS;

    const SecondOnboardingScreen widget = SecondOnboardingScreen();

    await widgetTester.blocWrapAndPump<AppConfigBloc>(appConfigBloc, widget);

    expect(find.byType(PageView), findsOneWidget);

    expect(find.byType(DotsIndicator), findsOneWidget);

    expect(find.byType(SvgPicture), findsNWidgets(5));

    expect(find.byType(NartusButton), findsNWidgets(5));

    expect(find.text('Keep all your diaries private'), findsOneWidget);
    expect(
        find.bySemanticsLabel('Keep all your diaries private'), findsOneWidget);

    expect(find.text('Continue with Email'), findsOneWidget);
    expect(find.bySemanticsLabel(', Continue with Email'), findsOneWidget);

    expect(find.text('Continue as guest'), findsOneWidget);
    expect(find.bySemanticsLabel('Continue as guest'), findsOneWidget);

    expect(find.bySemanticsLabel('Continue with Google'), findsOneWidget);
    expect(find.bySemanticsLabel('Continue with Facebook'), findsOneWidget);
    expect(find.bySemanticsLabel('Continue with Apple'), findsOneWidget);

    // swipe right
    await widgetTester.drag(find.byType(PageView), const Offset(-500, 0));
    // allow animation
    await widgetTester.pumpAndSettle(const Duration(milliseconds: 201));
    // verify page 1 is not visible
    expect(find.text('Access your diaries anywhere'), findsOneWidget);
    expect(
        find.bySemanticsLabel('Access your diaries anywhere'), findsOneWidget);

    debugDefaultTargetPlatformOverride = null;
  });

  testWidgets('Verify UI of Second Onboarding Screen - android devices',
      (WidgetTester widgetTester) async {
    // Set platform to android
    debugDefaultTargetPlatformOverride = TargetPlatform.android;

    const SecondOnboardingScreen widget = SecondOnboardingScreen();

    await widgetTester.blocWrapAndPump<AppConfigBloc>(appConfigBloc, widget);

    expect(find.byType(PageView), findsOneWidget);

    expect(find.byType(DotsIndicator), findsOneWidget);

    expect(find.byType(SvgPicture), findsNWidgets(4));

    expect(find.byType(NartusButton), findsNWidgets(4));

    expect(find.text('Keep all your diaries private'), findsOneWidget);
    expect(
        find.bySemanticsLabel('Keep all your diaries private'), findsOneWidget);

    expect(find.text('Continue with Email'), findsOneWidget);
    expect(find.bySemanticsLabel(', Continue with Email'), findsOneWidget);

    expect(find.text('Continue as guest'), findsOneWidget);
    expect(find.bySemanticsLabel('Continue as guest'), findsOneWidget);

    expect(find.bySemanticsLabel('Continue with Google'), findsOneWidget);
    expect(find.bySemanticsLabel('Continue with Facebook'), findsOneWidget);

    // swipe right
    await widgetTester.drag(find.byType(PageView), const Offset(-500, 0));
    // allow animation
    await widgetTester.pumpAndSettle(const Duration(milliseconds: 201));
    // verify page 1 is not visible
    expect(find.text('Access your diaries anywhere'), findsOneWidget);
    expect(
        find.bySemanticsLabel('Access your diaries anywhere'), findsOneWidget);

    debugDefaultTargetPlatformOverride = null;
  });
}
