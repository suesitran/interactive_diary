import 'package:flutter/material.dart';
import 'package:interactive_diary/utils/platform_utils.dart';
import 'package:nartus_ui_package/dimens/dimens.dart';
import 'package:nartus_ui_package/widgets/buttons/nartus_button.dart';

import 'package:interactive_diary/gen/assets.gen.dart';
import 'package:interactive_diary/generated/l10n.dart';

class LoginOptions extends StatelessWidget {
  const LoginOptions({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Expanded(
          child: _iconWidget(
              Assets.images.idGoogleIcon, S.current.continueWithGoogle, () {
            // handle event click
          }),
        ),
        const SizedBox(width: NartusDimens.padding16),
        Expanded(
            child: _iconWidget(
                Assets.images.idFacebookIcon, S.current.continueWithFacebook,
                () {
          // handle event click
        })),
        if (context.isIOS) ...[
          const SizedBox(width: NartusDimens.padding16),
          Expanded(
            child: _iconWidget(
                Assets.images.idAppleIcon, S.current.continueWithApple, () {
              // handle event click
            }),
          ),
        ]
      ],
    );
  }

  Widget _iconWidget(
          String iconPath, String iconSemanticLabel, VoidCallback onPressed) =>
      NartusButton.secondary(
        iconPath: iconPath,
        iconSemanticLabel: iconSemanticLabel,
        onPressed: onPressed,
        sizeType: SizeType.original,
      );
}
