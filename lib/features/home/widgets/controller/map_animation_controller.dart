import 'package:flutter/animation.dart';

class MapAnimationController extends AnimationController {
  final VoidCallback onAnimationForward;
  final VoidCallback onAnimationBackward;
  final Function(double) onUpdate;

  MapAnimationController(
      {required this.onAnimationForward,
      required this.onAnimationBackward,
      required this.onUpdate,
      required super.vsync,
      super.duration}) {
    addStatusListener((status) {
      if (status == AnimationStatus.dismissed) {
        reset();
      }

      if (status == AnimationStatus.forward) {
        onAnimationForward.call();
      } else if (status == AnimationStatus.reverse) {
        onAnimationBackward.call();
      }
    });
    addListener(() {
      onUpdate(value);
    });
  }
}
