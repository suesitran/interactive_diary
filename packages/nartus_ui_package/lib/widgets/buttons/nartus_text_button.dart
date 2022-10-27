part of 'nartus_button.dart';

class _NartusTextButton extends StatelessWidget {
  final String? label;
  final Widget? icon;
  final IconPosition iconPosition;
  final VoidCallback? onPressed;
  final ButtonType buttonType;
  final SizeType sizeType;

  const _NartusTextButton(
      {Key? key,
      this.label,
      this.icon,
      this.onPressed,
      this.iconPosition = IconPosition.left,
        this.sizeType = SizeType.large})
      : buttonType = ButtonType.primary,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    if (icon != null && label != null) {
      return TextButton(
        onPressed: onPressed,
        child: _ButtonContent(
          label: label!,
          icon: icon!,
          iconPosition: iconPosition,
        ),
      );
    } else if (icon == null) {
      return TextButton(onPressed: onPressed, child: Text(label!));
    } else {
      return TextButton(onPressed: onPressed, style: sizeType == SizeType.large ? _iconOnlyButtonStyleLarge : _iconOnlyButtonStyleSmall, child: SizedBox(
        width: NartusDimens.padding20,
        height: NartusDimens.padding20,
        child: icon!,
      ),);
    }
  }
}
