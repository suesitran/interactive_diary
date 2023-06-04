import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:interactive_diary/features/media_diary/_shared/widgets/buttons.dart';
import 'package:interactive_diary/features/media_diary/camera/bloc/camera_setup_cubit.dart';
import 'package:interactive_diary/features/media_diary/camera/widgets/camera_control_layer.dart';
import 'package:interactive_diary/features/media_diary/camera/widgets/shutter_button.dart';
import 'package:interactive_diary/features/media_diary/camera/widgets/time_label.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../../widget_tester_extension.dart';
import '../camera_screen_test.mocks.dart';

@GenerateMocks([CameraSetupCubit])
void main() {
  final MockCameraSetupCubit cameraSetupCubit = MockCameraSetupCubit();

  setUp(() {
    when(cameraSetupCubit.state).thenReturn(CameraSetupInitial());
    when(cameraSetupCubit.stream)
        .thenAnswer((realInvocation) => Stream.value(CameraSetupInitial()));
  });

  tearDown(() => reset(cameraSetupCubit));

  testWidgets('verify UI component in camera control layer',
      (widgetTester) async {
    bool galleryTap = false;
    bool shutterTap = false;
    bool shutterLongPressStart = false;
    bool shutterLongPressEnd = false;
    final Widget widget = CameraControlsLayer(
      onGalleryTapped: () => galleryTap = true,
      onShutterTapped: () => shutterTap = true,
      onShutterLongPressStart: () => shutterLongPressStart = true,
      onShutterLongPressEnd: () => shutterLongPressEnd = true,
    );

    await widgetTester.blocWrapAndPump<CameraSetupCubit>(
        cameraSetupCubit, widget);

    expect(find.byCircleButton('Close'), findsOneWidget);
    expect(find.byCircleButton('Tap to open gallery album'), findsOneWidget);
    expect(find.byCircleButton('Tap to switch camera'), findsOneWidget);

    expect(find.byType(ShutterButton), findsOneWidget);
    expect(find.byType(TimeLabel), findsOneWidget);

    // tap on gallery button
    await widgetTester.tap(find.byCircleButton('Tap to open gallery album'));
    expect(galleryTap, isTrue);

    // tap on shutter button
    await widgetTester.tap(find.byType(ShutterButton));
    expect(shutterTap, isTrue);

    // long tap on shutter button
    await widgetTester.longPress(find.byType(ShutterButton));
    expect(shutterLongPressStart, isTrue);
    expect(shutterLongPressEnd, isTrue);
  });
}

extension FindCircleButtonWithSemantic on CommonFinders {
  Finder byCircleButton(String semantic) => byElementPredicate((element) =>
      element.widget is CircleButton &&
      (element.widget as CircleButton).semantic == semantic);
}
