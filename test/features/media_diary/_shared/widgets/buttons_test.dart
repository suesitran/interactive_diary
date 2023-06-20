import 'package:flutter_test/flutter_test.dart';
import 'package:interactive_diary/features/media_diary/_shared/widgets/buttons.dart';
import 'package:interactive_diary/gen/assets.gen.dart';
import 'package:network_image_mock/network_image_mock.dart';

import '../../../../widget_tester_extension.dart';

void main() {
  group('CircleButton widget UI validation', () {
    testWidgets(
        '[GIVEN] A CircleButton button is being displayed on the screen'
        '[WHEN]  User taps on it, '
        '[THEN]  onCapturedImage function will be called',
        (WidgetTester widgetTester) async {
      int counter = 0;

      final CircleButton button = CircleButton(
        size: 80,
        iconPath: Assets.images.closeIcon,
        semantic: 'CircleButton',
        onPressed: () => counter++,
      );

      await mockNetworkImagesFor(() => widgetTester.wrapAndPump(button));

      final btnFinder = find.byType(CircleButton);

      expect(btnFinder, findsOneWidget);
      expect(find.bySemanticsLabel('CircleButton'), findsOneWidget);
      expect(find.byType(CircleButton), findsOneWidget);
      await widgetTester.pumpAndSettle();
      await widgetTester.tap(find.byType(CircleButton));
      await widgetTester.pumpAndSettle();
      expect(counter, 1);
    });
  });
}
