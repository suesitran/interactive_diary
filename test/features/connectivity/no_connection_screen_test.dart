import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:interactive_diary/features/connectivity/no_connection_screen.dart';

import '../../widget_tester_extension.dart';

void main() {
  testWidgets('Verify UI of No connection screen',
      (WidgetTester widgetTester) async {
    const NoConnectionScreen widget = NoConnectionScreen();

    await widgetTester.wrapAndPump(widget);

    // verify screen components
    expect(find.byType(SvgPicture), findsOneWidget);
    expect(find.text('Whoops!'), findsOneWidget);
    expect(
        find.text(
            'Slow or no internet connections.\nPlease check your internet settings'),
        findsOneWidget);

    // verify image fitting
    SvgPicture svgPicture = widgetTester.widget(find.byType(SvgPicture));
    expect(svgPicture.fit, BoxFit.fitWidth);
  });
}
