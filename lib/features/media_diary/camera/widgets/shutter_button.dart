import 'dart:math';

import 'package:flutter/material.dart';
import 'package:nartus_ui_package/dimens/dimens.dart';
import 'package:nartus_ui_package/theme/nartus_theme.dart';

import 'package:interactive_diary/generated/l10n.dart';

class ShutterButton extends StatefulWidget {
  final AnimationController preparationController;
  final AnimationController timerController;
  final VoidCallback onShutterTapped;
  final VoidCallback onShutterLongPressStart;
  final VoidCallback onShutterLongPressEnd;

  const ShutterButton(
      {required this.preparationController,
      required this.timerController,
      required this.onShutterTapped,
      required this.onShutterLongPressStart,
      required this.onShutterLongPressEnd,
      Key? key})
      : super(key: key);

  @override
  State<ShutterButton> createState() => _ShutterButtonState();
}

class _ShutterButtonState extends State<ShutterButton>
    with TickerProviderStateMixin {
  late final Animation<double> _innerRing =
      Tween<double>(begin: 64, end: 60).animate(widget.preparationController);

  late final Animation<double> _outerRing =
      Tween<double>(begin: 76, end: 90).animate(widget.preparationController);

  @override
  Widget build(BuildContext context) => Semantics(
        button: true,
        enabled: true,
        excludeSemantics: true,
        explicitChildNodes: false,
        label: S.current.captureMediaButton,
        child: SizedOverflowBox(
          size: const Size(76.0, 76.0),
          child: AnimatedBuilder(
            animation: _outerRing,
            builder: (context, child) => AnimatedBuilder(
              animation: widget.timerController,
              builder: (context, child) => Container(
                width: _outerRing.value,
                height: _outerRing.value,
                decoration: RingTimerDecoration(
                    size: _outerRing.value,
                    progress: widget.timerController.value),
                alignment: Alignment.center,
                child: AnimatedBuilder(
                  animation: _innerRing,
                  builder: (context, child) => Container(
                    width: _innerRing.value,
                    height: _innerRing.value,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: NartusColor.white, width: 4),
                        color: Colors.white),
                    child: Material(
                      color: Colors.transparent,
                      child: GestureDetector(
                        onTap: widget.onShutterTapped,
                        onLongPressStart: (details) {
                          widget.onShutterLongPressStart();
                        },
                        onLongPressEnd: (details) {
                          widget.onShutterLongPressEnd();
                        },
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      );
}

class RingTimerDecoration extends Decoration {
  final double size;
  final double progress;

  const RingTimerDecoration({required this.size, required this.progress});

  @override
  BoxPainter createBoxPainter([VoidCallback? onChanged]) =>
      _RingPainter(size: size, progress: progress);
}

class _RingPainter extends BoxPainter {
  final Paint _paint = Paint()
    ..color = NartusColor.white
    ..strokeWidth = NartusDimens.padding4
    ..strokeCap = StrokeCap.round
    ..isAntiAlias = true
    ..style = PaintingStyle.stroke;

  final Paint _timerPaint = Paint()
    ..color = NartusColor.red
    ..strokeWidth = NartusDimens.padding4
    ..strokeCap = StrokeCap.round
    ..isAntiAlias = true
    ..style = PaintingStyle.stroke;

  final double size;
  final double progress;

  _RingPainter({required this.size, required this.progress});

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration configuration) {
    if (progress > 0) {
      _drawBaseRing(canvas, offset, NartusColor.white.withOpacity(0.5));

      canvas.drawArc(
          Rect.fromCenter(
              center: offset.translate(size / 2, size / 2),
              width: size,
              height: size),
          -90 * pi / 180,
          progress * 360 * pi / 180,
          false,
          _timerPaint);
    } else {
      _drawBaseRing(canvas, offset, NartusColor.white);
    }
  }

  void _drawBaseRing(Canvas canvas, Offset offset, Color color) {
    _paint.color = color;
    canvas.drawArc(
        Rect.fromCenter(
            center: offset.translate(size / 2, size / 2),
            width: size,
            height: size),
        0,
        360 * pi / 180,
        false,
        _paint);
  }
}
