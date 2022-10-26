part of 'nartus_button.dart';

class _NartusPrimaryButton extends StatelessWidget {
  final String? label;
  final Widget? icon;
  final IconPosition iconPosition;
  final VoidCallback? onPressed;
  final ButtonType buttonType;

  const _NartusPrimaryButton(
      {Key? key,
      this.label,
      this.icon,
      this.onPressed,
      this.iconPosition = IconPosition.left})
      : buttonType = ButtonType.primary,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    if (icon != null && label != null) {
      return ElevatedButton(
        onPressed: onPressed,
        child: _ButtonContent(
          label: label!,
          icon: icon!,
          iconPosition: iconPosition,
        ),
      );
    } else if (icon == null) {
      return ElevatedButton(onPressed: onPressed, child: Text(label!));
    } else {
      return ElevatedButton(onPressed: onPressed, child: icon!);
    }
  }
}
