import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nartus_ui_package/dimens/dimens.dart';
import 'package:nartus_ui_package/theme/nartus_theme.dart';

import 'package:interactive_diary/gen/assets.gen.dart';
import 'package:interactive_diary/generated/l10n.dart';

class SecondOnBoardingPagerView extends StatelessWidget  {

  final PageController controller;
  final ValueChanged<int> onPageChanged;
  SecondOnBoardingPagerView({required this.controller, required this.onPageChanged, Key? key})
      : super(key: key);

  final ValueNotifier<double> pageHeight = ValueNotifier(0.0);

  @override
  Widget build(BuildContext context) => ValueListenableBuilder(
        valueListenable: pageHeight,
        builder: (context, value, child) => SizedBox(
          height: value,
          child: PageView(
            controller: controller,
            onPageChanged: onPageChanged,
            physics: const ClampingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            children: [
              SecondOnBoardingPagerItem(
                  imagePath: Assets.images.onboarding2,
                  title: S.current.keepAllYourDiariesPrivate,
              onHeightChange: (height) {
                    if (pageHeight.value < height) {
                      pageHeight.value = height;
                    }
              },),
              SecondOnBoardingPagerItem(
                  imagePath: Assets.images.onboarding3,
                  title: S.current.accessYourDiariesAnywhere,
                onHeightChange: (height) {
                  if (pageHeight.value == null
                      || (pageHeight.value ?? 0) < height) {
                    pageHeight.value = height;
                  }
                },),
            ],
          ),
        ),
      );
}

class SecondOnBoardingPagerItem extends StatefulWidget {
  final String imagePath;
  final String title;
  final ValueChanged<double> onHeightChange;

  const SecondOnBoardingPagerItem(
      {required this.imagePath, required this.title, required this.onHeightChange, Key? key})
      : super(key: key);

  @override
  State<SecondOnBoardingPagerItem> createState() => _SecondOnBoardingPagerItemState();
}

class _SecondOnBoardingPagerItemState extends State<SecondOnBoardingPagerItem> {

  final GlobalKey firstChildKey = GlobalKey();
  final GlobalKey secondChildKey = GlobalKey();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback(calculateHeight);
  }

  void calculateHeight(Duration timestamp) {
    double firstChildHeight = firstChildKey.currentContext?.size?.height ?? 0;
    double secondChildHeight = secondChildKey.currentContext?.size?.height ?? 0;

    if (firstChildHeight > 0 && secondChildHeight > 0 ) {
      widget.onHeightChange(firstChildHeight + secondChildHeight);
    } else {
      WidgetsBinding.instance.addPostFrameCallback(calculateHeight);
    }
  }

  @override
  Widget build(BuildContext context) => Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SvgPicture.asset(
            key: firstChildKey,
            widget.imagePath,
            fit: BoxFit.fill,
            excludeFromSemantics: true,
            width: MediaQuery.of(context).size.width,
          ),
          Padding(
            key: secondChildKey,
            padding: const EdgeInsets.fromLTRB(
                NartusDimens.padding32,
                NartusDimens.padding30,
                NartusDimens.padding32,
                NartusDimens.padding30),
            child: Text(
              widget.title,
              style: Theme.of(context).textTheme.displayMedium?.copyWith(
                    color: NartusColor.dark,
                  ),
            ),
          ),
        ],
      );
}
