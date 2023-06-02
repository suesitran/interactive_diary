import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nartus_ui_package/dimens/dimens.dart';
import 'package:nartus_ui_package/theme/nartus_theme.dart';

class MapHandlerButton extends StatelessWidget {
  final String svgPath;
  final VoidCallback onTap;

  const MapHandlerButton({required this.svgPath, required this.onTap, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) => Container(
        width: NartusDimens.radius40,
        height: NartusDimens.radius40,
        decoration: ShapeDecoration(
            shape: const CircleBorder(),
            color: NartusColor.white,
            shadows: [
              BoxShadow(
                color: NartusColor.black.withOpacity(0.1),
                blurRadius: 10,
                blurStyle: BlurStyle.outer,
              )
            ]),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(40),
            onTap: onTap,
            child: Padding(
              padding: const EdgeInsets.all(NartusDimens.padding8),
              child: SvgPicture.asset(svgPath),
            ),
          ),
        ),
      );
}
