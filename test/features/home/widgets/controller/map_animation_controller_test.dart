import 'package:flutter/animation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:interactive_diary/features/home/widgets/controller/map_animation_controller.dart';

void main() {
  testWidgets(
    '',
    (widgetTester) async {
      int move = 0;
      final MapAnimationController controller = MapAnimationController(
          vsync: widgetTester,
          onAnimationForward: () => move++,
          onAnimationBackward: () => move--,
          onUpdate: (p0) {},
          duration: const Duration(milliseconds: 1));

      controller.forward();
      expect(controller.status, AnimationStatus.forward);

      await widgetTester.pumpAndSettle();

      expect(move, 1);
      expect(controller.status, AnimationStatus.completed);

      controller.reverse();
      expect(controller.status, AnimationStatus.reverse);
      await widgetTester.pumpAndSettle();

      expect(move, 0);
      expect(controller.status, AnimationStatus.dismissed);
      expect(controller.value, 0.0);

      controller.dispose();
    },
  );
}
