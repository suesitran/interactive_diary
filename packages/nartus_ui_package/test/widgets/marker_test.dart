import 'package:flutter_test/flutter_test.dart';
import 'package:nartus_ui_package/nartus_ui.dart';

import '../widget_tester_extension.dart';

void main() {
  group('Test Marker UI', () {
    testWidgets('When customMarker is call, show location icon and add icon',
        (WidgetTester tester) async {
      GlobalKey iconKey = GlobalKey();
      const icon = Icon(Icons.add);
      final CustomMarker customMarker =
          CustomMarker(height: 40, isTap: true, globalKeyMyWidget: iconKey);
      await tester.wrapMaterialAndPump(customMarker);
      expect(find.byType(CustomMarker), findsOneWidget);
      expect(find.byIcon(Icons.add), findsOneWidget);
      expect(find.byIcon(Icons.location_on), findsOneWidget);
    });
  });
}
