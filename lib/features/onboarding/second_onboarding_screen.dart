import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:interactive_diary/generated/l10n.dart';
import 'package:interactive_diary/gen/assets.gen.dart';
import 'package:nartus_ui_package/dimens/dimens.dart';
import 'package:nartus_ui_package/nartus_ui.dart';

import 'package:interactive_diary/utils/platform_utils.dart';

class SecondOnboardingScreen extends StatelessWidget {
  const SecondOnboardingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Flexible(
              flex: 4,
              child: SizedBox(
                width: double.infinity,
                child: SvgPicture.asset(Assets.images.onboarding2,
                    fit: BoxFit.fill),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(
                  NartusDimens.padding32,
                  NartusDimens.padding47,
                  NartusDimens.padding32,
                  NartusDimens.padding44),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    S.current.keepAllYourDiariesPrivate,
                    style: Theme.of(context).textTheme.displayMedium?.copyWith(
                      color: NartusColor.dark,
                    ),
                  ),
                  const SizedBox(
                    height: NartusDimens.padding40,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: NartusButton.primary(
                      label: S.current.continueWithEmail,
                      iconPath: Assets.images.idSmsIcon,
                      iconSemanticLabel: '',
                      onPressed: () {},
                    ),
                  ),
                  const SizedBox(height: NartusDimens.padding12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        flex: 1,
                        child: _iconWidget(
                          Assets.images.idGoogleIcon,
                          S.current.continueWithGoogle,
                        ),
                      ),
                      const SizedBox(width: NartusDimens.padding16),
                      Expanded(
                          flex: 1,
                          child: _iconWidget(
                            Assets.images.idFacebookIcon,
                            S.current.continueWithFacebook,
                          )),
                      if (isIOS(context))
                        const SizedBox(width: NartusDimens.padding16),
                      if (isIOS(context))
                        Expanded(
                          flex: 1,
                          child: _iconWidget(
                            Assets.images.idAppleIcon,
                            S.current.continueWithApple,
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: NartusDimens.padding24),
                  NartusButton.text(
                    label: S.current.continueAsGuest,
                    sizeType: SizeType.small,
                    onPressed: () {},
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _iconWidget(String iconPath, String iconSemanticLabel) => Semantics(
    label: iconSemanticLabel,
    child: Container(
      decoration: BoxDecoration(
        color: NartusColor.white,
        border: Border.all(
          color: NartusColor.lightGrey,
          width: 1.0,
        ),
        borderRadius: const BorderRadius.all(Radius.circular(999)),
      ),
      child: IconButton(
        icon: SvgPicture.asset(iconPath),
        onPressed: () {},
      ),
    ),
  );
}
