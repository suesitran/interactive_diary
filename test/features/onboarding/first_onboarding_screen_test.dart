import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:interactive_diary/features/onboarding/first_onboarding_screen.dart';
import 'package:nartus_ui_package/nartus_ui.dart';

import '../../widget_tester_extension.dart';

void main() {
  testWidgets('Verify UI of First Onboarding Screen',
      (WidgetTester widgetTester) async {
    int counter = 0;
    final FirstOnboardingScreen widget =
        FirstOnboardingScreen(onNextPageRequest: () {
      counter = 1;
    });

    await widgetTester.wrapAndPump(widget);

    expect(find.byType(SvgPicture), findsOneWidget);
    expect(find.byType(NartusButton), findsOneWidget);
    expect(find.text('Welcome to InnerME 🙌'), findsOneWidget);
    expect(find.text('Get Started'), findsOneWidget);
    expect(find.bySemanticsLabel('Get Started'), findsOneWidget);
    expect(find.text('A private space where you can be yourself.'),
        findsOneWidget);
    expect(find.bySemanticsLabel('A private space where you can be yourself.'),
        findsOneWidget);

    await widgetTester.dragUntilVisible(find.text('Get Started'),
        find.byType(SingleChildScrollView), const Offset(0, 100));
    await widgetTester.tap(find.text('Get Started'));
    await widgetTester.pump();
    expect(counter, 1);
  });
}
