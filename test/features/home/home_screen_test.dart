import 'package:flutter_test/flutter_test.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:interactive_diary/features/home/home_screen.dart';

import '../../widget_tester_extension.dart';

void main() {
  testWidgets('When IDHome screen is loaded, then GoogleMap is presented',
      (WidgetTester widgetTester) async {
    const IDHome widget = IDHome();

    await widgetTester.wrapAndPump(widget);

    expect(find.byType(GoogleMap), findsOneWidget);
  });
}
