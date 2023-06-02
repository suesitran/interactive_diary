import 'package:flutter/material.dart';
import 'package:nartus_ui_package/dimens/dimens.dart';
import 'package:nartus_ui_package/theme/nartus_theme.dart';

import 'package:interactive_diary/generated/l10n.dart';

class ShutterButton extends StatefulWidget {
  final AnimationController animationController;
  final VoidCallback onShutterTapped;
  final VoidCallback onShutterLongPressStart;
  final VoidCallback onShutterLongPressEnd;

  ShutterButton(
      {required this.animationController,
      required this.onShutterTapped,
      required this.onShutterLongPressStart,
      required this.onShutterLongPressEnd,
      Key? key})
      : super(key: key);

  @override
  State<ShutterButton> createState() => _ShutterButtonState();
}

class _ShutterButtonState extends State<ShutterButton> with TickerProviderStateMixin {

  late final Animation<double> _innerRing = Tween<double>(
    begin: 64,
    end: 60
  ).animate(widget.animationController);

  late final Animation<double> _outerRing = Tween<double>(
    begin: 76,
    end: 90
  ).animate(widget.animationController);

  @override
  void initState() {
    super.initState();

    widget.animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        // start timer ring
      }
    });
  }

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
            builder: (context, child) => Container(
              width: _outerRing.value,
              height: _outerRing.value,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                      color: NartusColor.white, width: NartusDimens.padding4),
                  color: Colors.transparent),
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
      );
}
