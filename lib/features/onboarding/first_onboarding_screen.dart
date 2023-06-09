import 'package:flutter_svg/flutter_svg.dart';
import 'package:interactive_diary/generated/l10n.dart';
import 'package:nartus_ui_package/dimens/dimens.dart';
import 'package:nartus_ui_package/nartus_ui.dart';

import 'package:interactive_diary/gen/assets.gen.dart';

class FirstOnboardingScreen extends StatelessWidget {
  final VoidCallback onNextPageRequest;
  const FirstOnboardingScreen({required this.onNextPageRequest, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          AspectRatio(
              aspectRatio: 1,
              child: SvgPicture.asset(
                Assets.images.onboarding1,
                width: double.infinity,
                fit: BoxFit.fitWidth,
                alignment: Alignment.bottomCenter,
              )),
          const Gap.v20(),
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: NartusDimens.padding32),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  S.current.welcomeText,
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium
                      ?.copyWith(color: NartusColor.primary),
                ),
                const Gap.v12(),
                Text(
                  S.current.onboardingIntroduction,
                  style: Theme.of(context)
                      .textTheme
                      .displayMedium
                      ?.copyWith(color: NartusColor.dark),
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
                const Gap.v32(),
                NartusButton.primary(
                  label: S.current.getStartedText,
                  onPressed: onNextPageRequest,
                ),
                const Gap.v32(),
              ],
            ),
          )
        ],
      ),
    );
  }
}
