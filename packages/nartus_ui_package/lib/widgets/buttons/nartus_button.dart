import 'package:flutter/material.dart';
import 'package:nartus_ui_package/dimens/dimens.dart';
import 'package:nartus_ui_package/theme/nartus_theme.dart';

part 'nartus_primary_button.dart';
part 'nartus_button_content.dart';
part 'nartus_secondary_button.dart';
part 'nartus_text_button.dart';
part 'nartus_button_styles.dart';

enum ButtonType { primary, secondary, text }

enum IconPosition { left, right }

enum SizeType { large, small }

class NartusButton extends StatelessWidget {
  final String? label;
  final Widget? icon;
  final IconPosition iconPosition;
  final VoidCallback? onPressed;
  final ButtonType buttonType;
  final SizeType sizeType;

  const NartusButton.primary(
      {Key? key,
      this.label,
      this.icon,
      this.onPressed,
      this.iconPosition = IconPosition.left,
      this.sizeType = SizeType.large})
      : assert(label != null || icon != null,
            'either label or icon must not be null'),
        buttonType = ButtonType.primary,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    switch (buttonType) {
      case ButtonType.primary:
        return _NartusPrimaryButton(
          label: label,
          icon: icon,
          onPressed: onPressed,
          iconPosition: iconPosition,
            sizeType: sizeType,
        );
      case ButtonType.secondary:
        return _NartusSecondaryButton(
          label: label,
          icon: icon,
          onPressed: onPressed,
          iconPosition: iconPosition,
            sizeType: sizeType,
        );
      case ButtonType.text:
        return _NartusTextButton(
          label: label,
          icon: icon,
          onPressed: onPressed,
          iconPosition: iconPosition,
          sizeType: sizeType,
        );
    }
  }
}