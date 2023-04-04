import 'package:flutter/material.dart';
import 'package:interactive_diary/features/onboarding/first_onboarding_screen.dart';
import 'package:interactive_diary/features/onboarding/second_onboarding_screen.dart';

class OnboardingScreen extends StatelessWidget {
  OnboardingScreen({Key? key}) : super(key: key);

  final PageController pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          FirstOnboardingScreen(onNextPageRequest: () {
            pageController.animateToPage(1,
                duration: const Duration(milliseconds: 200),
                curve: Curves.easeIn);
          }),
          const SecondOnboardingScreen()
        ],
      ),
    );
  }
}
