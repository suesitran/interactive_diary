import 'package:flutter_test/flutter_test.dart';
import 'package:interactive_diary/features/camera/preview_screen.dart';
import 'package:interactive_diary/features/camera/widgets/buttons.dart';
import 'package:interactive_diary/generated/l10n.dart';
import 'package:nartus_ui_package/nartus_ui.dart';
import 'package:network_image_mock/network_image_mock.dart';

import '../../widget_tester_extension.dart';

void main() {
  testWidgets(
      '[GIVEN] User is in Camera Screen'
      '[WHEN]  User finished capturing media (take picture, record video, choose media from library), '
      '[THEN]  User will see 2 buttons (back, save) in the screen',
      (WidgetTester widgetTester) async {
    const PreviewScreen screen = PreviewScreen();

    await mockNetworkImagesFor(() => widgetTester.wrapAndPump(screen));

    expect(find.byType(CircleButton), findsOneWidget);
    expect(find.byType(NartusButton), findsOneWidget);
    expect(find.text(S.current.save), findsOneWidget);
  });

  testWidgets(
    '[GIVEN] User is in Preview Screen'
    '[WHEN]  User tap on CLOSE button, '
    '[THEN]  User will be redirected back to previous screen (Camera Screen)',
    (WidgetTester widgetTester) async {

    const PreviewScreen screen = PreviewScreen();

    await mockNetworkImagesFor(() => widgetTester.wrapAndPump(screen, useRouter: true));

    await widgetTester.pumpAndSettle();
    await widgetTester.tap(find.bySemanticsLabel(S.current.close));
    await widgetTester.pumpAndSettle();
    expect(find.byType(PreviewScreen), findsNothing);
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
}
