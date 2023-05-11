import 'package:flutter_test/flutter_test.dart';
import 'package:interactive_diary/features/camera/widgets/buttons.dart';

import '../../../widget_tester_extension.dart';

void main() {
  group('CaptureMediaButton widget UI validation', () {
    testWidgets(
        '[GIVEN] A CaptureMediaButton button is being displayed on the screen'
        '[WHEN]  User taps on it, '
        '[THEN]  onCapturedImage function will be called',
        (WidgetTester widgetTester) async {
      int counter = 0;

      final CaptureMediaButton button = CaptureMediaButton(
        onCapturedImage: () => counter++,
        onEndRecordVideo: () {},
        onStartRecordVideo: () {},
      );

      await widgetTester.wrapAndPump(button);

      expect(find.byType(CaptureMediaButton), findsOneWidget);
      await widgetTester.tap(find.byType(CaptureMediaButton));
      await widgetTester.pump();
      expect(counter, 1);
    });

    testWidgets(
        '[GIVEN] A CaptureMediaButton button is being displayed on the screen'
        '[WHEN]  User tap on it for an amount of time, '
        '[THEN]  onStartRecordVideo function will be called',
        (WidgetTester widgetTester) async {
      int counter = 0;

      final CaptureMediaButton button = CaptureMediaButton(
        onCapturedImage: () {},
        onEndRecordVideo: () => counter++,
        onStartRecordVideo: () {},
      );

      await widgetTester.wrapAndPump(button);

      expect(find.byType(CaptureMediaButton), findsOneWidget);
      await widgetTester.tap(find.byType(CaptureMediaButton));
      await widgetTester.pump();
      expect(counter, 1);
    });

    // testWidgets(
    //     '[GIVEN] User is in Camera Screen'
    //     '[WHEN]  User tap on CAPTURE button, '
    //     '[THEN]  User will be moved to Preview Screen',
    //     (WidgetTester widgetTester) async {
    //   final CameraScreen screen = CameraScreen();

    //   await widgetTester.wrapAndPump(screen);

    //   await widgetTester.tap(find.byType(CaptureMediaButton));
    //   await widgetTester.pump();
    //   expect(find.byType(PreviewScreen), findsOneWidget);
    // });
  });

  group('CircleButton widget UI validation', () {
    testWidgets(
        '[GIVEN] A CircleButton button is being displayed on the screen'
        '[WHEN]  User taps on it, '
        '[THEN]  onCapturedImage function will be called',
        (WidgetTester widgetTester) async {
      int counter = 0;

      final CircleButton button = CircleButton(
        size: 80,
        iconPath: '',
        semantic: 'CircleButton',
        onPressed: () => counter++,
      );

      await widgetTester.wrapAndPump(button);

      final btnFinder = find.byType(CircleButton);

      expect(btnFinder, findsOneWidget);
      expect(find.bySemanticsLabel('CircleButton'), findsOneWidget);
      await widgetTester.tap(find.byType(CircleButton));
      await widgetTester.pump();
      expect(counter, 1);
    });
  });
}
