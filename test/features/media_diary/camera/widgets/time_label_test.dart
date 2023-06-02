import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:interactive_diary/features/media_diary/camera/widgets/time_label.dart';

import '../../../../widget_tester_extension.dart';

void main() {
  testWidgets('Verify UI component of TimeLabel', (widgetTester) async {
    final AnimationController timerController =
        AnimationController(vsync: const TestVSync());
    final Widget timeLabel = TimeLabel(controller: timerController);

    await widgetTester.wrapAndPump(timeLabel);
    expect(find.text('00:00'), findsOneWidget);

    // verify border radius
    Container container = widgetTester.widget(find.byType(Container));
    expect(container.decoration, isA<BoxDecoration>());

    BoxDecoration boxDecoration = container.decoration as BoxDecoration;
    expect(boxDecoration.borderRadius, isA<BorderRadius>());

    BorderRadius borderRadius = boxDecoration.borderRadius as BorderRadius;
    expect(borderRadius.bottomLeft.x, 80);
    expect(borderRadius.bottomLeft.y, 80);
    expect(borderRadius.bottomRight.x, 80);
    expect(borderRadius.bottomRight.y, 80);
    expect(borderRadius.topLeft.x, 80);
    expect(borderRadius.topLeft.y, 80);
    expect(borderRadius.topRight.x, 80);
    expect(borderRadius.topRight.y, 80);

    // verify background color
    expect(boxDecoration.color, const Color(0xFFFFFFFF));

    // verify text style
    Text text = widgetTester.widget(find.text('00:00'));
    expect(text.style?.fontSize, 16);
    expect(text.style?.color, const Color(0xFFB3261E));
  });
}
