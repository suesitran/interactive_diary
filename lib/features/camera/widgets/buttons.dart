import 'package:flutter_svg/flutter_svg.dart';
import 'package:nartus_ui_package/dimens/dimens.dart';
import 'package:nartus_ui_package/nartus_ui.dart';

class CircleButton extends StatelessWidget {
  final double size;
  final String iconPath;
  final String semantic;
  final VoidCallback onPressed;
  const CircleButton(
      {required this.size,
      required this.iconPath,
      required this.semantic,
      required this.onPressed,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: semantic,
      button: true,
      enabled: true,
      excludeSemantics: true,
      explicitChildNodes: false,
      child: GestureDetector(
        onTap: onPressed,
        child: Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: NartusColor.dark.withOpacity(.2),
          ),
          height: size,
          width: size,
          padding: const EdgeInsets.all(NartusDimens.padding10),
          child: FittedBox(child: SvgPicture.asset(iconPath)),
        ),
      ),
    );
  }
}
