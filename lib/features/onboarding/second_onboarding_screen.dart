import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:interactive_diary/generated/l10n.dart';
import 'package:interactive_diary/gen/assets.gen.dart';
import 'package:nartus_ui_package/dimens/dimens.dart';
import 'package:nartus_ui_package/nartus_ui.dart';

class SecondOnboardingScreen extends StatelessWidget {
  const SecondOnboardingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 4,
            child: SizedBox(
              width: double.infinity,
              child:
                  SvgPicture.asset(Assets.images.onboarding2, fit: BoxFit.fill),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(
                NartusDimens.padding32,
                NartusDimens.padding47,
                NartusDimens.padding32,
                NartusDimens.padding44),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  S.current.keepAllYourDiariesPrivate,
                  style: Theme.of(context).textTheme.displayLarge?.copyWith(
                        color: NartusColor.dark,
                      ),
                ),
                const SizedBox(height: NartusDimens.padding40,),
                NartusButton.primary(
                  label: S.current.continueWithEmail,
                  iconPath: Assets.images.idGoogleIcon,
                  onPressed: () {},
                ),
                const SizedBox(height: NartusDimens.padding12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      flex: 1,
                      child: NartusButton.primary(
                        iconPath: Assets.images.idGoogleIcon,
                        iconSemanticLabel: S.current.continueWithGoogle,
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: NartusButton.primary(
                        iconPath: Assets.images.idFacebookIcon,
                        iconSemanticLabel: S.current.continueWithFacebook,
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: NartusButton.primary(
                        iconPath: Assets.images.idAppleIcon,
                        iconSemanticLabel: S.current.continueWithApple,
                      ),
                    )
                  ],
                ),
                const SizedBox(height: NartusDimens.padding24),
                NartusButton.text(
                  label: S.current.continueAsGuest,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
