import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:interactive_diary/generated/l10n.dart';
import 'package:nartus_ui_package/dimens/dimens.dart';
import 'package:nartus_ui_package/nartus_ui.dart';

import 'package:interactive_diary/gen/assets.gen.dart';

class FirstOnboardingScreen extends StatelessWidget {
  const FirstOnboardingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(
              flex: 4,
              child: SizedBox(
                width: double.infinity,
                child: SvgPicture.asset(
                  Assets.images.onboarding1,
                  fit: BoxFit.fill,
                ),
              )),
          const Gap.v20(),
          Expanded(
              flex: 3,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: NartusDimens.padding20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      S.current.welcomeText,
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium
                          ?.copyWith(color: NartusColor.primary),
                    ),
                    const Gap.v12(),
                    Flexible(
                        child: Text(S.current.onboardingIntroduction,
                            style: Theme.of(context)
                                .textTheme
                                .displayMedium
                                ?.copyWith(color: NartusColor.dark))),
                    const Gap.v12(),
                    const Gap.v20(),
                    SafeArea(
                        top: false,
                        child: SizedBox(
                          width: double.infinity,
                          child: NartusButton.primary(
                            label: S.current.getStartedText,
                            onPressed: () {},
                          ),
                        )),
                  ],
                ),
              ))
        ],
      ),
    );
  }
}
