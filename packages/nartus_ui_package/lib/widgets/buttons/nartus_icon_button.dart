part of 'nartus_button.dart';

class _NartusIconButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String iconPath;
  final String? iconSemanticLabel;
  final SizeType sizeType;
  final Color? color;

  const _NartusIconButton(
      {required this.onPressed,
      required this.iconPath,
      required this.iconSemanticLabel,
      required this.sizeType,
      required this.color,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) => IconButton(
        onPressed: onPressed,
        icon: SvgPicture.asset(
          iconPath,
          width: sizeType.size,
          height: sizeType.size,
          semanticsLabel: iconSemanticLabel,
          colorFilter:
              color == null ? null : ColorFilter.mode(color!, BlendMode.srcIn),
        ),
      );
}

extension IconSizeExtension on SizeType {
  double? get size {
    switch (this) {
      case SizeType.extraLarge:
        return 60;
      case SizeType.large:
        return 52;
      case SizeType.small:
        return 44;
      case SizeType.tiny:
        return 24;
      case SizeType.original:
        return null;
    }
  }
}
