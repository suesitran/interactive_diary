import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:interactive_diary/features/media_diary/camera/widgets/shutter_button.dart';

import '../../../../widget_tester_extension.dart';

void main() {
  testWidgets('verify UI components', (widgetTester) async {
    final AnimationController preparationController =
        AnimationController(vsync: const TestVSync())
          ..duration = const Duration(milliseconds: 100);
    final AnimationController timerController =
        AnimationController(vsync: const TestVSync())
          ..duration = const Duration(milliseconds: 100);

    bool shutterTap = false;
    bool shutterLongPressStart = false;
    bool shutterLongPressEnd = false;
    final Widget widget = ShutterButton(
      preparationController: preparationController,
      timerController: timerController,
      onShutterTapped: () => shutterTap = true,
      onShutterLongPressStart: () => shutterLongPressStart = true,
      onShutterLongPressEnd: () => shutterLongPressEnd = true,
    );

    await widgetTester.wrapAndPump(widget);

    // verify outer ring is displayed
    expect(
        find.descendant(
            of: find.byType(SizedOverflowBox),
            matching: find.ancestor(
                of: find.byType(AnimatedBuilder),
                matching: find.byType(Container))),
        findsOneWidget);

    // verify inner ring is displayed
    expect(
        find.descendant(
            of: find.byType(SizedOverflowBox),
            matching: find.descendant(
                of: find.byType(Container),
                matching: find.ancestor(
                    of: find.byType(Material),
                    matching: find.byType(Container)))),
        findsOneWidget);

    // verify tap action
    await widgetTester.tap(find.byType(ShutterButton));
    expect(shutterTap, isTrue);

    // verify long press action
    await widgetTester.longPress(find.byType(ShutterButton));
    expect(shutterLongPressStart, isTrue);
    expect(shutterLongPressEnd, isTrue);

    // check size of outer ring
    Container outerRing = widgetTester.widget(find.descendant(
        of: find.byType(SizedOverflowBox),
        matching: find.ancestor(
            of: find.byType(AnimatedBuilder),
            matching: find.byType(Container)))) as Container;
    expect(outerRing.constraints?.maxWidth, 76);
    expect(outerRing.constraints?.maxHeight, 76);

    // check size of inner ring
    Container innerRing = widgetTester.widget(find.descendant(
        of: find.byType(SizedOverflowBox),
        matching: find.descendant(
            of: find.byType(Container),
            matching: find.ancestor(
                of: find.byType(Material), matching: find.byType(Container)))));
    expect(innerRing.constraints?.maxWidth, 64);
    expect(innerRing.constraints?.maxHeight, 64);
  });
}
