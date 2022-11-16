import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:interactive_diary/features/home/widgets/google_map.dart';

import '../../../widget_tester_extension.dart';

void main() {
  testWidgets(
      'when load GoogleMapView, then show GoogleMap widget inside AnimatedBuilder',
      (WidgetTester widgetTester) async {
    GoogleMapView widget =
        const GoogleMapView(currentLocation: LatLng(0.0, 0.0));

    await widgetTester.wrapAndPump(Directionality(
      textDirection: TextDirection.ltr,
      child: widget,
    ));

    expect(
        find.descendant(
            of: find.byType(AnimatedBuilder), matching: find.byType(GoogleMap)),
        findsOneWidget);

    GoogleMap map = widgetTester.widget(find.byType(GoogleMap)) as GoogleMap;

    expect(map.markers.length, 1);
    expect(map.markers.first.position, const LatLng(0.0, 0.0));
  });
}
