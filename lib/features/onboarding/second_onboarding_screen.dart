import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:interactive_diary/generated/l10n.dart';
import 'package:interactive_diary/gen/assets.gen.dart';
import 'package:nartus_ui_package/dimens/dimens.dart';
import 'package:nartus_ui_package/nartus_ui.dart';

import 'package:interactive_diary/utils/platform_utils.dart';

class SecondOnboardingScreen extends StatefulWidget {
  const SecondOnboardingScreen({super.key});

  @override
  State<SecondOnboardingScreen> createState() => _SecondOnboardingScreenState();
}

class _SecondOnboardingScreenState extends State<SecondOnboardingScreen> {
  late final PageController _pageController;
  var _currentPageIndex = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _currentPageIndex);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        Flexible(
          child: PageView(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() {
                _currentPageIndex = index;
              });
            },
            physics: const ClampingScrollPhysics(),
            children: [
              _childPager(context, Assets.images.onboarding2, S.current.keepAllYourDiariesPrivate),
              _childPager(context, Assets.images.onboarding3, S.current.accessYourDiariesAnywhere),
            ],
          ),
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: const EdgeInsets.only(left: NartusDimens.padding32),
            child: DotsIndicator(
                dotsCount: 2,
                position: _currentPageIndex.toDouble(),
                decorator: const DotsDecorator(
                  activeColor: NartusColor.primary,
                  color: Colors.grey,
                  activeSize: Size.square(8.0),
                  size: Size.square(8.0),
                )),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(
              NartusDimens.padding32,
              NartusDimens.padding30,
              NartusDimens.padding32,
              NartusDimens.padding40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
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
    );
  }

  Widget _childPager(BuildContext context, String imagePath, String title) =>
      Semantics(
        child: Column(
          children: [
            SizedBox(
              width: double.infinity,
              child: SvgPicture.asset(imagePath, fit: BoxFit.fill),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(
                  NartusDimens.padding32,
                  NartusDimens.padding30,
                  NartusDimens.padding32,
                  NartusDimens.padding30),
              child: Text(
                title,
                style: Theme.of(context).textTheme.displayMedium?.copyWith(color: NartusColor.dark,),
              ),
            ),
          ],
        ),
      );

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
