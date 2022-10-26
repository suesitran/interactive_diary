import 'package:flutter/material.dart';

part 'nartus_primary_button.dart';
part 'nartus_button_content.dart';
part 'nartus_secondary_button.dart';
part 'nartus_text_button.dart';

enum ButtonType { primary, secondary, text }
enum IconPosition { left, right }

class NartusButton extends StatelessWidget {
  final String? label;
  final Widget? icon;
  final IconPosition iconPosition;
  final VoidCallback? onPressed;
  final ButtonType buttonType;

  const NartusButton.primary(
      {Key? key, this.label, this.icon, this.onPressed, this.iconPosition = IconPosition.left})
      : assert(label != null || icon != null,
            'either label or icon must not be null'),
        buttonType = ButtonType.primary, super(key: key);

  @override
  Widget build(BuildContext context) {
    switch (buttonType) {
      case ButtonType.primary: return _NartusPrimaryButton(label: label, icon: icon, onPressed: onPressed, iconPosition: iconPosition,);
      case ButtonType.secondary: return _NartusSecondaryButton(label: label, icon: icon, onPressed: onPressed, iconPosition: iconPosition,);
      case ButtonType.text: return _NartusTextButton(label: label, icon: icon, onPressed: onPressed, iconPosition: iconPosition,);
    }
  }
}
