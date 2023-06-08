import 'package:dots_indicator/dots_indicator.dart';
import 'package:expandable_page_view/expandable_page_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:interactive_diary/bloc/app_config/app_config_bloc.dart';
import 'package:interactive_diary/features/onboarding/login_options.dart';
import 'package:interactive_diary/features/onboarding/login_with_email_bottom_sheet.dart';
import 'package:interactive_diary/generated/l10n.dart';
import 'package:interactive_diary/gen/assets.gen.dart';
import 'package:interactive_diary/route/route_extension.dart';
import 'package:nartus_ui_package/dimens/dimens.dart';
import 'package:nartus_ui_package/nartus_ui.dart';

class SecondOnboardingScreen extends StatefulWidget {
  const SecondOnboardingScreen({super.key});

  @override
  State<SecondOnboardingScreen> createState() => _SecondOnboardingScreenState();
}

class _SecondOnboardingScreenState extends State<SecondOnboardingScreen> {
  late final PageController _pageController;
  late final ValueNotifier<int> _currentPageNotifier;
  static const int _numPages = 2;

  @override
  void initState() {
    super.initState();
    _currentPageNotifier = ValueNotifier<int>(0);
    _pageController = PageController(initialPage: _currentPageNotifier.value);
  }

  @override
  void dispose() {
    _currentPageNotifier.dispose();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AppConfigBloc, AppConfigState>(
      listener: (context, state) {
        if (state is AppFirstLaunchCleared) {
          context.goToHome();
        }
      },
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Flexible(
              child: SizedBox(
                child: ExpandablePageView(
                  controller: _pageController,
                  onPageChanged: (index) {
                    _currentPageNotifier.value = index;
                  },
                  physics: const ClampingScrollPhysics(),
                  children: [
                    _childPager(context, Assets.images.onboarding2,
                        S.current.keepAllYourDiariesPrivate),
                    _childPager(context, Assets.images.onboarding3,
                        S.current.accessYourDiariesAnywhere),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: NartusDimens.padding32),
              child: ValueListenableBuilder<int>(
                valueListenable: _currentPageNotifier,
                builder: (context, pageIndex, _) {
                  return DotsIndicator(
                      dotsCount: _numPages,
                      position: pageIndex.toDouble(),
                      decorator: const DotsDecorator(
                        activeColor: NartusColor.primary,
                        color: Colors.grey,
                        activeSize: Size.square(8.0),
                        size: Size.square(8.0),
                      ));
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(
                  NartusDimens.padding32,
                  NartusDimens.padding30,
                  NartusDimens.padding32,
                  NartusDimens.padding40),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  NartusButton.primary(
                    label: S.current.continueWithEmail,
                    iconPath: Assets.images.idSmsIcon,
                    iconSemanticLabel: '',
                    onPressed: () {
                      context.showLoginWithEmailBottomSheet();
                    },
                  ),
                  const SizedBox(height: NartusDimens.padding12),
                  const LoginOptions(),
                  const SizedBox(height: NartusDimens.padding24),
                  TextButtonTheme(
                      data: TextButtonThemeData(
                        style: ButtonStyle(
                            foregroundColor: MaterialStateProperty.all<Color>(
                                NartusColor.grey),
                            textStyle: MaterialStateProperty.all<TextStyle>(
                                Theme.of(context).textTheme.bodyMedium!)),
                      ),
                      child: NartusButton.text(
                        label: S.current.continueAsGuest,
                        sizeType: SizeType.small,
                        onPressed: () {
                          context
                              .read<AppConfigBloc>()
                              .add(CancelFirstLaunch());
                        },
                      ))
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _childPager(BuildContext context, String imagePath, String title) =>
      Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AspectRatio(
              aspectRatio: 1,
              child: SvgPicture.asset(
                imagePath,
                fit: BoxFit.cover,
                alignment: Alignment.bottomCenter,
                excludeFromSemantics: true,
                width: MediaQuery.of(context).size.width,
              )),
          Semantics(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(
                  NartusDimens.padding32,
                  NartusDimens.padding30,
                  NartusDimens.padding32,
                  NartusDimens.padding30),
              child: Text(
                title,
                style: Theme.of(context).textTheme.displayMedium?.copyWith(
                      color: NartusColor.dark,
                    ),
              ),
            ),
          ),
        ],
      );
}
