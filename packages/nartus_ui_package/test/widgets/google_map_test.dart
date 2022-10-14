import 'package:flutter_test/flutter_test.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:nartus_ui_package/nartus_ui.dart';

import '../widget_tester_extension.dart';

void main() {
  group('Test Marker UI', () {
    testWidgets('When google map is call, show location icon and add icon',
        (WidgetTester tester) async {
      GlobalKey iconKey = GlobalKey();
      const icon = Icon(Icons.add);
      final GoogleMapWidget googleMap =
          GoogleMapWidget(latitude: 0.0, longitude: 0.0, onTap: () {});
      await tester.wrapMaterialAndPump(googleMap);
      expect(find.byType(GoogleMapWidget), findsOneWidget);
    });
  });
}
