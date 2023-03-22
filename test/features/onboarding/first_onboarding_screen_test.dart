import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:interactive_diary/features/onboarding/first_onboarding_screen.dart';
import 'package:nartus_ui_package/nartus_ui.dart';

import '../../widget_tester_extension.dart';

void main() {
  testWidgets('Verify UI of First Onboarding Screen',
      (WidgetTester widgetTester) async {
        const FirstOnboardingScreen widget = FirstOnboardingScreen();

        await widgetTester.wrapAndPump(widget);

        expect(find.byType(SvgPicture), findsOneWidget);
        expect(find.byType(NartusButton), findsOneWidget);
        expect(find.text('Welcome to InnerME 🙌'), findsOneWidget);
        expect(find.text('Get Started'), findsOneWidget);
        expect(find.bySemanticsLabel('Get Started'), findsOneWidget);
        expect(find.text('Discover all the cool features right now'), findsOneWidget);
        expect(find.bySemanticsLabel('Discover all the cool features right now'),
            findsOneWidget);
      });
}
