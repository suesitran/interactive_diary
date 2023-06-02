import 'package:flutter/material.dart';
import 'package:nartus_ui_package/dimens/dimens.dart';
import 'package:nartus_ui_package/theme/nartus_theme.dart';

import 'package:interactive_diary/generated/l10n.dart';

class ShutterButton extends StatelessWidget {
  final AnimationController animationController;
  final VoidCallback onShutterTapped;
  final VoidCallback onShutterLongPressStart;
  final VoidCallback onShutterLongPressEnd;

  const ShutterButton(
      {required this.animationController,
      required this.onShutterTapped,
      required this.onShutterLongPressStart,
      required this.onShutterLongPressEnd,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) => Semantics(
        button: true,
        enabled: true,
        excludeSemantics: true,
        explicitChildNodes: false,
        label: S.current.captureMediaButton,
        child: SizedOverflowBox(
          size: const Size(76.0, 76.0),
          child: Container(
            width: 76,
            height: 76,
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                    color: NartusColor.white, width: NartusDimens.padding4),
                color: Colors.transparent),
            alignment: Alignment.center,
            child: Container(
              width: 60.0,
              height: 60.0,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: NartusColor.white, width: 4),
                  color: Colors.white),
              child: Material(
                color: Colors.transparent,
                child: GestureDetector(
                  onTap: onShutterTapped,
                  onLongPressStart: (details) {
                    onShutterLongPressStart();
                  },
                  onLongPressEnd: (details) {
                    onShutterLongPressEnd();
                  },
                ),
              ),
            ),
          ),
        ),
      );
}
