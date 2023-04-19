part of 'nartus_button.dart';

class _NartusPrimaryButton extends StatelessWidget {
  final String? label;
  final String? icon;
  final String? iconSemanticLabel;
  final IconPosition iconPosition;
  final VoidCallback? onPressed;
  final SizeType sizeType;

  const _NartusPrimaryButton(
      {Key? key,
      this.label,
      this.icon,
      this.iconSemanticLabel,
      this.onPressed,
      this.iconPosition = IconPosition.left,
      this.sizeType = SizeType.large})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (icon != null && label != null) {
      return Semantics(
        explicitChildNodes: false,
        excludeSemantics: true,
        label: iconPosition == IconPosition.left
            ? '$iconSemanticLabel, $label'
            : '$label, $iconSemanticLabel',
        button: true,
        enabled: onPressed != null,
        onTap: onPressed,
        child: ElevatedButton(
          onPressed: onPressed,
          style: sizeType == SizeType.large ? null : _buttonStyleTextSmall,
          child: _ButtonContent(
            label: label!,
            icon: icon!,
            buttonType: ButtonType.primary,
            isEnable: onPressed != null,
            iconPosition: iconPosition,
          ),
        ),
      );
    } else if (icon == null) {
      return ElevatedButton(
        onPressed: onPressed,
        style: sizeType == SizeType.large ? null : _buttonStyleTextSmall,
        child: Text(
          label!,
          textAlign: TextAlign.center,
        ),
      );
    } else if (sizeType == SizeType.original) {
      return Semantics(
        explicitChildNodes: false,
        excludeSemantics: true,
        label: iconSemanticLabel,
        button: true,
        enabled: onPressed != null,
        onTap: onPressed,
        child: ElevatedButton(
            onPressed: onPressed,
            child: SvgPicture.asset(
              icon!,
              semanticsLabel: iconSemanticLabel,
            )),
      );
    } else {
      return Semantics(
        explicitChildNodes: false,
        excludeSemantics: true,
        label: iconSemanticLabel,
        button: true,
        enabled: onPressed != null,
        onTap: onPressed,
        child: ElevatedButton(
            onPressed: onPressed,
            style: sizeType == SizeType.large
                ? _iconOnlyButtonStyleLarge
                : _iconOnlyButtonStyleSmall,
            child: SvgPicture.asset(
              icon!,
              width: NartusDimens.padding20,
              height: NartusDimens.padding20,
              colorFilter:
                  const ColorFilter.mode(NartusColor.white, BlendMode.srcIn),
              semanticsLabel: iconSemanticLabel,
            )),
      );
    }
  }
}
