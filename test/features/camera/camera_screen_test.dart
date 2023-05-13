import 'package:flutter_test/flutter_test.dart';
import 'package:interactive_diary/features/camera/camera_screen.dart';
import 'package:interactive_diary/features/camera/widgets/buttons.dart';
import 'package:interactive_diary/generated/l10n.dart';
import 'package:network_image_mock/network_image_mock.dart';

import '../../widget_tester_extension.dart';

void main() {
  testWidgets(
    '[GIVEN] User is in the app'
    '[WHEN]  User open camera screen, '
    '[THEN]  User will see 4 buttons (close, gallery, flip camera, capture) in the screen',
    (WidgetTester widgetTester) async {
    const CameraScreen screen = CameraScreen();

    await mockNetworkImagesFor(() => widgetTester.wrapAndPump(screen));

    expect(find.byType(CircleButton), findsNWidgets(3));
  });

  testWidgets(
    '[GIVEN] User is in Camera Screen'
    '[WHEN]  User tap on CLOSE button, '
    '[THEN]  User will be redirected back to previous screen (Home Screen)',
    (WidgetTester widgetTester) async {
    const CameraScreen screen = CameraScreen();

    await mockNetworkImagesFor(() => widgetTester.wrapAndPump(screen, useRouter: true));

    await widgetTester.pumpAndSettle();
    await widgetTester.tap(find.bySemanticsLabel(S.current.close));
    await widgetTester.pumpAndSettle();
    expect(find.byType(CameraScreen), findsNothing);
  });

  testWidgets(
    '[GIVEN] User is in Camera Screen'
    '[WHEN]  User tap on CAPTURE button, '
    '[THEN]  User will be moved to Preview Screen',
    (WidgetTester widgetTester) async {
    const CameraScreen screen = CameraScreen();

    await mockNetworkImagesFor(() => widgetTester.wrapAndPump(screen, useRouter: true));

    await widgetTester.pumpAndSettle();
    await widgetTester.tap(find.bySemanticsLabel(S.current.captureMediaButton));
    await widgetTester.pumpAndSettle();
    expect(find.byType(CameraScreen), findsNothing);
  });
}
