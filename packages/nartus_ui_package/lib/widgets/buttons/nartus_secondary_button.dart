part of 'nartus_button.dart';

class _NartusSecondaryButton extends StatelessWidget {
  final String? label;
  final Widget? icon;
  final IconPosition iconPosition;
  final VoidCallback? onPressed;
  final ButtonType buttonType;

  const _NartusSecondaryButton(
      {Key? key, this.label, this.icon, this.onPressed, this.iconPosition = IconPosition.left})
      : buttonType = ButtonType.primary, super(key: key);

  @override
  Widget build(BuildContext context) {
    if (icon != null && label != null) {
      return OutlinedButton(onPressed: onPressed, child: _ButtonContent(label: label!, icon: icon!, iconPosition: iconPosition,),);
    } else if (icon == null) {
      return OutlinedButton(onPressed: onPressed, child: Text(label!));
    } else {
      return OutlinedButton(onPressed: onPressed, child: icon!);
    }
  }
}
