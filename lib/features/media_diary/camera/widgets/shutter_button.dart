import 'package:flutter/material.dart';
import 'package:nartus_ui_package/dimens/dimens.dart';
import 'package:nartus_ui_package/theme/nartus_theme.dart';

import '../../../../generated/l10n.dart';

class ShutterButton extends StatelessWidget {
  final VoidCallback onShutterTapped;
  final VoidCallback onShutterLongPressStart;
  final VoidCallback onShutterLongPressEnd;

  const ShutterButton({required this.onShutterTapped, required this.onShutterLongPressStart, required this.onShutterLongPressEnd, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Semantics(
    button: true,
    enabled: true,
    excludeSemantics: true,
    explicitChildNodes: false,
    label: S.current.captureMediaButton,
    child: Container(
      width: NartusDimens.padding40 +
          NartusDimens.padding32 +
          NartusDimens.padding4,
      height: NartusDimens.padding40 +
          NartusDimens.padding32 +
          NartusDimens.padding4,
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
              color: NartusColor.white,
              width: NartusDimens.padding4),
          color: Colors.transparent),
      padding: const EdgeInsets.all(NartusDimens.padding2),
      child: Container(
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
                color: NartusColor.white, width: 4),
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
  );
}
