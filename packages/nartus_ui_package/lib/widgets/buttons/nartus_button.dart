import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nartus_ui_package/dimens/dimens.dart';
import 'package:nartus_ui_package/theme/nartus_theme.dart';

part 'nartus_primary_button.dart';
part 'nartus_button_content.dart';
part 'nartus_secondary_button.dart';
part 'nartus_text_button.dart';
part 'nartus_button_styles.dart';

enum ButtonType { primary, secondary, text }

enum IconPosition { left, right }

enum SizeType { large, small, original }

class NartusButton extends StatelessWidget {
  final String? label;
  final String? iconPath;
  final String? iconSemanticLabel;
  final IconPosition iconPosition;
  final VoidCallback? onPressed;
  final ButtonType buttonType;
  final SizeType sizeType;

  const NartusButton.primary(
      {Key? key,
      this.label,
      this.iconPath,
      this.iconSemanticLabel,
      this.onPressed,
      this.iconPosition = IconPosition.left,
      this.sizeType = SizeType.large})
      : assert(label != null || iconPath != null,
            'either label or icon must not be null'),
        assert(iconPath == null || iconSemanticLabel != null),
        buttonType = ButtonType.primary,
        super(key: key);

  const NartusButton.secondary(
      {Key? key,
      this.label,
      this.iconPath,
      this.iconSemanticLabel,
      this.onPressed,
      this.iconPosition = IconPosition.left,
      this.sizeType = SizeType.large})
      : assert(label != null || iconPath != null,
            'either label or icon must not be null'),
        assert(iconPath == null || iconSemanticLabel != null),
        buttonType = ButtonType.secondary,
        super(key: key);

  const NartusButton.text(
      {Key? key,
      this.label,
      this.iconPath,
      this.iconSemanticLabel,
      this.onPressed,
      this.iconPosition = IconPosition.left,
      this.sizeType = SizeType.large})
      : assert(label != null || iconPath != null,
            'either label or icon must not be null'),
        assert(iconPath == null || iconSemanticLabel != null),
        buttonType = ButtonType.text,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    switch (buttonType) {
      case ButtonType.primary:
        return _NartusPrimaryButton(
          label: label,
          icon: iconPath,
          iconSemanticLabel: iconSemanticLabel,
          onPressed: onPressed,
          iconPosition: iconPosition,
          sizeType: sizeType,
        );
      case ButtonType.secondary:
        return _NartusSecondaryButton(
          label: label,
          icon: iconPath,
          iconSemanticLabel: iconSemanticLabel,
          onPressed: onPressed,
          iconPosition: iconPosition,
          sizeType: sizeType,
        );
      case ButtonType.text:
        return _NartusTextButton(
          label: label,
          icon: iconPath,
          iconSemanticLabel: iconSemanticLabel,
          onPressed: onPressed,
          iconPosition: iconPosition,
          sizeType: sizeType,
        );
    }
  }
}
