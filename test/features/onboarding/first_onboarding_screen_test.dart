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

        // verify screen components
        expect(find.byType(SvgPicture), findsOneWidget);
        expect(find.byType(NartusButton), findsOneWidget);
        expect(find.text('Welcome to InnerME 🙌'), findsOneWidget);
        expect(find.text('Get Started'), findsOneWidget);
        expect(find.bySemanticsLabel('Get Started'), findsOneWidget);
        expect(
            find.text(
                'Discover all the cool features right now'),
            findsOneWidget);
        expect(find.bySemanticsLabel(
            'Discover all the cool features right now'),
            findsOneWidget);

        // verify image fitting
        SvgPicture svgPicture = widgetTester.widget(find.byType(SvgPicture));
        // expect(svgPicture.fit, BoxFit.fitWidth);
      });
}
