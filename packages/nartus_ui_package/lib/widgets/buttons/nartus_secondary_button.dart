part of 'nartus_button.dart';

class _NartusSecondaryButton extends StatelessWidget {
  final String? label;
  final String? icon;
  final IconPosition iconPosition;
  final VoidCallback? onPressed;
  final SizeType sizeType;

  const _NartusSecondaryButton(
      {Key? key,
      this.label,
      this.icon,
      this.onPressed,
      this.iconPosition = IconPosition.left,
      this.sizeType = SizeType.large})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (icon != null && label != null) {
      return OutlinedButton(
        onPressed: onPressed,
        child: _ButtonContent(
          label: label!,
          icon: icon!,
          buttonType: ButtonType.secondary,
          isEnable: onPressed != null,
          iconPosition: iconPosition,
        ),
      );
    } else if (icon == null) {
      return OutlinedButton(
        onPressed: onPressed,
        style: sizeType == SizeType.large ? null : _buttonStyleTextSmall,
        child: Text(label!),
      );
    } else {
      return OutlinedButton(
          onPressed: onPressed,
          style: sizeType == SizeType.large
              ? _iconOnlyButtonStyleLarge
              : _iconOnlyButtonStyleSmall,
          child: SvgPicture.asset(
            icon!,
            width: NartusDimens.padding20,
            height: NartusDimens.padding20,
            color: onPressed == null ? NartusColor.grey : NartusColor.primary,
          ));
    }
  }
}
