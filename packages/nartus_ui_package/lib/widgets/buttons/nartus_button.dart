import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nartus_ui_package/dimens/dimens.dart';
import 'package:nartus_ui_package/theme/nartus_theme.dart';

part 'nartus_primary_button.dart';
part 'nartus_button_content.dart';
part 'nartus_secondary_button.dart';
part 'nartus_text_button.dart';
part 'nartus_button_styles.dart';
part 'nartus_icon_button.dart';

enum ButtonType { primary, secondary, text, icon }

enum IconPosition { left, right }

enum SizeType { extraLarge, large, small, tiny, original }

class NartusButton extends StatelessWidget {
  final String? label;
  final String? iconPath;
  final String? iconSemanticLabel;
  final IconPosition iconPosition;
  final VoidCallback? onPressed;
  final ButtonType buttonType;
  final SizeType sizeType;
  final Color? iconColor;

  /// label: String to be displayed as main text
  /// iconPath: Path to svg asset for icon
  /// iconSemanticLabel: semantic label for icon
  /// onPressed: VoidCallback action
  /// iconPosition: IconPosition
  /// sizeType: SizeType
  /// iconColor: Color overlay for icon. Null to keep original icon color
  const NartusButton.primary(
      {Key? key,
      this.label,
      this.iconPath,
      this.iconSemanticLabel,
      this.onPressed,
      this.iconPosition = IconPosition.left,
      this.sizeType = SizeType.large,
      this.iconColor})
      : assert(label != null || iconPath != null,
            'either label or icon must not be null'),
        assert(iconPath == null || iconSemanticLabel != null),
        buttonType = ButtonType.primary,
        super(key: key);

  /// label: String to be displayed as main text
  /// iconPath: Path to svg asset for icon
  /// iconSemanticLabel: semantic label for icon
  /// onPressed: VoidCallback action
  /// iconPosition: IconPosition
  /// sizeType: SizeType
  /// iconColor: Color overlay for icon. Null to keep original icon color
  const NartusButton.secondary(
      {Key? key,
      this.label,
      this.iconPath,
      this.iconSemanticLabel,
      this.onPressed,
      this.iconPosition = IconPosition.left,
      this.sizeType = SizeType.large,
      this.iconColor})
      : assert(label != null || iconPath != null,
            'either label or icon must not be null'),
        assert(iconPath == null || iconSemanticLabel != null),
        buttonType = ButtonType.secondary,
        super(key: key);

  /// label: String to be displayed as main text
  /// iconPath: Path to svg asset for icon
  /// iconSemanticLabel: semantic label for icon
  /// onPressed: VoidCallback action
  /// iconPosition: IconPosition
  /// sizeType: SizeType
  /// iconColor: Color overlay for icon. Null to keep original icon color
  const NartusButton.text(
      {Key? key,
      this.label,
      this.iconPath,
      this.iconSemanticLabel,
      this.onPressed,
      this.iconPosition = IconPosition.left,
      this.sizeType = SizeType.large,
      this.iconColor})
      : assert(label != null || iconPath != null,
            'either label or icon must not be null'),
        assert(iconPath == null || iconSemanticLabel != null),
        buttonType = ButtonType.text,
        super(key: key);

  /// label: String to be displayed as main text
  /// iconPath: Path to svg asset for icon
  /// iconSemanticLabel: semantic label for icon
  /// onPressed: VoidCallback action
  /// iconPosition: IconPosition
  /// sizeType: SizeType
  /// iconColor: Color overlay for icon. Null to keep original icon color
  NartusButton.icon(
      {required this.iconPath,
      this.iconSemanticLabel,
      this.onPressed,
      this.sizeType = SizeType.large,
      this.iconColor,
      Key? key})
      : assert(iconPath == null ||
            iconPath.isEmpty == true ||
            iconSemanticLabel != null),
        label = null,
        iconPosition = IconPosition.left,
        buttonType = ButtonType.icon,
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
      case ButtonType.icon:
        return _NartusIconButton(
            iconPath: iconPath!,
            iconSemanticLabel: iconSemanticLabel,
            onPressed: onPressed,
            sizeType: sizeType,
            color: iconColor);
    }
  }
}
