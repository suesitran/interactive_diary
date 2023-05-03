import 'package:flutter/foundation.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:interactive_diary/features/onboarding/login_options.dart';

import '../../widget_tester_extension.dart';

void main() {
  testWidgets(
      'GIVEN android device '
      'WHEN get login options '
      'THEN only google and facebook options are shown',
      (WidgetTester widgetTester) async {
    // given
    debugDefaultTargetPlatformOverride = TargetPlatform.android;
    const loginOptions = LoginOptions();

    // when
    await widgetTester.wrapAndPump(loginOptions);

    // then
    expect(find.byType(SvgPicture), findsNWidgets(2));
    expect(find.bySemanticsLabel('Continue with Google'), findsOneWidget);
    expect(find.bySemanticsLabel('Continue with Facebook'), findsOneWidget);
    expect(find.bySemanticsLabel('Continue with Apple'), findsNothing);

    debugDefaultTargetPlatformOverride = null;
  });

  testWidgets(
      'GIVEN android device '
      'WHEN get login options '
      'THEN google and facebook and apple options is shown',
      (WidgetTester widgetTester) async {
    // given
    debugDefaultTargetPlatformOverride = TargetPlatform.iOS;
    const loginOptions = LoginOptions();

    // when
    await widgetTester.wrapAndPump(loginOptions);

    // then
    expect(find.byType(SvgPicture), findsNWidgets(3));
    expect(find.bySemanticsLabel('Continue with Google'), findsOneWidget);
    expect(find.bySemanticsLabel('Continue with Facebook'), findsOneWidget);
    expect(find.bySemanticsLabel('Continue with Apple'), findsOneWidget);

    debugDefaultTargetPlatformOverride = null;
  });
}
